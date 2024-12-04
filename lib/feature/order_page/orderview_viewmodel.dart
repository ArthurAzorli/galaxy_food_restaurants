import 'package:flutter/material.dart';
import 'package:galaxy_food_restaurants/core/service/pdf_generate.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import '../../core/domain/buy.dart';
import '../../core/domain/order_status.dart';
import '../../core/service/repository/buy_repository_service.dart';
import '../../core/utils/exception/repository_exception.dart';

part 'orderview_viewmodel.g.dart';

class OrderViewViewModel = OrderViewViewModelBase with _$OrderViewViewModel;

abstract class OrderViewViewModelBase with Store {

  @observable
  Buy? selectedBuy;

  @observable
  OrderStatus? selectedStatus;

  @action
  onSelectOrder(Buy buy){
    if (selectedBuy == null || selectedBuy!.id != buy.id){
      selectedBuy = buy;
      selectedStatus = buy.orderStatus;
    }
  }

  @action
  onChangeStatus(BuildContext context, OrderStatus status, Function() update) async {
    try{
      selectedStatus = status;
      selectedBuy = await BuyRepositoryService.updateStatus(selectedBuy!.id, status);
      update();
    } on RepositoryException catch(e){
      e.showMessageDialog(context, (){
        Navigator.pop(context);
      });
    }
  }

  @action
  printing(){
    PDFGenerate(selectedBuy!).build().save();
  }
}