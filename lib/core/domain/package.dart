import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package_item.dart';

part 'package.g.dart';

@JsonSerializable()
class Package{
  late String? id;
  late String name;
  late String? parent;
  late final String restaurant;
  late List<Package> children;
  late List<PackageItem> items;

  Package({
    this.id,
    required this.name,
    required this.parent,
    required this.restaurant,
    this.children = const [],
    this.items = const []
  });

  factory Package.fromJson(Map<String, dynamic> json) => _$PackageFromJson(json);

  Map<String, dynamic> toJson() => _$PackageToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is Package && other.id == id) return true;
    return false;
  }

  @override
  int get hashCode => id.hashCode;

  TreeNode<Object> toTreeNode([TreeNode<Package>? parent]){
    TreeNode<Package> package;
    if (this.parent == null){
      package = TreeNode.root(
        data: this
      );
    } else {
      package = TreeNode(
        data: this,
        parent: parent
      );
    }

    return package
      ..addAll(children.map((child)=>child.toTreeNode(parent)))
      ..addAll(items.map((item) => item.toTreeNode(parent)));
  }

}