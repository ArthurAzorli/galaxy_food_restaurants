import 'package:animated_tree_view/animated_tree_view.dart' as treeview;
import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:animated_tree_view/tree_view/widgets/expansion_indicator.dart';
import 'package:animated_tree_view/tree_view/widgets/indent.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food_restaurants/core/domain/package.dart';
import 'package:galaxy_food_restaurants/core/widgets/galaxy_button.dart';
import 'package:galaxy_food_restaurants/feature/menu_page/menu_viewmodel.dart';
import 'package:galaxy_food_restaurants/galaxy_theme.dart';
import 'package:resizable_widget/resizable_widget.dart';

import '../../core/domain/combo.dart';
import '../../core/domain/food.dart';

class MenuPage extends StatefulWidget{
  const MenuPage({super.key});

  @override
  State<StatefulWidget> createState() => _MenuPageState();

}

class _MenuPageState extends State<MenuPage> {

  late final MenuViewModel viewModel;

  @override
  void initState() {
    viewModel = MenuViewModel(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResizableWidget(
      percentages: const [0.6, 0.4],
      children: [

        SingleChildScrollView(
          child: Observer(
              builder: (context) {
                return Column(
                  children: [

                    Container(
                      height: 100,
                      color: GalaxyFoodTheme.normal.activeColor,
                      padding: const EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "CARDÁPIO", style: GalaxyFoodTheme.text.titleLarge,),
                      ),
                    ),


                    if(viewModel.root == null)
                      Container()
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 90, vertical: 60),
                        child: SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height - 220,
                          child: SafeArea(
                            child: treeview.TreeView.simpleTyped(
                                tree: viewModel.root!.toTreeNode(),
                                showRootNode: true,
                                onTreeReady: (controller) =>
                                viewModel.controller = controller,
                                expansionBehavior: ExpansionBehavior
                                    .scrollToLastChild,
                                expansionIndicatorBuilder: (context, node) {
                                  if (node.isRoot) {
                                    return PlusMinusIndicator(
                                      tree: node,
                                      alignment: Alignment.centerLeft,
                                    );
                                  }

                                  return ChevronIndicator.rightDown(
                                    tree: node,
                                    alignment: Alignment.centerLeft,
                                  );
                                },
                                indentation: const Indentation(),
                                builder: (context, node) {
                                  final data = node.data;
                                  if (data is Package) {
                                    return ContextMenuRegion(
                                      contextMenu: ContextMenu(
                                          boxDecoration: BoxDecoration(
                                            color: GalaxyFoodTheme.normal
                                                .micaBackgroundColor,
                                          ),
                                          entries: [
                                            if (!node.isRoot)
                                              MenuItem(
                                                  label: "Editar",
                                                  onSelected: () =>
                                                      viewModel.onSelectItem(
                                                          data)
                                              ),
                                            MenuItem(
                                                label: "Criar Pasta",
                                                onSelected: () =>
                                                    viewModel.onCreatePackage(
                                                        context,
                                                        node as TreeNode<
                                                            Package>)
                                            ),
                                            MenuItem(
                                                label: "Criar Comida",
                                                onSelected: () =>
                                                    viewModel.onCreateFood(
                                                        context,
                                                        node as TreeNode<
                                                            Package>)
                                            ),
                                            MenuItem(
                                                label: "Criar Combo",
                                                onSelected: () =>
                                                    viewModel.onCreateCombo(
                                                        context,
                                                        node as TreeNode<
                                                            Package>)
                                            ),
                                            if (!node.isRoot)
                                              MenuItem(
                                                  label: "Delete",
                                                  onSelected: () =>
                                                      viewModel.onDelete(
                                                          context, node)
                                              ),
                                          ]
                                      ),
                                      child: DragTarget(
                                        onMove: (_) =>
                                            viewModel.onOverDrag(
                                                node as treeview.TreeNode<
                                                    Package>),
                                        builder: (context, _, __) {
                                          if (node.isRoot) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0),
                                              child: ListTile(
                                                title: Text(data.name),
                                                leading: const Icon(
                                                    FluentIcons.fabric_folder,
                                                    size: 25),
                                              ),
                                            );
                                          }

                                          return Draggable(
                                            onDragCompleted: () =>
                                                viewModel.onDrop(context),
                                            onDragStarted: () =>
                                                viewModel.onStartDrag(node),
                                            feedback: Text(data.name),
                                            data: node,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0),
                                              child: ListTile(
                                                title: Text(data.name),
                                                leading: const Icon(
                                                    FluentIcons.fabric_folder,
                                                    size: 25),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  } else if (data is Food) {
                                    return ContextMenuRegion(
                                      contextMenu: ContextMenu(
                                          boxDecoration: BoxDecoration(
                                              color: GalaxyFoodTheme.normal
                                                  .micaBackgroundColor
                                          ),
                                          entries: [
                                            MenuItem(
                                                label: "Editar",
                                                onSelected: () =>
                                                    viewModel.onSelectItem(data)
                                            ),
                                            MenuItem(
                                                label: "Delete",
                                                onSelected: () =>
                                                    viewModel.onDelete(
                                                        context, node)
                                            ),
                                          ]
                                      ),
                                      child: Draggable(
                                        onDragCompleted: () =>
                                            viewModel.onDrop(context),
                                        onDragStarted: () =>
                                            viewModel.onStartDrag(node),
                                        feedback: Text(data.name),
                                        data: node,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0),
                                          child: ListTile(
                                            title: Text(data.name),
                                            leading: const Icon(material.Icons
                                                .local_dining_outlined,
                                                size: 25),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (data is Combo) {
                                    return ContextMenuRegion(
                                      contextMenu: ContextMenu(
                                          boxDecoration: BoxDecoration(
                                              color: GalaxyFoodTheme.normal
                                                  .micaBackgroundColor
                                          ),
                                          entries: [
                                            MenuItem(
                                                label: "Editar",
                                                onSelected: () =>
                                                    viewModel.onSelectItem(data)
                                            ),
                                            MenuItem(
                                                label: "Delete",
                                                onSelected: () =>
                                                    viewModel.onDelete(
                                                        context, node)
                                            ),
                                          ]
                                      ),
                                      child: Draggable(
                                        onDragCompleted: () =>
                                            viewModel.onDrop(context),
                                        onDragStarted: () =>
                                            viewModel.onStartDrag(node),
                                        feedback: Text(data.name),
                                        data: node,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0),
                                          child: ListTile(
                                            title: Text(data.name),
                                            leading: const Icon(
                                                material.Icons.fastfood_rounded,
                                                size: 25),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }
                            ),
                          ),
                        ),
                      ),

                  ],
                );
              }
          ),
        ),

        SingleChildScrollView(
          child: Observer(
              builder: (context) {
                return Form(
                  key: viewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        color: GalaxyFoodTheme.normal.activeColor,
                        padding: const EdgeInsets.all(20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("EDITAR", style: GalaxyFoodTheme.text
                              .titleLarge,),
                        ),
                      ),

                      if(viewModel.root == null || viewModel.selectedItem == null)
                        Container()
                      else if (viewModel.selectedItem is Package)
                        ..._getEditPanePackage(context)
                      else if (viewModel.selectedItem is Food)
                        ..._getEditPaneFood(context)
                      else if (viewModel.selectedItem is Combo)
                        ..._getEditPaneCombo(context)
                    ],
                  ),
                );
              }
          ),
        )
      ],
    );
  }

