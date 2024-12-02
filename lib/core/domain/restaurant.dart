import 'package:galaxy_food_restaurants/core/domain/address.dart';
import 'package:galaxy_food_restaurants/core/domain/phone.dart';
import 'package:galaxy_food_restaurants/core/domain/restaurant_owner.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant{
  late String? id;
  late final String cnpj;
  late String email;
  late String name;
  late String? specialty;
  late List<int>? image;
  late Address address;
  late double score;
  late List<Phone> phones;
  late RestaurantOwner owner;

  @JsonKey(includeFromJson: false, includeToJson: true, name: "password")
  String? _password;

  Restaurant({
    required this.id,
    required this.cnpj,
    required this.email,
    required this.name,
    required this.specialty,
    this.image,
    required this.address,
    this.score = 0,
    required this.phones,
    required this.owner
  });

  set password(String password) => _password = password;

  factory Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is Phone && other.id == id) return true;
    return false;
  }
}