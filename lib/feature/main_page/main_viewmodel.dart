
import 'package:fluent_ui/fluent_ui.dart';
import 'package:mobx/mobx.dart';

part 'main_viewmodel.g.dart';

class MainViewModel = MainViewModelBase with _$MainViewModel;

abstract class MainViewModelBase with Store{

  @observable
  PaneDisplayMode displayMode = PaneDisplayMode.open;

  @observable
  int index = 0;

  @action
  void onChangePage(int value){
    index = value;
  }

  @action
  void onCollapseMenu(){
    displayMode = displayMode == PaneDisplayMode.open
        ? PaneDisplayMode.compact
        : PaneDisplayMode.open;
  }
}