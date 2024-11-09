import 'dart:convert';

import 'package:galaxy_food_restaurants/core/service/repository/repository_service.dart';
import 'package:galaxy_food_restaurants/core/utils/bytes.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/phone.dart';
import '../../domain/restaurant.dart';
import '../../utils/exception/repository_exception.dart';

class RestaurantRepositoryService{

  static const String kApiRequest = "http://${RepositoryService.kIpAddressServer}:${RepositoryService.kPortServer}/restaurant";

  static Future<bool> login({required String user, required String password}) async {
    final endpointUri = Uri.parse("$kApiRequest/login");

    final json = {
      "login": user,
      "password": password
    };

    final response = await http.post(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
        body: jsonEncode(json)
    ).timeout(
        const Duration(seconds: 5),
        onTimeout: (){
          throw RepositoryException(status: 408, message: "Falha ao conectar com servidor!");
        }
    );

    if (response.statusCode == 200){
      final jsonResponse = jsonDecode(response.bodyBytes.toUTF8);
      final prefs = await GetIt.I.getAsync<SharedPreferencesWithCache>();
      prefs.setString("user", jsonResponse["data"]);
      return jsonResponse["result"];
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Restaurant> getUser() async {
    final prefs = await GetIt.I.getAsync<SharedPreferencesWithCache>();
    final idUser = prefs.getString("user");
    if (idUser == null) throw RepositoryException(status: 404, message:  "Você está Deslogado!");
    return RestaurantRepositoryService.get(idUser);
  }

  static Future<String> getUserID() async {
    final prefs = await GetIt.I.getAsync<SharedPreferencesWithCache>();
    final idUser = prefs.getString("user");
    if (idUser == null) throw RepositoryException(status: 404, message:  "Você está Deslogado!");
    return idUser;
  }

  static Future<Restaurant> create(Restaurant restaurant) async {
    final endpointUri = Uri.parse("$kApiRequest/create");

    final response = await http.post(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
        body: jsonEncode(restaurant.toJson())
    ).timeout(
        const Duration(seconds: 5),
        onTimeout: (){
          throw RepositoryException(status: 408, message: "Falha ao conectar com servidor!");
        }
    );

    if (response.statusCode == 201){
      final restaurant = Restaurant.fromJson(jsonDecode(response.bodyBytes.toUTF8));
      final prefs = await GetIt.I.getAsync<SharedPreferencesWithCache>();
      prefs.setString("user", restaurant.id!);
      return restaurant;
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<List<Restaurant>> getAll() async {
    final endpointUri = Uri.parse("$kApiRequest/get");

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
      List json = jsonDecode(response.bodyBytes.toUTF8);
      return json.map((restaurant){
        return Restaurant.fromJson(restaurant);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Restaurant> get(String id) async {
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
      return Restaurant.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Restaurant> update(Restaurant restaurant) async {
    final endpointUri = Uri.parse("$kApiRequest/update/${restaurant.id}");

    final response = await http.put(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
        body: jsonEncode(restaurant.toJson())
    ).timeout(
        const Duration(seconds: 5),
        onTimeout: (){
          throw RepositoryException(status: 408, message: "Falha ao conectar com servidor!");
        }
    );

    if (response.statusCode == 202){
      return Restaurant.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<bool> changePassword({required String oldPassword, required String newPassword}) async {
    final idClient = await getUserID();
    final endpointUri = Uri.parse("$kApiRequest/changepassword/$idClient");

    final json = {
      "oldPassword" : oldPassword,
      "newPassword" : newPassword
    };

    final response = await http.put(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
        body: jsonEncode(json)
    ).timeout(
        const Duration(seconds: 5),
        onTimeout: (){
          throw RepositoryException(status: 408, message: "Falha ao conectar com servidor!");
        }
    );

    if (response.statusCode == 202){
      return jsonDecode(response.bodyBytes.toUTF8)["result"];
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Restaurant> addPhone(Phone phone) async {
    final idRestaurant = await getUserID();
    final endpointUri = Uri.parse("$kApiRequest/addphone/$idRestaurant");

    final response = await http.put(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
        body: jsonEncode(phone.toJson())
    ).timeout(
        const Duration(seconds: 5),
        onTimeout: (){
          throw RepositoryException(status: 408, message: "Falha ao conectar com servidor!");
        }
    );

    if (response.statusCode == 201){
      return Restaurant.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Restaurant> remPhone(String id) async {
    final idRestaurant = await getUserID();
    final endpointUri = Uri.parse("$kApiRequest/remphone/$idRestaurant/$id");

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
      return Restaurant.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<bool> delete({required String user, required String password}) async {
    final endpointUri = Uri.parse("$kApiRequest/delete");

    final json = {
      "login": user,
      "password": password
    };

    final response = await http.delete(
        endpointUri,
        headers: {
          'Content-Type':'application/json; charset=UTF-8'
        },
        body: jsonEncode(json)
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