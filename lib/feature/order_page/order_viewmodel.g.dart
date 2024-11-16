// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderViewModel on OrderViewModelBase, Store {
  late final _$tabIndexAtom =
      Atom(name: 'OrderViewModelBase.tabIndex', context: context);

  @override
  int get tabIndex {
    _$tabIndexAtom.reportRead();
    return super.tabIndex;
  }

  @override
  set tabIndex(int value) {
    _$tabIndexAtom.reportWrite(value, super.tabIndex, () {
      super.tabIndex = value;
    });
  }

  late final _$oldFinishedOrdersAtom =
      Atom(name: 'OrderViewModelBase.oldFinishedOrders', context: context);

  @override
  ObservableList<Buy> get oldFinishedOrders {
    _$oldFinishedOrdersAtom.reportRead();
    return super.oldFinishedOrders;
  }

  @override
  set oldFinishedOrders(ObservableList<Buy> value) {
    _$oldFinishedOrdersAtom.reportWrite(value, super.oldFinishedOrders, () {
      super.oldFinishedOrders = value;
    });
  }

  late final _$oldWaitingOrdersAtom =
      Atom(name: 'OrderViewModelBase.oldWaitingOrders', context: context);

  @override
  ObservableList<Buy> get oldWaitingOrders {
    _$oldWaitingOrdersAtom.reportRead();
    return super.oldWaitingOrders;
  }

  @override
  set oldWaitingOrders(ObservableList<Buy> value) {
    _$oldWaitingOrdersAtom.reportWrite(value, super.oldWaitingOrders, () {
      super.oldWaitingOrders = value;
    });
  }

  late final _$newFinishedOrdersAtom =
      Atom(name: 'OrderViewModelBase.newFinishedOrders', context: context);

  @override
  ObservableList<Buy> get newFinishedOrders {
    _$newFinishedOrdersAtom.reportRead();
    return super.newFinishedOrders;
  }

  @override
  set newFinishedOrders(ObservableList<Buy> value) {
    _$newFinishedOrdersAtom.reportWrite(value, super.newFinishedOrders, () {
      super.newFinishedOrders = value;
    });
  }

  late final _$newWaitingOrdersAtom =
      Atom(name: 'OrderViewModelBase.newWaitingOrders', context: context);

  @override
  ObservableList<Buy> get newWaitingOrders {
    _$newWaitingOrdersAtom.reportRead();
    return super.newWaitingOrders;
  }

  @override
  set newWaitingOrders(ObservableList<Buy> value) {
    _$newWaitingOrdersAtom.reportWrite(value, super.newWaitingOrders, () {
      super.newWaitingOrders = value;
    });
  }

  late final _$updateAsyncAction =
      AsyncAction('OrderViewModelBase.update', context: context);

  @override
  Future update(BuildContext context) {
    return _$updateAsyncAction.run(() => super.update(context));
  }

  late final _$OrderViewModelBaseActionController =
      ActionController(name: 'OrderViewModelBase', context: context);

  @override
  dynamic onChangeTab(int value) {
    final _$actionInfo = _$OrderViewModelBaseActionController.startAction(
        name: 'OrderViewModelBase.onChangeTab');
    try {
      return super.onChangeTab(value);
    } finally {
      _$OrderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tabIndex: ${tabIndex},
oldFinishedOrders: ${oldFinishedOrders},
oldWaitingOrders: ${oldWaitingOrders},
newFinishedOrders: ${newFinishedOrders},
newWaitingOrders: ${newWaitingOrders}
    ''';
  }
}
