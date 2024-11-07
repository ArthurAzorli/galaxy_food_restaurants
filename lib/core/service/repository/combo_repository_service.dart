import 'dart:convert';

import 'package:galaxy_food_restaurants/core/service/repository/repository_service.dart';
import 'package:galaxy_food_restaurants/core/utils/bytes.dart';
import 'package:http/http.dart' as http;
import '../../domain/combo.dart';
import '../../utils/exception/repository_exception.dart';

class ComboRepositoryService{
  //TODO:: refactor here
  static const String kApiRequest = "http://${RepositoryService.kIpAddressServer}:${RepositoryService.kPortServer}/combo";

  static Future<List<Combo>> getOf(String idRestaurant) async {
    final endpointUri = Uri.parse("$kApiRequest/get/$idRestaurant");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    ).timeout(
        const Duration(seconds: 5),
        onTimeout: (){
          throw RepositoryException(status: 408, message: "Falha ao conectar com servidor!");
        }
    );

    if (response.statusCode == 200){

      List<Map<String, dynamic>> json = jsonDecode(response.bodyBytes.toUTF8);
      return json.map((combo){
        return Combo.fromJson(combo);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Combo> get(String idRestaurant, String id) async {
    final endpointUri = Uri.parse("$kApiRequest/get/$idRestaurant/$id");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    ).timeout(
        const Duration(seconds: 5),
        onTimeout: (){
          throw RepositoryException(status: 408, message: "Falha ao conectar com servidor!");
        }
    );

    if (response.statusCode == 200){
      return Combo.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

}