// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on HomeViewModelBase, Store {
  late final _$restaurantAtom =
      Atom(name: 'HomeViewModelBase.restaurant', context: context);

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

  late final _$qtdOrdersAtom =
      Atom(name: 'HomeViewModelBase.qtdOrders', context: context);

  @override
  int get qtdOrders {
    _$qtdOrdersAtom.reportRead();
    return super.qtdOrders;
  }

  @override
  set qtdOrders(int value) {
    _$qtdOrdersAtom.reportWrite(value, super.qtdOrders, () {
      super.qtdOrders = value;
    });
  }

  late final _$qtdFoodsAtom =
      Atom(name: 'HomeViewModelBase.qtdFoods', context: context);

  @override
  int get qtdFoods {
    _$qtdFoodsAtom.reportRead();
    return super.qtdFoods;
  }

  @override
  set qtdFoods(int value) {
    _$qtdFoodsAtom.reportWrite(value, super.qtdFoods, () {
      super.qtdFoods = value;
    });
  }

  late final _$qtdCombosAtom =
      Atom(name: 'HomeViewModelBase.qtdCombos', context: context);

  @override
  int get qtdCombos {
    _$qtdCombosAtom.reportRead();
    return super.qtdCombos;
  }

  @override
  set qtdCombos(int value) {
    _$qtdCombosAtom.reportWrite(value, super.qtdCombos, () {
      super.qtdCombos = value;
    });
  }

  @override
  String toString() {
    return '''
restaurant: ${restaurant},
qtdOrders: ${qtdOrders},
qtdFoods: ${qtdFoods},
qtdCombos: ${qtdCombos}
    ''';
  }
}
