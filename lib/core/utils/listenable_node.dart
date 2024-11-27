import 'package:animated_tree_view/animated_tree_view.dart';

extension ListenableNodeUtilsListInt on List<ListenableNode>{

  bool isChild(TreeNode? node){
    bool value = false;
    if (node != null) {
      value = node.childrenAsList.contains(node);
      for (var child in node.childrenAsList) {
        value = value && child.childrenAsList.isChild(node);
      }
    }
    return value;
  }
}