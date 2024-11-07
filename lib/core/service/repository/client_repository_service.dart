import 'dart:convert';
import 'package:galaxy_food_restaurants/core/service/repository/repository_service.dart';
import 'package:galaxy_food_restaurants/core/utils/bytes.dart';
import 'package:http/http.dart' as http;

import '../../domain/client.dart';
import '../../utils/exception/repository_exception.dart';

class ClientRepositoryService {

  static const String kApiRequest = "http://${RepositoryService.kIpAddressServer}:${RepositoryService.kPortServer}/client";

  static Future<Client> get(String id) async {
    final endpointUri = Uri.parse("$kApiRequest/get/$id");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8',
      },
    ).timeout(
        const Duration(seconds: 5),
        onTimeout: (){
          throw RepositoryException(status: 408, message: "Falha ao conectar com servidor!");
        }
    );

    if (response.statusCode == 200){
      return Client.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }


}