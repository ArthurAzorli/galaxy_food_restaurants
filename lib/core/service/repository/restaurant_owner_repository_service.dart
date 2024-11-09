import 'dart:convert';

import 'package:galaxy_food_restaurants/core/service/repository/repository_service.dart';
import 'package:galaxy_food_restaurants/core/utils/bytes.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../../domain/restaurant.dart';
import '../../domain/restaurant_owner.dart';
import '../../utils/exception/repository_exception.dart';

class RestaurantOwnerRepositoryService{

  static const String kApiRequest = "http://${RepositoryService.kIpAddressServer}:${RepositoryService.kPortServer}/restaurantowner";

  static Future<RestaurantOwner> create(RestaurantOwner owner) async {
    final endpointUri = Uri.parse("$kApiRequest/create");

    final response = await http.post(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
        body: jsonEncode(owner.toJson())
    ).timeout(
        const Duration(seconds: 5),
        onTimeout: (){
          throw RepositoryException(status: 408, message: "Falha ao conectar com servidor!");
        }
    );

    if (response.statusCode == 201){
      return RestaurantOwner.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<RestaurantOwner> get(String id) async {
    var url = "$kApiRequest/get/$id";

    final endpointUri = Uri.parse(url);

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
      return RestaurantOwner.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<RestaurantOwner> update(RestaurantOwner owner) async {
    final endpointUri = Uri.parse("$kApiRequest/update/${owner.id}");

    final response = await http.put(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
        body: jsonEncode(owner.toJson())
    ).timeout(
        const Duration(seconds: 5),
        onTimeout: (){
          throw RepositoryException(status: 408, message: "Falha ao conectar com servidor!");
        }
    );

    if (response.statusCode == 202){
      return RestaurantOwner.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<bool> delete({required String user, required String password}) async {
    final endpointUri = Uri.parse("$kApiRequest/delete");

    final response = await http.delete(
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
      return jsonDecode(response.bodyBytes.toUTF8)["result"];
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }
}