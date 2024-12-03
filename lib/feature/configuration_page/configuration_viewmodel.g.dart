// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConfigurationViewModel on ConfigurationViewModelBase, Store {
  late final _$restaurantAtom =
      Atom(name: 'ConfigurationViewModelBase.restaurant', context: context);

  @override
  Restaurant? get restaurant {
    _$restaurantAtom.reportRead();
    return super.restaurant;
  }

  @override
  set restaurant(Restaurant? value) {
    _$restaurantAtom.reportWrite(value, super.restaurant, () {
      super.restaurant = value;
    });
  }

  late final _$seeOldPasswordAtom =
      Atom(name: 'ConfigurationViewModelBase.seeOldPassword', context: context);

  @override
  bool get seeOldPassword {
    _$seeOldPasswordAtom.reportRead();
    return super.seeOldPassword;
  }

  @override
  set seeOldPassword(bool value) {
    _$seeOldPasswordAtom.reportWrite(value, super.seeOldPassword, () {
      super.seeOldPassword = value;
    });
  }

  late final _$seeNewPasswordAtom =
      Atom(name: 'ConfigurationViewModelBase.seeNewPassword', context: context);

  @override
  bool get seeNewPassword {
    _$seeNewPasswordAtom.reportRead();
    return super.seeNewPassword;
  }

  @override
  set seeNewPassword(bool value) {
    _$seeNewPasswordAtom.reportWrite(value, super.seeNewPassword, () {
      super.seeNewPassword = value;
    });
  }

  late final _$seePasswordAtom =
      Atom(name: 'ConfigurationViewModelBase.seePassword', context: context);

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

  late final _$removePhoneAsyncAction =
      AsyncAction('ConfigurationViewModelBase.removePhone', context: context);

  @override
  Future removePhone(material.BuildContext context, Phone phone) {
    return _$removePhoneAsyncAction
        .run(() => super.removePhone(context, phone));
  }

  late final _$ConfigurationViewModelBaseActionController =
      ActionController(name: 'ConfigurationViewModelBase', context: context);

  @override
  dynamic addNewPhone(material.BuildContext context) {
    final _$actionInfo = _$ConfigurationViewModelBaseActionController
        .startAction(name: 'ConfigurationViewModelBase.addNewPhone');
    try {
      return super.addNewPhone(context);
    } finally {
      _$ConfigurationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changePassword(material.BuildContext context) {
    final _$actionInfo = _$ConfigurationViewModelBaseActionController
        .startAction(name: 'ConfigurationViewModelBase.changePassword');
    try {
      return super.changePassword(context);
    } finally {
      _$ConfigurationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic editRestaurant(material.BuildContext context) {
    final _$actionInfo = _$ConfigurationViewModelBaseActionController
        .startAction(name: 'ConfigurationViewModelBase.editRestaurant');
    try {
      return super.editRestaurant(context);
    } finally {
      _$ConfigurationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onSaveRestaurant(
      material.BuildContext context, Restaurant restaurant) {
    final _$actionInfo = _$ConfigurationViewModelBaseActionController
        .startAction(name: 'ConfigurationViewModelBase.onSaveRestaurant');
    try {
      return super.onSaveRestaurant(context, restaurant);
    } finally {
      _$ConfigurationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic editRestaurantOwner(material.BuildContext context) {
    final _$actionInfo = _$ConfigurationViewModelBaseActionController
        .startAction(name: 'ConfigurationViewModelBase.editRestaurantOwner');
    try {
      return super.editRestaurantOwner(context);
    } finally {
      _$ConfigurationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic logout(material.BuildContext context) {
    final _$actionInfo = _$ConfigurationViewModelBaseActionController
        .startAction(name: 'ConfigurationViewModelBase.logout');
    try {
      return super.logout(context);
    } finally {
      _$ConfigurationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteRestaurant(material.BuildContext context) {
    final _$actionInfo = _$ConfigurationViewModelBaseActionController
        .startAction(name: 'ConfigurationViewModelBase.deleteRestaurant');
    try {
      return super.deleteRestaurant(context);
    } finally {
      _$ConfigurationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteOwner(material.BuildContext context) {
    final _$actionInfo = _$ConfigurationViewModelBaseActionController
        .startAction(name: 'ConfigurationViewModelBase.deleteOwner');
    try {
      return super.deleteOwner(context);
    } finally {
      _$ConfigurationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
restaurant: ${restaurant},
seeOldPassword: ${seeOldPassword},
seeNewPassword: ${seeNewPassword},
seePassword: ${seePassword}
    ''';
  }
}
