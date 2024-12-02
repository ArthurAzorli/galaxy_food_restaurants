import 'dart:typed_data';

import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:galaxy_food_restaurants/core/domain/package.dart';
import 'package:galaxy_food_restaurants/core/service/repository/package_repository_service.dart';
import 'package:galaxy_food_restaurants/core/service/repository/restaurant_repository_service.dart';
import 'package:galaxy_food_restaurants/core/utils/bytes.dart';
import 'package:galaxy_food_restaurants/core/utils/listenable_node.dart';
import 'package:mobx/mobx.dart';
import 'package:on_popup_window_widget/on_popup_window_widget.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

import '../../core/domain/combo.dart';
import '../../core/domain/food.dart';
import '../../core/domain/package_item.dart';
import '../../core/service/repository/combo_repository_service.dart';
import '../../core/service/repository/food_repository_service.dart';
import '../../core/utils/exception/repository_exception.dart';
import '../../core/widgets/galaxy_button.dart';
import '../../galaxy_theme.dart';

part 'menu_viewmodel.g.dart';

class MenuViewModel = MenuViewModelBase with _$MenuViewModel;

abstract class MenuViewModelBase with Store {

 MenuViewModelBase(BuildContext context){
  _getRoot(context);
 }

 final _picker = ImagePickerPlatform.instance;

 @observable
 GlobalKey<FormState> formKey = GlobalKey();

 @observable
 Object? selectedItem;

 @observable
 Package? root;

 @observable
 List<Food>? foods;

 @observable
 Food? selectedFood;

 @observable
 TreeViewController? controller;

 @observable
 TreeNode? draggedItem;

 @observable
 TreeNode? overItemConfirmed;

 @observable
 var nameEditingController = TextEditingController();

 @observable
 var nameFocus = FocusNode();

 @observable
 var priceEditingController = TextEditingController();

 @observable
 var priceFocus = FocusNode();

 @observable
 var descriptionEditingController = TextEditingController();

 @observable
 var descriptionFocus = FocusNode();

 @observable
 Uint8List? image;

 @observable
 ObservableMap<String, int> itemsQuantity = ObservableMap();

 @action
 String? nameValidator(String? text){
  if (text == null || text.isEmpty) return "Campo Nome Vazio!";
  return null;
 }

 @action
 String? priceValidator(String? text){
  if (text == null || text.isEmpty) return "Campo Preço Vazio!";
  if (double.parse(text) <=0) return "Valor Invalido!";
  return null;
 }

 @action
 selectImage() async {
  final result = await _picker.getMedia(
    options: const MediaOptions(
      allowMultiple: false,
    )
  );
  if (result.isEmpty) return;
  image = await result.first.readAsBytes();
 }

 @action
 onSavePackage(BuildContext context) async {
  if (!formKey.currentState!.validate()) return;

  var package = (selectedItem as Package);
  package.name = nameEditingController.text;

  try{
    selectedItem = await PackageRepositoryService.update(package);
    _getRoot(context);
  } on RepositoryException catch(e){
    e.showMessageDialog(context, ()=>Navigator.pop(context));
  }
 }

