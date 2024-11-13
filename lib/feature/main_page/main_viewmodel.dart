
import 'package:mobx/mobx.dart';

part 'main_viewmodel.g.dart';

class MainViewModel = MainViewModelBase with _$MainViewModel;

abstract class MainViewModelBase with Store{

  @observable
  int index = 0;

  @action
  void onChangePage(int value){
    index = value;
  }

}