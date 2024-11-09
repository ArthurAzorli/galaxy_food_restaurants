import 'dart:convert';

import 'package:galaxy_food_restaurants/core/service/repository/repository_service.dart';
import 'package:galaxy_food_restaurants/core/service/repository/restaurant_repository_service.dart';
import 'package:galaxy_food_restaurants/core/utils/bytes.dart';
import 'package:http/http.dart' as http;
import '../../domain/package.dart';
import '../../utils/exception/repository_exception.dart';

class PackageRepositoryService{

  static const String kApiRequest = "http://${RepositoryService.kIpAddressServer}:${RepositoryService.kPortServer}/package";

  static Future<Package> create(Package package) async {
    final idRestaurant = await RestaurantRepositoryService.getUserID();
    final endpointUri = Uri.parse("$kApiRequest/create/$idRestaurant");

    final response = await http.post(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
        body: jsonEncode(package.toJson())
    ).timeout(
        const Duration(seconds: 5),
        onTimeout: (){
          throw RepositoryException(status: 408, message: "Falha ao conectar com servidor!");
        }
    );

    if (response.statusCode == 201){
      return Package.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<List<Package>> getAll() async {
    final idRestaurant = await RestaurantRepositoryService.getUserID();
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
      return json.map((package){
        return Package.fromJson(package);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Package> get(String id) async {
    final idRestaurant = await RestaurantRepositoryService.getUserID();
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
      return Package.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Package> root() async {
    final idRestaurant = await RestaurantRepositoryService.getUserID();
    final endpointUri = Uri.parse("$kApiRequest/root/$idRestaurant");

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
      return Package.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Package> update(Package package) async {
    final idRestaurant = await RestaurantRepositoryService.getUserID();
    final endpointUri = Uri.parse("$kApiRequest/update/$idRestaurant/${package.id}");

    final response = await http.put(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
        body: jsonEncode(package.toJson())
    ).timeout(
        const Duration(seconds: 5),
        onTimeout: (){
          throw RepositoryException(status: 408, message: "Falha ao conectar com servidor!");
        }
    );

    if (response.statusCode == 202){
      return Package.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Package> move(Package package, Package parent) async {
    final idRestaurant = await RestaurantRepositoryService.getUserID();
    final endpointUri = Uri.parse("$kApiRequest/move/$idRestaurant/${package.id}/${parent.id}");

    final response = await http.put(
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

    if (response.statusCode == 202){
      return Package.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<bool> delete(Package package) async {
    final idRestaurant = await RestaurantRepositoryService.getUserID();
    final endpointUri = Uri.parse("$kApiRequest/delete/$idRestaurant/${package.id}");

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