// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_restaurant_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditRestaurantViewModel on EditRestaurantViewModelBase, Store {
  late final _$restaurantAtom =
      Atom(name: 'EditRestaurantViewModelBase.restaurant', context: context);

  @override
  Restaurant get restaurant {
    _$restaurantAtom.reportRead();
    return super.restaurant;
  }

  @override
  set restaurant(Restaurant value) {
    _$restaurantAtom.reportWrite(value, super.restaurant, () {
      super.restaurant = value;
    });
  }

  late final _$emailEditingControllerAtom = Atom(
      name: 'EditRestaurantViewModelBase.emailEditingController',
      context: context);

  @override
  TextEditingController get emailEditingController {
    _$emailEditingControllerAtom.reportRead();
    return super.emailEditingController;
  }

  @override
  set emailEditingController(TextEditingController value) {
    _$emailEditingControllerAtom
        .reportWrite(value, super.emailEditingController, () {
      super.emailEditingController = value;
    });
  }

  late final _$nameEditingControllerAtom = Atom(
      name: 'EditRestaurantViewModelBase.nameEditingController',
      context: context);

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

  late final _$specialityEditingControllerAtom = Atom(
      name: 'EditRestaurantViewModelBase.specialityEditingController',
      context: context);

  @override
  TextEditingController get specialtyEditingController {
    _$specialityEditingControllerAtom.reportRead();
    return super.specialtyEditingController;
  }

  @override
  set specialtyEditingController(TextEditingController value) {
    _$specialityEditingControllerAtom
        .reportWrite(value, super.specialtyEditingController, () {
      super.specialtyEditingController = value;
    });
  }

  late final _$streetEditingControllerAtom = Atom(
      name: 'EditRestaurantViewModelBase.streetEditingController',
      context: context);

  @override
  TextEditingController get streetEditingController {
    _$streetEditingControllerAtom.reportRead();
    return super.streetEditingController;
  }

  @override
  set streetEditingController(TextEditingController value) {
    _$streetEditingControllerAtom
        .reportWrite(value, super.streetEditingController, () {
      super.streetEditingController = value;
    });
  }

  late final _$numberEditingControllerAtom = Atom(
      name: 'EditRestaurantViewModelBase.numberEditingController',
      context: context);

  @override
  TextEditingController get numberEditingController {
    _$numberEditingControllerAtom.reportRead();
    return super.numberEditingController;
  }

  @override
  set numberEditingController(TextEditingController value) {
    _$numberEditingControllerAtom
        .reportWrite(value, super.numberEditingController, () {
      super.numberEditingController = value;
    });
  }

  late final _$neighborhoodEditingControllerAtom = Atom(
      name: 'EditRestaurantViewModelBase.neighborhoodEditingController',
      context: context);

  @override
  TextEditingController get neighborhoodEditingController {
    _$neighborhoodEditingControllerAtom.reportRead();
    return super.neighborhoodEditingController;
  }

  @override
  set neighborhoodEditingController(TextEditingController value) {
    _$neighborhoodEditingControllerAtom
        .reportWrite(value, super.neighborhoodEditingController, () {
      super.neighborhoodEditingController = value;
    });
  }

  late final _$cityEditingControllerAtom = Atom(
      name: 'EditRestaurantViewModelBase.cityEditingController',
      context: context);

  @override
  TextEditingController get cityEditingController {
    _$cityEditingControllerAtom.reportRead();
    return super.cityEditingController;
  }

  @override
  set cityEditingController(TextEditingController value) {
    _$cityEditingControllerAtom.reportWrite(value, super.cityEditingController,
        () {
      super.cityEditingController = value;
    });
  }

  late final _$cepEditingControllerAtom = Atom(
      name: 'EditRestaurantViewModelBase.cepEditingController',
      context: context);

  @override
  TextEditingController get cepEditingController {
    _$cepEditingControllerAtom.reportRead();
    return super.cepEditingController;
  }

  @override
  set cepEditingController(TextEditingController value) {
    _$cepEditingControllerAtom.reportWrite(value, super.cepEditingController,
        () {
      super.cepEditingController = value;
    });
  }

  late final _$stateAtom =
      Atom(name: 'EditRestaurantViewModelBase.state', context: context);

  @override
  String? get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(String? value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$imageAtom =
      Atom(name: 'EditRestaurantViewModelBase.image', context: context);

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

  late final _$seePasswordAtom =
      Atom(name: 'EditRestaurantViewModelBase.seePassword', context: context);

  @override
  bool get seePassword {
    _$seePasswordAtom.reportRead();
    return super.seePassword;
  }

  @override
  set seePassword(bool value) {
    _$seePasswordAtom.reportWrite(value, super.seePassword, () {
      super.seePassword = value;
    });
  }

  late final _$selectImageAsyncAction =
      AsyncAction('EditRestaurantViewModelBase.selectImage', context: context);

  @override
  Future selectImage() {
    return _$selectImageAsyncAction.run(() => super.selectImage());
  }

  late final _$onSubmitAsyncAction =
      AsyncAction('EditRestaurantViewModelBase.onSubmit', context: context);

  @override
  Future onSubmit(BuildContext context, dynamic Function(Restaurant) onSave) {
    return _$onSubmitAsyncAction.run(() => super.onSubmit(context, onSave));
  }

  late final _$EditRestaurantViewModelBaseActionController =
      ActionController(name: 'EditRestaurantViewModelBase', context: context);

  @override
  dynamic onChangeState(String? selectState) {
    final _$actionInfo = _$EditRestaurantViewModelBaseActionController
        .startAction(name: 'EditRestaurantViewModelBase.onChangeState');
    try {
      return super.onChangeState(selectState);
    } finally {
      _$EditRestaurantViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
restaurant: ${restaurant},
emailEditingController: ${emailEditingController},
nameEditingController: ${nameEditingController},
specialtyEditingController: ${specialtyEditingController},
streetEditingController: ${streetEditingController},
numberEditingController: ${numberEditingController},
neighborhoodEditingController: ${neighborhoodEditingController},
cityEditingController: ${cityEditingController},
cepEditingController: ${cepEditingController},
state: ${state},
image: ${image},
seePassword: ${seePassword}
    ''';
  }
}