 @action
 onSaveFood(BuildContext context) async {
  if (!formKey.currentState!.validate()) return;

  var food = (selectedItem as Food);
  food.name = nameEditingController.text;
  food.price = double.parse(priceEditingController.text);
  food.description = descriptionEditingController.text;
  food.image = image;

  try{
   selectedItem = await FoodRepositoryService.update(food);
   _getRoot(context);
   showDialog(
     context: context,
     builder: (context)
     {
      return OnPopupWindowWidget(
       backgroundColor: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
       divider: Container(),
       centerTitle: true,
       title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Text("Sucesso!", style: GalaxyFoodTheme.text.titleLarge),
        ],
       ),
       child: Column(
        children: [
         Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text("${(selectedItem as Food).name} foi atualizado com sucesso!", style: GalaxyFoodTheme.text.bodyLarge,
           textAlign: TextAlign.center,),
         ),

         Center(
          child: SizedBox(
           height: 50,
           width: 200,
           child: GalaxyButton(
               onPressed: () => Navigator.pop(context),
               child: const Text("FECHAR")
           ),
          ),
         )
        ],
       ),
      );
     }
   );
  } on RepositoryException catch(e){
   e.showMessageDialog(context, ()=>Navigator.pop(context));
  }
 }

 @action
 onSaveCombo(BuildContext context) async {
  if (!formKey.currentState!.validate()) return;

  var combo = (selectedItem as Combo);
  combo.name = nameEditingController.text;
  combo.price = double.parse(priceEditingController.text);
  combo.image = image;

  for (var item in combo.items){
   if (item.quantity != itemsQuantity[item.id]){
    item.quantity = itemsQuantity[item.id]!;
    combo = await ComboRepositoryService.addFood(combo, item);
   }
  }

  try{
   selectedItem = await ComboRepositoryService.update(combo);
   _getRoot(context);
   showDialog(
       context: context,
       builder: (context)
       {
        return OnPopupWindowWidget(
         backgroundColor: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
         divider: Container(),
         centerTitle: true,
         title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text("Sucesso!", style: GalaxyFoodTheme.text.titleLarge),
          ],
         ),
         child: Column(
          children: [
           Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Text("${(selectedItem as Combo).name} foi atualizado com sucesso!", style: GalaxyFoodTheme.text.bodyLarge,
             textAlign: TextAlign.center,),
           ),

           Center(
            child: SizedBox(
             height: 50,
             width: 200,
             child: GalaxyButton(
                 onPressed: () => Navigator.pop(context),
                 child: const Text("FECHAR")
             ),
            ),
           )
          ],
         ),
        );
       }
   );
  } on RepositoryException catch(e){
   e.showMessageDialog(context, ()=>Navigator.pop(context));
  }
 }

 @action
 onCancel(){
  selectedItem = null;
  image = null;
  itemsQuantity.clear();
 }

 @action
 onSelectItem(Object item){
   selectedItem = item;
   itemsQuantity.clear();
   if (item is PackageItem){
    image = item.image?.toUint8List;
   }
 }

 @action
 onChangeFood(Food? food){
  selectedFood = food;
 }

 @action
 add(ComboItem item){
  itemsQuantity[item.id!] = itemsQuantity[item.id!]! + 1;
  selectedItem = selectedItem;
 }

 @action
 rem(ComboItem item){
  if (itemsQuantity[item.id!]! > 0){
   itemsQuantity[item.id!] = itemsQuantity[item.id!]! - 1;
   selectedItem = selectedItem;
  }
 }

 @action
 addFood(BuildContext context) async{
  try{
   if (selectedFood == null) return;
   var item = ComboItem(quantity: 1, combo: (selectedItem as Combo).id!, item: selectedFood!);
   selectedItem = await ComboRepositoryService.addFood((selectedItem as Combo), item);
   selectedFood = null;
   _getRoot(context);
  } on RepositoryException catch(e) {
   e.showMessageDialog(context, ()=>Navigator.pop(context));
  }
 }

 @action
 delete(BuildContext context, ComboItem item) async{
  try{
   itemsQuantity.remove(item.id);
   selectedItem = await ComboRepositoryService.remFood(item.id!);
   _getRoot(context);
  } on RepositoryException catch(e) {
   e.showMessageDialog(context, ()=>Navigator.pop(context));
  }
 }
 
 @action
 onStartDrag(TreeNode node){
  if (node.isRoot) return;
  if (node.parent == null || !node.isLeaf) return;
  draggedItem = node;
 }
 
 @action
 onOverDrag(TreeNode<Package> node){
  if (draggedItem == null || node.data == null) return false;
  if (node.data is PackageItem) return false;
  if (node.childrenAsList.isChild(draggedItem)) return false;
  overItemConfirmed = node;
 }

 @action
 onDrop(BuildContext context) async {
  try {
   final data = draggedItem?.data;
   if (data == null || overItemConfirmed?.data == null){
    return;
   } else if (data is Package){
    await PackageRepositoryService.move(data, overItemConfirmed!.data);
   } else if (data is Food){
    await FoodRepositoryService.move(data, overItemConfirmed!.data);
   } else if (data is Combo){
    await ComboRepositoryService.move(data, overItemConfirmed!.data);
   } else {
    return;
   }

   controller!.collapseNode(draggedItem!.parent! as TreeNode);

   draggedItem!.parent!.remove(draggedItem!);
   draggedItem!.parent = overItemConfirmed;
   overItemConfirmed!.add(draggedItem!);
   _getRoot(context);

   draggedItem = null;
   overItemConfirmed = null;

  } on RepositoryException catch(e){
   e.showMessageDialog(context, () => Navigator.pop(context));
  }
 }

 @action
 onCreatePackage(BuildContext context, TreeNode<Package> parent) async{
  try{

   var package = Package(
     name: "Nova Pasta",
     parent: parent.data!.id!,
     restaurant: await RestaurantRepositoryService.getUserID(),
   );

   package = await PackageRepositoryService.create(package);
   parent.add(TreeNode(data: package));
   _getRoot(context);

  } on RepositoryException catch(e){
   e.showMessageDialog(context, ()=>Navigator.pop(context));
  }
 }

 @action
 onCreateFood(BuildContext context, TreeNode<Package> parent) async{
  try{

   var food = Food(
     name: "Nova Comida",
     parent: parent.data!.id!,
     price: 0.0,
     description: "",
   );

   food = await FoodRepositoryService.create(food);
   parent.add(TreeNode(data: food));
   _getRoot(context);

  } on RepositoryException catch(e){
   e.showMessageDialog(context, ()=>Navigator.pop(context));
  }
 }

 @action
 onCreateCombo(BuildContext context, TreeNode<Package> parent) async{
  try{

   var combo = Combo(
    name: "Nova Comida",
    parent: parent.data!.id!,
    price: 0.0,
   );

   combo = await ComboRepositoryService.create(combo);
   parent.add(TreeNode(data: combo));
   _getRoot(context);

  } on RepositoryException catch(e){
   e.showMessageDialog(context, ()=>Navigator.pop(context));
  }
 }

 @action
 onDelete(BuildContext context, TreeNode node) async{
  try{

   bool result = false;
   String item = "Item";
   final data = node.data;

   if (data is Package){
    item = "Pasta";
    result = await PackageRepositoryService.delete(data);
   } else if (data is Food){
    item = "Comida";
    result = await FoodRepositoryService.delete(data);
   } else if (data is Combo){
    item = "Combo";
    result = await ComboRepositoryService.delete(data);
   }

   if (result) {
     controller!.collapseNode(node.parent! as TreeNode);
     node.parent!.remove(node);

     showDialog(
       context: context,
       builder: (context)
       {
        return OnPopupWindowWidget(
         backgroundColor: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
         divider: Container(),
         centerTitle: true,
         title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text("$item Deletado(a) com Sucesso", style: GalaxyFoodTheme.text.titleLarge),
          ],
         ),
         child: Column(
          children: [
           Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Text("${data.name} deletado!", style: GalaxyFoodTheme.text.bodyLarge,
             textAlign: TextAlign.center,),
           ),

           Center(
            child: SizedBox(
             height: 50,
             width: 200,
             child: GalaxyButton(
                 onPressed: () => Navigator.pop(context),
                 child: const Text("FECHAR")
             ),
            ),
           )
          ],
         ),
        );
       }
    );
   }

  } on RepositoryException catch(e){
   e.showMessageDialog(context, ()=>Navigator.pop(context));
  }
 }

 _getRoot(BuildContext context) async{
  try{
   root = await PackageRepositoryService.root();
   foods = await FoodRepositoryService.getAll();
   print(foods);
   root!.toTreeNode();
  } on RepositoryException catch(e){
   e.showMessageDialog(context, (){
    Navigator.pop(context);
   });
  }
 }

}