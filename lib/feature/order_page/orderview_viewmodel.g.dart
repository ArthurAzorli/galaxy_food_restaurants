// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderview_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderViewViewModel on OrderViewViewModelBase, Store {
  late final _$selectedBuyAtom =
      Atom(name: 'OrderViewViewModelBase.selectedBuy', context: context);

  @override
  Buy? get selectedBuy {
    _$selectedBuyAtom.reportRead();
    return super.selectedBuy;
  }

  @override
  set selectedBuy(Buy? value) {
    _$selectedBuyAtom.reportWrite(value, super.selectedBuy, () {
      super.selectedBuy = value;
    });
  }

  late final _$selectedStatusAtom =
      Atom(name: 'OrderViewViewModelBase.selectedStatus', context: context);

  @override
  OrderStatus? get selectedStatus {
    _$selectedStatusAtom.reportRead();
    return super.selectedStatus;
  }

  @override
  set selectedStatus(OrderStatus? value) {
    _$selectedStatusAtom.reportWrite(value, super.selectedStatus, () {
      super.selectedStatus = value;
    });
  }

  late final _$onChangeStatusAsyncAction =
      AsyncAction('OrderViewViewModelBase.onChangeStatus', context: context);

  @override
  Future onChangeStatus(
      BuildContext context, OrderStatus status, dynamic Function() update) {
    return _$onChangeStatusAsyncAction
        .run(() => super.onChangeStatus(context, status, update));
  }

  late final _$OrderViewViewModelBaseActionController =
      ActionController(name: 'OrderViewViewModelBase', context: context);

  @override
  dynamic onSelectOrder(Buy buy) {
    final _$actionInfo = _$OrderViewViewModelBaseActionController.startAction(
        name: 'OrderViewViewModelBase.onSelectOrder');
    try {
      return super.onSelectOrder(buy);
    } finally {
      _$OrderViewViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic printing() {
    final _$actionInfo = _$OrderViewViewModelBaseActionController.startAction(
        name: 'OrderViewViewModelBase.printing');
    try {
      return super.printing();
    } finally {
      _$OrderViewViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedBuy: ${selectedBuy},
selectedStatus: ${selectedStatus}
    ''';
  }
}
