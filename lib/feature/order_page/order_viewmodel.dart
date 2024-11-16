import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import '../../core/domain/buy.dart';
import '../../core/domain/order_status.dart';
import '../../core/service/repository/buy_repository_service.dart';
import '../../core/utils/exception/repository_exception.dart';

part 'order_viewmodel.g.dart';

class OrderViewModel = OrderViewModelBase with _$OrderViewModel;

abstract class OrderViewModelBase with Store {

  @observable
  int tabIndex = 0;

  @observable
  ObservableList<Buy> oldFinishedOrders = ObservableList();

  @observable
  ObservableList<Buy> oldWaitingOrders = ObservableList();

  @observable
  ObservableList<Buy> newFinishedOrders = ObservableList();

  @observable
  ObservableList<Buy> newWaitingOrders = ObservableList();

  @action
  update(BuildContext context) async {
    try {
      final buys = await BuyRepositoryService.getAll();
      final oldFinishedOrders = <Buy>[];
      final oldWaitingOrders = <Buy>[];
      final newFinishedOrders = <Buy>[];
      final newWaitingOrders = <Buy>[];


      for (var buy in buys){
        if (buy.date.difference(DateTime.now()).inHours<-24){
          if (buy.orderStatus == OrderStatus.delivered || buy.orderStatus == OrderStatus.canceled){
            oldFinishedOrders.add(buy);
          } else {
            oldWaitingOrders.add(buy);
          }
        } else {
          if (buy.orderStatus == OrderStatus.delivered || buy.orderStatus == OrderStatus.canceled){
            newFinishedOrders.add(buy);
          } else {
            newWaitingOrders.add(buy);
          }
        }
      }

      this.oldFinishedOrders.clear();
      this.oldWaitingOrders.clear();
      this.newFinishedOrders.clear();
      this.newWaitingOrders.clear();

      this.oldFinishedOrders.addAll(oldFinishedOrders);
      this.oldWaitingOrders.addAll(oldWaitingOrders);
      this.newFinishedOrders.addAll(newFinishedOrders);
      this.newWaitingOrders.addAll(newWaitingOrders);

    } on RepositoryException catch(e) {
      e.showMessageDialog(context, () {
        Navigator.of(context).pop();
        context.go("/signin");
      });
    }
  }

  @action
  onChangeTab(int value){
    tabIndex = value;
  }
}