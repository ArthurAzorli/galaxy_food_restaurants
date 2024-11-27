// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MenuViewModel on MenuViewModelBase, Store {
  late final _$formKeyAtom =
      Atom(name: 'MenuViewModelBase.formKey', context: context);

  @override
  GlobalKey<FormState> get formKey {
    _$formKeyAtom.reportRead();
    return super.formKey;
  }

  @override
  set formKey(GlobalKey<FormState> value) {
    _$formKeyAtom.reportWrite(value, super.formKey, () {
      super.formKey = value;
    });
  }

  late final _$selectedItemAtom =
      Atom(name: 'MenuViewModelBase.selectedItem', context: context);

  @override
  Object? get selectedItem {
    _$selectedItemAtom.reportRead();
    return super.selectedItem;
  }

  @override
  set selectedItem(Object? value) {
    _$selectedItemAtom.reportWrite(value, super.selectedItem, () {
      super.selectedItem = value;
    });
  }

  late final _$rootAtom =
      Atom(name: 'MenuViewModelBase.root', context: context);

  @override
  Package? get root {
    _$rootAtom.reportRead();
    return super.root;
  }

  @override
  set root(Package? value) {
    _$rootAtom.reportWrite(value, super.root, () {
      super.root = value;
    });
  }

  late final _$foodsAtom =
      Atom(name: 'MenuViewModelBase.foods', context: context);

  @override
  List<Food>? get foods {
    _$foodsAtom.reportRead();
    return super.foods;
  }

  @override
  set foods(List<Food>? value) {
    _$foodsAtom.reportWrite(value, super.foods, () {
      super.foods = value;
    });
  }

  late final _$selectedFoodAtom =
      Atom(name: 'MenuViewModelBase.selectedFood', context: context);

  @override
  Food? get selectedFood {
    _$selectedFoodAtom.reportRead();
    return super.selectedFood;
  }

  @override
  set selectedFood(Food? value) {
    _$selectedFoodAtom.reportWrite(value, super.selectedFood, () {
      super.selectedFood = value;
    });
  }

  late final _$controllerAtom =
      Atom(name: 'MenuViewModelBase.controller', context: context);

  @override
  TreeViewController<dynamic, ITreeNode<dynamic>>? get controller {
    _$controllerAtom.reportRead();
    return super.controller;
  }

  @override
  set controller(TreeViewController<dynamic, ITreeNode<dynamic>>? value) {
    _$controllerAtom.reportWrite(value, super.controller, () {
      super.controller = value;
    });
  }

  late final _$draggedItemAtom =
      Atom(name: 'MenuViewModelBase.draggedItem', context: context);

  @override
  TreeNode<dynamic>? get draggedItem {
    _$draggedItemAtom.reportRead();
    return super.draggedItem;
  }

  @override
  set draggedItem(TreeNode<dynamic>? value) {
    _$draggedItemAtom.reportWrite(value, super.draggedItem, () {
      super.draggedItem = value;
    });
  }

  late final _$overItemConfirmedAtom =
      Atom(name: 'MenuViewModelBase.overItemConfirmed', context: context);

  @override
  TreeNode<dynamic>? get overItemConfirmed {
    _$overItemConfirmedAtom.reportRead();
    return super.overItemConfirmed;
  }

  @override
  set overItemConfirmed(TreeNode<dynamic>? value) {
    _$overItemConfirmedAtom.reportWrite(value, super.overItemConfirmed, () {
      super.overItemConfirmed = value;
    });
  }

  late final _$nameEditingControllerAtom =
      Atom(name: 'MenuViewModelBase.nameEditingController', context: context);

  @override
  TextEditingController get nameEditingController {
    _$nameEditingControllerAtom.reportRead();
    return super.nameEditingController;
  }

  @override
  set nameEditingController(TextEditingController value) {
    _$nameEditingControllerAtom.reportWrite(value, super.nameEditingController,
        () {
      super.nameEditingController = value;
    });
  }

  late final _$nameFocusAtom =
      Atom(name: 'MenuViewModelBase.nameFocus', context: context);

  @override
  FocusNode get nameFocus {
    _$nameFocusAtom.reportRead();
    return super.nameFocus;
  }

  @override
  set nameFocus(FocusNode value) {
    _$nameFocusAtom.reportWrite(value, super.nameFocus, () {
      super.nameFocus = value;
    });
  }

  late final _$priceEditingControllerAtom =
      Atom(name: 'MenuViewModelBase.priceEditingController', context: context);

  @override
  TextEditingController get priceEditingController {
    _$priceEditingControllerAtom.reportRead();
    return super.priceEditingController;
  }

  @override
  set priceEditingController(TextEditingController value) {
    _$priceEditingControllerAtom
        .reportWrite(value, super.priceEditingController, () {
      super.priceEditingController = value;
    });
  }

  late final _$priceFocusAtom =
      Atom(name: 'MenuViewModelBase.priceFocus', context: context);

  @override
  FocusNode get priceFocus {
    _$priceFocusAtom.reportRead();
    return super.priceFocus;
  }

  @override
  set priceFocus(FocusNode value) {
    _$priceFocusAtom.reportWrite(value, super.priceFocus, () {
      super.priceFocus = value;
    });
  }

  late final _$descriptionEditingControllerAtom = Atom(
      name: 'MenuViewModelBase.descriptionEditingController', context: context);

  @override
  TextEditingController get descriptionEditingController {
    _$descriptionEditingControllerAtom.reportRead();
    return super.descriptionEditingController;
  }

  @override
  set descriptionEditingController(TextEditingController value) {
    _$descriptionEditingControllerAtom
        .reportWrite(value, super.descriptionEditingController, () {
      super.descriptionEditingController = value;
    });
  }

  late final _$descriptionFocusAtom =
      Atom(name: 'MenuViewModelBase.descriptionFocus', context: context);

  @override
  FocusNode get descriptionFocus {
    _$descriptionFocusAtom.reportRead();
    return super.descriptionFocus;
  }

  @override
  set descriptionFocus(FocusNode value) {
    _$descriptionFocusAtom.reportWrite(value, super.descriptionFocus, () {
      super.descriptionFocus = value;
    });
  }

  late final _$imageAtom =
      Atom(name: 'MenuViewModelBase.image', context: context);

  @override
  Uint8List? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(Uint8List? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  late final _$itemsQuantityAtom =
      Atom(name: 'MenuViewModelBase.itemsQuantity', context: context);

  @override
  ObservableMap<String, int> get itemsQuantity {
    _$itemsQuantityAtom.reportRead();
    return super.itemsQuantity;
  }

  @override
  set itemsQuantity(ObservableMap<String, int> value) {
    _$itemsQuantityAtom.reportWrite(value, super.itemsQuantity, () {
      super.itemsQuantity = value;
    });
  }

  late final _$selectImageAsyncAction =
      AsyncAction('MenuViewModelBase.selectImage', context: context);

  @override
  Future selectImage() {
    return _$selectImageAsyncAction.run(() => super.selectImage());
  }

  late final _$onSavePackageAsyncAction =
      AsyncAction('MenuViewModelBase.onSavePackage', context: context);

  @override
  Future onSavePackage(BuildContext context) {
    return _$onSavePackageAsyncAction.run(() => super.onSavePackage(context));
  }

  late final _$onSaveFoodAsyncAction =
      AsyncAction('MenuViewModelBase.onSaveFood', context: context);

  @override
  Future onSaveFood(BuildContext context) {
    return _$onSaveFoodAsyncAction.run(() => super.onSaveFood(context));
  }

  late final _$onSaveComboAsyncAction =
      AsyncAction('MenuViewModelBase.onSaveCombo', context: context);

  @override
  Future onSaveCombo(BuildContext context) {
    return _$onSaveComboAsyncAction.run(() => super.onSaveCombo(context));
  }

  late final _$addFoodAsyncAction =
      AsyncAction('MenuViewModelBase.addFood', context: context);

  @override
  Future addFood(BuildContext context) {
    return _$addFoodAsyncAction.run(() => super.addFood(context));
  }

  late final _$deleteAsyncAction =
      AsyncAction('MenuViewModelBase.delete', context: context);

  @override
  Future delete(BuildContext context, ComboItem item) {
    return _$deleteAsyncAction.run(() => super.delete(context, item));
  }

  late final _$onDropAsyncAction =
      AsyncAction('MenuViewModelBase.onDrop', context: context);

  @override
  Future onDrop(BuildContext context) {
    return _$onDropAsyncAction.run(() => super.onDrop(context));
  }

  late final _$onCreatePackageAsyncAction =
      AsyncAction('MenuViewModelBase.onCreatePackage', context: context);

  @override
  Future onCreatePackage(BuildContext context, TreeNode<Package> parent) {
    return _$onCreatePackageAsyncAction
        .run(() => super.onCreatePackage(context, parent));
  }

  late final _$onCreateFoodAsyncAction =
      AsyncAction('MenuViewModelBase.onCreateFood', context: context);

  @override
  Future onCreateFood(BuildContext context, TreeNode<Package> parent) {
    return _$onCreateFoodAsyncAction
        .run(() => super.onCreateFood(context, parent));
  }

  late final _$onCreateComboAsyncAction =
      AsyncAction('MenuViewModelBase.onCreateCombo', context: context);

  @override
  Future onCreateCombo(BuildContext context, TreeNode<Package> parent) {
    return _$onCreateComboAsyncAction
        .run(() => super.onCreateCombo(context, parent));
  }

  late final _$onDeleteAsyncAction =
      AsyncAction('MenuViewModelBase.onDelete', context: context);

  @override
  Future onDelete(BuildContext context, TreeNode<dynamic> node) {
    return _$onDeleteAsyncAction.run(() => super.onDelete(context, node));
  }

  late final _$MenuViewModelBaseActionController =
      ActionController(name: 'MenuViewModelBase', context: context);

  @override
  String? nameValidator(String? text) {
    final _$actionInfo = _$MenuViewModelBaseActionController.startAction(
        name: 'MenuViewModelBase.nameValidator');
    try {
      return super.nameValidator(text);
    } finally {
      _$MenuViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? priceValidator(String? text) {
    final _$actionInfo = _$MenuViewModelBaseActionController.startAction(
        name: 'MenuViewModelBase.priceValidator');
    try {
      return super.priceValidator(text);
    } finally {
      _$MenuViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onCancel() {
    final _$actionInfo = _$MenuViewModelBaseActionController.startAction(
        name: 'MenuViewModelBase.onCancel');
    try {
      return super.onCancel();
    } finally {
      _$MenuViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onSelectItem(Object item) {
    final _$actionInfo = _$MenuViewModelBaseActionController.startAction(
        name: 'MenuViewModelBase.onSelectItem');
    try {
      return super.onSelectItem(item);
    } finally {
      _$MenuViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onChangeFood(Food? food) {
    final _$actionInfo = _$MenuViewModelBaseActionController.startAction(
        name: 'MenuViewModelBase.onChangeFood');
    try {
      return super.onChangeFood(food);
    } finally {
      _$MenuViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic add(ComboItem item) {
    final _$actionInfo = _$MenuViewModelBaseActionController.startAction(
        name: 'MenuViewModelBase.add');
    try {
      return super.add(item);
    } finally {
      _$MenuViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic rem(ComboItem item) {
    final _$actionInfo = _$MenuViewModelBaseActionController.startAction(
        name: 'MenuViewModelBase.rem');
    try {
      return super.rem(item);
    } finally {
      _$MenuViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onStartDrag(TreeNode<dynamic> node) {
    final _$actionInfo = _$MenuViewModelBaseActionController.startAction(
        name: 'MenuViewModelBase.onStartDrag');
    try {
      return super.onStartDrag(node);
    } finally {
      _$MenuViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onOverDrag(TreeNode<Package> node) {
    final _$actionInfo = _$MenuViewModelBaseActionController.startAction(
        name: 'MenuViewModelBase.onOverDrag');
    try {
      return super.onOverDrag(node);
    } finally {
      _$MenuViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
formKey: ${formKey},
selectedItem: ${selectedItem},
root: ${root},
foods: ${foods},
selectedFood: ${selectedFood},
controller: ${controller},
draggedItem: ${draggedItem},
overItemConfirmed: ${overItemConfirmed},
nameEditingController: ${nameEditingController},
nameFocus: ${nameFocus},
priceEditingController: ${priceEditingController},
priceFocus: ${priceFocus},
descriptionEditingController: ${descriptionEditingController},
descriptionFocus: ${descriptionFocus},
image: ${image},
itemsQuantity: ${itemsQuantity}
    ''';
  }
}
