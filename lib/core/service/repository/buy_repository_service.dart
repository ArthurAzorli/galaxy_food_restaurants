import 'dart:convert';
import 'package:galaxy_food_restaurants/core/domain/order_status.dart';
import 'package:galaxy_food_restaurants/core/service/repository/repository_service.dart';
import 'package:galaxy_food_restaurants/core/service/repository/restaurant_repository_service.dart';
import 'package:galaxy_food_restaurants/core/utils/bytes.dart';
import 'package:http/http.dart' as http;
import '../../domain/buy.dart';
import '../../utils/exception/repository_exception.dart';

class BuyRepositoryService {

  static const String kApiRequest = "http://${RepositoryService.kIpAddressServer}:${RepositoryService.kPortServer}/buy";

  static Future<List<Buy>> getAll() async {
    final idRestaurant = await RestaurantRepositoryService.getUserID();
    final endpointUri = Uri.parse("$kApiRequest/get/$idRestaurant?typeUser=restaurant");

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

      List buysJson = jsonDecode(response.bodyBytes.toUTF8);
      return buysJson.map((buy){
        return Buy.fromJson(buy);
      }).toList();

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Buy> get(String id) async {
    final idRestaurant = await RestaurantRepositoryService.getUserID();
    final endpointUri = Uri.parse("$kApiRequest/get/$idRestaurant/$id?typeUser=restaurant");

    final response = await http.get(
      endpointUri,
      headers: {
        'Content-Type':'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode == 200){
      return Buy.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<Buy> updateStatus(String id, OrderStatus status) async {
    final idRestaurant = await RestaurantRepositoryService.getUserID();
    final endpointUri = Uri.parse("$kApiRequest/updatestatus/$idRestaurant/$id?status=${status.code}");

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
      return Buy.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }

  static Future<int> getCountBuy(String id) async {
    final endpointUri = Uri.parse("$kApiRequest/get/$id?typeUser=restaurant");

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

      List buysJson = jsonDecode(response.bodyBytes.toUTF8);
      return buysJson.map((buy){
        return Buy.fromJson(buy);
      }).toList().length;

    } else {
      throw RepositoryException.fromJson(jsonDecode(response.bodyBytes.toUTF8));
    }
  }
}