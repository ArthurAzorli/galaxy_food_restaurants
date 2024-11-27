import 'package:galaxy_food_restaurants/core/domain/food.dart';
import 'package:galaxy_food_restaurants/core/domain/package_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'combo.g.dart';

@JsonSerializable()
class Combo extends PackageItem{

  late List<ComboItem> items;

  Combo({
    super.id,
    required super.name,
    required super.price,
    required super.parent,
    this.items = const []
  });

  factory Combo.fromJson(Map<String, dynamic> json) => _$ComboFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ComboToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is Combo && other.id == id) return true;
    return false;
  }

  @override
  int get hashCode => id.hashCode;


}

@JsonSerializable()
class ComboItem {
  final String? id;
  late int quantity;
  late final String combo;
  @JsonKey(toJson: _itemToJson)
  late final Food item;

  ComboItem({
    this.id,
    required this.quantity,
    required this.combo,
    required this.item
  });

  static _itemToJson(item) => item.id;

  factory ComboItem.fromJson(Map<String, dynamic> json) => _$ComboItemFromJson(json);

  Map<String, dynamic> toJson() => _$ComboItemToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is ComboItem && other.id == id) return true;
    return false;
  }

  @override
  int get hashCode => id.hashCode;

}

extension ComboItems on  List<ComboItem>{
  String get listToString{
    final buffer = StringBuffer();

    for (final item in this){
      buffer.write("${item.quantity}x ${item.item.name}\n");
    }

    return buffer.toString();
  }
}