import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food_restaurants/feature/order_page/order_viewmodel.dart';
import 'package:galaxy_food_restaurants/galaxy_theme.dart';

import 'order_view.dart';

class OrderPage extends StatefulWidget{
  const OrderPage({super.key});

  @override
  State<StatefulWidget> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>{

  final viewModel = OrderViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.update(context);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Container(
          color: Colors.black,
          child: TabView(
              currentIndex: viewModel.tabIndex,
              closeButtonVisibility: CloseButtonVisibilityMode.never,
              tabs: [
                Tab(
                  text: const Text("PEDIDOS DE HOJE"),
                  body: OrderView(
                    finishedList: viewModel.newFinishedOrders,
                    waitingList: viewModel.newWaitingOrders,
                    update: () => viewModel.update(context),
                  ),
                  backgroundColor: GalaxyFoodTheme.normal.inactiveBackgroundColor.withAlpha(70),
                  selectedBackgroundColor: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
                ),
                Tab(
                  text: const Text("PEDIDOS ANTERIORES"),
                  body: OrderView(
                    finishedList: viewModel.oldFinishedOrders,
                    waitingList: viewModel.oldWaitingOrders,
                    update: () => viewModel.update(context),
                  ),
                  backgroundColor: GalaxyFoodTheme.normal.inactiveBackgroundColor.withAlpha(70),
                  selectedBackgroundColor: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
                )
              ],
            onChanged: viewModel.onChangeTab,
          ),
        );
      }
    );
  }
}

