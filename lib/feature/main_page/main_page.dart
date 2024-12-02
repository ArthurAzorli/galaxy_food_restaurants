import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food_restaurants/feature/configuration_page/configuration_page.dart';
import 'package:galaxy_food_restaurants/feature/home_page/home_page.dart';
import 'package:galaxy_food_restaurants/feature/main_page/main_viewmodel.dart';
import 'package:galaxy_food_restaurants/feature/menu_page/menu_page.dart';
import 'package:galaxy_food_restaurants/feature/order_page/order_page.dart';
import 'package:galaxy_food_restaurants/galaxy_theme.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();

}

class _MainPageState extends State<MainPage>{

  final viewModel = MainViewModel();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return NavigationView(
          contentShape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          pane: NavigationPane(
            selected: viewModel.index,
            displayMode: viewModel.displayMode,
            size: const NavigationPaneSize(
              openMinWidth: 80,
              openMaxWidth: 250,
              compactWidth: 80,
            ),
            menuButton: GestureDetector(
              onTap: viewModel.onCollapseMenu,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Icon(FluentIcons.collapse_menu, size: 40, color: Colors.white,),
              ),
            ),
            header: Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 50,),
              child: Image.asset(
                "lib/images/galaxyfood_logo.png",
                width: 125,
                color: Colors.white,
              ),
            ),
            items: [
              PaneItem(
                  icon: const Icon(FluentIcons.home, size: 40, color: Colors.white,),
                  title: Text("HOME", style: GalaxyFoodTheme.text.titleMedium,),
                  body: Container(
                    color: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
                    child: const HomePage(),
                  ),
              ),
              PaneItem(
                  icon: const Icon(FluentIcons.list, size: 40, color: Colors.white,),
                  title: Text("PEDIDOS", style: GalaxyFoodTheme.text.titleMedium,),
                  body: Container(
                    color: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
                    child: const OrderPage(),
                  ),
              ),
              PaneItem(
                  icon: const Icon(FluentIcons.fabric_folder, size: 40, color: Colors.white,),
                  title: Text("CARDÁPIO", style: GalaxyFoodTheme.text.titleMedium,),
                  body: Container(
                    color: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
                    child: const MenuPage(),
                  ),
              ),
              PaneItem(
                  icon: const Icon(FluentIcons.settings, size: 40, color: Colors.white,),
                  title: Text("CONFIGURAÇÕES", style: GalaxyFoodTheme.text.titleMedium,),
                  body: Container(
                    color: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
                    child: const ConfigurationPage(),
                  ),
              ),
            ],
            onChanged: viewModel.onChangePage
          ),
        );
      }
    );
  }

}