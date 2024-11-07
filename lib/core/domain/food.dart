import 'package:galaxy_food_restaurants/core/domain/package_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food.g.dart';

@JsonSerializable()
class Food extends PackageItem{

  String? description;

  Food({
    super.id,
    required super.name,
    required super.price,
    required this.description,
    super.image,
    required super.parent
  });

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FoodToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is Food && other.id == id) return true;
    return false;
  }
}