  _getEditPanePackage(BuildContext context) {
    viewModel.nameEditingController.text =
        (viewModel.selectedItem as Package).name;
    return [

      Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 5),
        child: Text("NOME:", style: GalaxyFoodTheme.text.titleSmall,),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: SizedBox(
          height: 45,
          child: TextFormBox(
            cursorColor: Colors.white,
            highlightColor: GalaxyFoodTheme.normal.activeColor,
            focusNode: viewModel.nameFocus,
            controller: viewModel.nameEditingController,
            validator: viewModel.nameValidator,
            style: GalaxyFoodTheme.text.bodyLarge,
            placeholder: "Nome",
            onTapOutside: (_) => viewModel.nameFocus.unfocus(),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(
            left: 50, right: 50, bottom: 20, top: 60),
        child: SizedBox(
          width: double.maxFinite,
          height: 60,
          child: GalaxyButton(
              onPressed: () => viewModel.onSavePackage(context),
              child: const Text("SALVAR")
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: SizedBox(
          width: double.maxFinite,
          height: 60,
          child: GalaxyButton(
              onPressed: viewModel.onCancel,
              child: const Text("CANCELAR")
          ),
        ),
      ),

    ];
  }

  _getEditPaneFood(BuildContext context) {
    var food = (viewModel.selectedItem as Food);
    viewModel.nameEditingController.text = food.name;
    viewModel.priceEditingController.text = food.price.toString();
    viewModel.descriptionEditingController.text = food.description ?? "";

    return [

      Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 5),
        child: Text("NOME:", style: GalaxyFoodTheme.text.titleSmall,),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: SizedBox(
          height: 45,
          child: TextFormBox(
            cursorColor: Colors.white,
            highlightColor: GalaxyFoodTheme.normal.activeColor,
            focusNode: viewModel.nameFocus,
            controller: viewModel.nameEditingController,
            validator: viewModel.nameValidator,
            style: GalaxyFoodTheme.text.bodyLarge,
            placeholder: "Nome",
            onTapOutside: (_) => viewModel.nameFocus.unfocus(),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 5),
        child: Text("PREÇO:", style: GalaxyFoodTheme.text.titleSmall,),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: SizedBox(
          height: 45,
          child: TextFormBox(
            cursorColor: Colors.white,
            highlightColor: GalaxyFoodTheme.normal.activeColor,
            focusNode: viewModel.priceFocus,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: viewModel.priceEditingController,
            validator: viewModel.priceValidator,
            style: GalaxyFoodTheme.text.bodyLarge,
            placeholder: "Preço",
            prefix: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text("R\$", style: GalaxyFoodTheme.text.bodyLarge,),
            ),
            onTapOutside: (_) => viewModel.priceFocus.unfocus(),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 5),
        child: Text("DESCRIÇÃO:", style: GalaxyFoodTheme.text.titleSmall,),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: SizedBox(
          height: 150,
          child: TextFormBox(
            cursorColor: Colors.white,
            highlightColor: GalaxyFoodTheme.normal.activeColor,
            keyboardType: TextInputType.multiline,
            focusNode: viewModel.descriptionFocus,
            controller: viewModel.descriptionEditingController,
            style: GalaxyFoodTheme.text.bodyLarge,
            textAlignVertical: TextAlignVertical.top,
            maxLines: null,
            placeholder: "Descrição",
            onTapOutside: (_) => viewModel.descriptionFocus.unfocus(),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 5),
        child: Text("IMAGEM:", style: GalaxyFoodTheme.text.titleSmall,),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: GestureDetector(
            onTap: viewModel.selectImage,
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: GalaxyFoodTheme.normal.cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: viewModel.image == null || viewModel.image!.isEmpty
                      ? null
                      :
                  DecorationImage(
                      image: Image
                          .memory(viewModel.image!)
                          .image
                  )
              ),
              child: !(viewModel.image == null || viewModel.image!.isEmpty)
                  ? null
                  :
              const Center(
                  child: Text("Selecione uma imagem")
              ),
            ),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: SizedBox(
          width: double.maxFinite,
          height: 60,
          child: GalaxyButton(
              onPressed: () => viewModel.onSaveFood(context),
              child: const Text("SALVAR")
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, bottom: 30),
        child: SizedBox(
          width: double.maxFinite,
          height: 60,
          child: GalaxyButton(
              onPressed: viewModel.onCancel,
              child: const Text("CANCELAR")
          ),
        ),
      ),
    ];
  }

  _getEditPaneCombo(BuildContext context){
    var combo = (viewModel.selectedItem as Combo);
    viewModel.nameEditingController.text = combo.name;
    viewModel.priceEditingController.text = combo.price.toString();

    for (var item in combo.items){
      viewModel.itemsQuantity[item.id!] = item.quantity;
    }

    return [

      Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 5),
        child: Text("NOME:", style: GalaxyFoodTheme.text.titleSmall,),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: SizedBox(
          height: 45,
          child: TextFormBox(
            cursorColor: Colors.white,
            highlightColor: GalaxyFoodTheme.normal.activeColor,
            focusNode: viewModel.nameFocus,
            controller: viewModel.nameEditingController,
            validator: viewModel.nameValidator,
            style: GalaxyFoodTheme.text.bodyLarge,
            placeholder: "Nome",
            onTapOutside: (_) => viewModel.nameFocus.unfocus(),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 5),
        child: Text("PREÇO:", style: GalaxyFoodTheme.text.titleSmall,),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: SizedBox(
          height: 45,
          child: TextFormBox(
            cursorColor: Colors.white,
            highlightColor: GalaxyFoodTheme.normal.activeColor,
            focusNode: viewModel.priceFocus,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: viewModel.priceEditingController,
            validator: viewModel.priceValidator,
            style: GalaxyFoodTheme.text.bodyLarge,
            placeholder: "Preço",
            prefix: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text("R\$", style: GalaxyFoodTheme.text.bodyLarge,),
            ),
            onTapOutside: (_) => viewModel.priceFocus.unfocus(),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 5),
        child: Text("IMAGEM:", style: GalaxyFoodTheme.text.titleSmall,),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: AspectRatio(
          aspectRatio: 4/3,
          child: GestureDetector(
            onTap: viewModel.selectImage,
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: GalaxyFoodTheme.normal.cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: viewModel.image == null || viewModel.image!.isEmpty? null:
                  DecorationImage(
                      image: Image.memory(viewModel.image!).image
                  )
              ),
              child: !(viewModel.image == null || viewModel.image!.isEmpty)? null:
              const Center(
                  child: Text("Selecione uma imagem")
              ),
            ),
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 20, bottom: 5),
        child: Text("ITENS:", style: GalaxyFoodTheme.text.titleSmall,),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Container(
          height: 350,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: GalaxyFoodTheme.normal.cardColor,
            borderRadius: BorderRadius.circular(10)
          ),
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: combo.items.length,
            itemBuilder: (context, index){
              var item = combo.items[index];
              return _ComboItemWidget(
                  item: item, 
                  value: viewModel.itemsQuantity[item.id]!, 
                  onAdd: () => viewModel.add(item), 
                  onRem: () => viewModel.rem(item), 
                  onClose: () => viewModel.delete(context, item)
              );
            }
          ),
        ),
      ),
      
      Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 20),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: ComboBox(
                  value: viewModel.selectedFood,
                  placeholder: const Text("Selecione a Comida"),
                  items: List.generate(
                    viewModel.foods?.length??0,
                    (index){
                      var food = viewModel.foods![index];

                      bool result = false;
                      for (var item in combo.items){
                        if (item.item.id == food.id){
                          result = true;
                          break;
                        }
                      }

                      return ComboBoxItem(
                        enabled: !result,
                        value: food,
                        child: Text(food.name)
                      );
                    }
                  ),
                  onChanged: viewModel.onChangeFood,
                ),
              ),
            ),
            GalaxyButton(
              onPressed: () => viewModel.addFood(context),
              child: const Text("Adicionar")
            )
          ],
        ),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: SizedBox(
          width: double.maxFinite,
          height: 60,
          child: GalaxyButton(
              onPressed: () => viewModel.onSaveCombo(context),
              child: const Text("SALVAR")
          ),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, bottom: 30),
        child: SizedBox(
          width: double.maxFinite,
          height: 60,
          child: GalaxyButton(
              onPressed: viewModel.onCancel,
              child: const Text("CANCELAR")
          ),
        ),
      ),
    ];
  }
}

