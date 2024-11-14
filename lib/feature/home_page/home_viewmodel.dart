import 'package:fluent_ui/fluent_ui.dart';
import 'package:galaxy_food_restaurants/core/service/repository/food_repository_service.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import '../../core/domain/restaurant.dart';
import '../../core/service/repository/buy_repository_service.dart';
import '../../core/service/repository/combo_repository_service.dart';
import '../../core/service/repository/restaurant_repository_service.dart';
import '../../core/utils/exception/repository_exception.dart';

part 'home_viewmodel.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store{

  @observable
  Restaurant? restaurant;

  @observable
  int qtdOrders = 0;

  @observable
  int qtdFoods = 0;

  @observable
  int qtdCombos = 0;

  HomeViewModelBase(BuildContext context){
    _getRestaurant(context);
  }

  void _getRestaurant(BuildContext context) async{
    try {
      restaurant = await RestaurantRepositoryService.getUser();
      _getQntCombos(context);
      _getQntFoods(context);
      _getQntOrders(context);
    } on RepositoryException catch(e) {
      e.showMessageDialog(context, (){
        Navigator.of(context).pop();
        context.go("/signin");
      });
    }
  }

  void _getQntOrders(BuildContext context) async{
    try {
      qtdOrders = await BuyRepositoryService.getCountBuy(restaurant!.id!);
    } on RepositoryException catch(e) {
      e.showMessageDialog(context, (){
        Navigator.of(context).pop();
      });
    }
  }

  void _getQntFoods(BuildContext context) async{
    try {
      qtdFoods = await FoodRepositoryService.getCountFood(restaurant!.id!);
    } on RepositoryException catch(e) {
      e.showMessageDialog(context, (){
        Navigator.of(context).pop();
      });
    }
  }

  void _getQntCombos(BuildContext context) async{
    try {
      qtdCombos = await ComboRepositoryService.getCountCombo(restaurant!.id!);
    } on RepositoryException catch(e) {
      e.showMessageDialog(context, (){
        Navigator.of(context).pop();
      });
    }
  }

}

