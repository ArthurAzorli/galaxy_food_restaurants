// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignUpViewModel on SignUpViewModelBase, Store {
  late final _$existsOwnerAtom =
      Atom(name: 'SignUpViewModelBase.existsOwner', context: context);

  @override
  bool? get existsOwner {
    _$existsOwnerAtom.reportRead();
    return super.existsOwner;
  }

  @override
  set existsOwner(bool? value) {
    _$existsOwnerAtom.reportWrite(value, super.existsOwner, () {
      super.existsOwner = value;
    });
  }

  late final _$idOwnerAtom =
      Atom(name: 'SignUpViewModelBase.idOwner', context: context);

  @override
  String? get idOwner {
    _$idOwnerAtom.reportRead();
    return super.idOwner;
  }

  @override
  set idOwner(String? value) {
    _$idOwnerAtom.reportWrite(value, super.idOwner, () {
      super.idOwner = value;
    });
  }

  late final _$seePasswordAtom =
      Atom(name: 'SignUpViewModelBase.seePassword', context: context);

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

  late final _$stateAtom =
      Atom(name: 'SignUpViewModelBase.state', context: context);

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

  late final _$ownerCpfEditingControllerAtom = Atom(
      name: 'SignUpViewModelBase.ownerCpfEditingController', context: context);

  @override
  TextEditingController get ownerCpfEditingController {
    _$ownerCpfEditingControllerAtom.reportRead();
    return super.ownerCpfEditingController;
  }

  @override
  set ownerCpfEditingController(TextEditingController value) {
    _$ownerCpfEditingControllerAtom
        .reportWrite(value, super.ownerCpfEditingController, () {
      super.ownerCpfEditingController = value;
    });
  }

  late final _$ownerRgEditingControllerAtom = Atom(
      name: 'SignUpViewModelBase.ownerRgEditingController', context: context);

  @override
  TextEditingController get ownerRgEditingController {
    _$ownerRgEditingControllerAtom.reportRead();
    return super.ownerRgEditingController;
  }

  @override
  set ownerRgEditingController(TextEditingController value) {
    _$ownerRgEditingControllerAtom
        .reportWrite(value, super.ownerRgEditingController, () {
      super.ownerRgEditingController = value;
    });
  }

  late final _$ownerNameEditingControllerAtom = Atom(
      name: 'SignUpViewModelBase.ownerNameEditingController', context: context);

  @override
  TextEditingController get ownerNameEditingController {
    _$ownerNameEditingControllerAtom.reportRead();
    return super.ownerNameEditingController;
  }

  @override
  set ownerNameEditingController(TextEditingController value) {
    _$ownerNameEditingControllerAtom
        .reportWrite(value, super.ownerNameEditingController, () {
      super.ownerNameEditingController = value;
    });
  }

  late final _$ownerBirthDateEditingControllerAtom = Atom(
      name: 'SignUpViewModelBase.ownerBirthDateEditingController',
      context: context);

  @override
  TextEditingController get ownerBirthDateEditingController {
    _$ownerBirthDateEditingControllerAtom.reportRead();
    return super.ownerBirthDateEditingController;
  }

  @override
  set ownerBirthDateEditingController(TextEditingController value) {
    _$ownerBirthDateEditingControllerAtom
        .reportWrite(value, super.ownerBirthDateEditingController, () {
      super.ownerBirthDateEditingController = value;
    });
  }

  late final _$cnpjEditingControllerAtom =
      Atom(name: 'SignUpViewModelBase.cnpjEditingController', context: context);

  @override
  TextEditingController get cnpjEditingController {
    _$cnpjEditingControllerAtom.reportRead();
    return super.cnpjEditingController;
  }

  @override
  set cnpjEditingController(TextEditingController value) {
    _$cnpjEditingControllerAtom.reportWrite(value, super.cnpjEditingController,
        () {
      super.cnpjEditingController = value;
    });
  }

  late final _$emailEditingControllerAtom = Atom(
      name: 'SignUpViewModelBase.emailEditingController', context: context);

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

  late final _$nameEditingControllerAtom =
      Atom(name: 'SignUpViewModelBase.nameEditingController', context: context);

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

  late final _$specialtyEditingControllerAtom = Atom(
      name: 'SignUpViewModelBase.specialtyEditingController', context: context);

  @override
  TextEditingController get specialtyEditingController {
    _$specialtyEditingControllerAtom.reportRead();
    return super.specialtyEditingController;
  }

  @override
  set specialtyEditingController(TextEditingController value) {
    _$specialtyEditingControllerAtom
        .reportWrite(value, super.specialtyEditingController, () {
      super.specialtyEditingController = value;
    });
  }

  late final _$passwordEditingControllerAtom = Atom(
      name: 'SignUpViewModelBase.passwordEditingController', context: context);

  @override
  TextEditingController get passwordEditingController {
    _$passwordEditingControllerAtom.reportRead();
    return super.passwordEditingController;
  }

  @override
  set passwordEditingController(TextEditingController value) {
    _$passwordEditingControllerAtom
        .reportWrite(value, super.passwordEditingController, () {
      super.passwordEditingController = value;
    });
  }

  late final _$cepEditingControllerAtom =
      Atom(name: 'SignUpViewModelBase.cepEditingController', context: context);

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

  late final _$streetEditingControllerAtom = Atom(
      name: 'SignUpViewModelBase.streetEditingController', context: context);

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
      name: 'SignUpViewModelBase.numberEditingController', context: context);

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
      name: 'SignUpViewModelBase.neighborhoodEditingController',
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

  late final _$cityEditingControllerAtom =
      Atom(name: 'SignUpViewModelBase.cityEditingController', context: context);

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

  late final _$checkOwnerAsyncAction =
      AsyncAction('SignUpViewModelBase.checkOwner', context: context);

  @override
  Future checkOwner(BuildContext context) {
    return _$checkOwnerAsyncAction.run(() => super.checkOwner(context));
  }

  late final _$submitAsyncAction =
      AsyncAction('SignUpViewModelBase.submit', context: context);

  @override
  Future<void> submit(BuildContext context) {
    return _$submitAsyncAction.run(() => super.submit(context));
  }

  late final _$SignUpViewModelBaseActionController =
      ActionController(name: 'SignUpViewModelBase', context: context);

  @override
  void changeVisibilityPassword() {
    final _$actionInfo = _$SignUpViewModelBaseActionController.startAction(
        name: 'SignUpViewModelBase.changeVisibilityPassword');
    try {
      return super.changeVisibilityPassword();
    } finally {
      _$SignUpViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? textValidator(String? text) {
    final _$actionInfo = _$SignUpViewModelBaseActionController.startAction(
        name: 'SignUpViewModelBase.textValidator');
    try {
      return super.textValidator(text);
    } finally {
      _$SignUpViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? passwordValidator(String? password) {
    final _$actionInfo = _$SignUpViewModelBaseActionController.startAction(
        name: 'SignUpViewModelBase.passwordValidator');
    try {
      return super.passwordValidator(password);
    } finally {
      _$SignUpViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? birthDateValidator(String? date) {
    final _$actionInfo = _$SignUpViewModelBaseActionController.startAction(
        name: 'SignUpViewModelBase.birthDateValidator');
    try {
      return super.birthDateValidator(date);
    } finally {
      _$SignUpViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onChangeState(String? selectState) {
    final _$actionInfo = _$SignUpViewModelBaseActionController.startAction(
        name: 'SignUpViewModelBase.onChangeState');
    try {
      return super.onChangeState(selectState);
    } finally {
      _$SignUpViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void signin(BuildContext context) {
    final _$actionInfo = _$SignUpViewModelBaseActionController.startAction(
        name: 'SignUpViewModelBase.signin');
    try {
      return super.signin(context);
    } finally {
      _$SignUpViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
existsOwner: ${existsOwner},
idOwner: ${idOwner},
seePassword: ${seePassword},
state: ${state},
ownerCpfEditingController: ${ownerCpfEditingController},
ownerRgEditingController: ${ownerRgEditingController},
ownerNameEditingController: ${ownerNameEditingController},
ownerBirthDateEditingController: ${ownerBirthDateEditingController},
cnpjEditingController: ${cnpjEditingController},
emailEditingController: ${emailEditingController},
nameEditingController: ${nameEditingController},
specialtyEditingController: ${specialtyEditingController},
passwordEditingController: ${passwordEditingController},
cepEditingController: ${cepEditingController},
streetEditingController: ${streetEditingController},
numberEditingController: ${numberEditingController},
neighborhoodEditingController: ${neighborhoodEditingController},
cityEditingController: ${cityEditingController}
    ''';
  }
}