class _ComboItemWidget extends StatefulWidget{

  ComboItem item;
  int value;
  Function() onAdd;
  Function() onRem;
  Function() onClose;

  _ComboItemWidget({super.key, required this.item, required this.value, required this.onAdd, required this.onRem, required this.onClose});

  @override
  State<StatefulWidget> createState() => _ComboItemWidgetState();

}

class _ComboItemWidgetState extends State<_ComboItemWidget>{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
          color: GalaxyFoodTheme.normal.micaBackgroundColor,
          borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text("${widget.value}x", style: GalaxyFoodTheme.text.titleLarge,),
          ),
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(widget.item.item.name)
              )
          ),
          Container(
            width: 45, height: 45,
            margin: const EdgeInsets.only(left: 5),
            child: GalaxyButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.all(10))
                ),
                onPressed: (){
                  setState(() {
                    widget.value+=1;
                  });
                  widget.onAdd();
                },
                child: const Icon(material.Icons.add, size: 20,)
            ),
          ),
          Container(
            width: 45, height: 45,
            margin: const EdgeInsets.only(left: 5),
            child: GalaxyButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.all(10))
                ),
                onPressed: (){
                  setState(() {
                    widget.value-=1;
                  });
                  widget.onRem();
                },
                child: const Icon(material.Icons.remove, size: 20,)
            ),
          ),
          Container(
            width: 45, height: 45,
            margin: const EdgeInsets.only(left: 5),
            child: GalaxyButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.all(10))
                ),
                onPressed: widget.onClose,
                child: const Icon(material.Icons.close, size: 20,)
            ),
          )
        ],
      ),
    );
  }

}

