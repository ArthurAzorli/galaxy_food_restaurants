import 'package:json_annotation/json_annotation.dart';

import 'combo.dart';
import 'food.dart';

part 'package_item.g.dart';

@JsonSerializable()
abstract class PackageItem{
  late String? id;
  late String name;
  late double price;
  @JsonKey(fromJson: imageFromJson)
  late List<int>? image;
  late String parent;

  PackageItem({
    this.id,
    required this.name,
    required this.price,
    this.image = const [],
    required this.parent
  });

  static PackageItem fromJson(Map<String, dynamic> json){
    if (json["items"] != null){
      return Combo.fromJson(json);
    } else {
      return Food.fromJson(json);
    }
  }

  Map<String, dynamic> toJson() => _$PackageItemToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is PackageItem && other.id == id) return true;
    return false;
  }

  @override
  int get hashCode => id.hashCode;

  static List<int> imageFromJson(json){
    if (json.toString().isNotEmpty){
      return (json as List<dynamic>).map((e) => (e as num).toInt()).toList();
    }
    return <int>[];
  }

}