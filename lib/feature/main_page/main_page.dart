import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food_restaurants/feature/main_page/main_viewmodel.dart';
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
          pane: NavigationPane(
            selected: viewModel.index,
            size: const NavigationPaneSize(
              openMaxWidth: 250,
              openMinWidth: 80,
            ),
            header: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 50,),
              child: Center(
                child: Image.asset(
                  "lib/images/galaxyfood_logo.png",
                  width: 200,
                  color: Colors.white,
                ),
              ),
            ),
            items: [
              PaneItem(
                  icon: const Icon(FluentIcons.home, size: 40, color: Colors.white,),
                  title: Text("HOME", style: GalaxyFoodTheme.text.titleMedium,),
                  body: Container(
                    color: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
                    child: const Center(
                      child: Text("Home"),
                    ),
                  ),
              ),
              PaneItem(
                  icon: const Icon(FluentIcons.list, size: 40, color: Colors.white,),
                  title: Text("PEDIDOS", style: GalaxyFoodTheme.text.titleMedium,),
                  body: Container(
                    color: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
                    child: const Center(
                      child: Text("Pedidos"),
                    ),
                  ),
              ),
              PaneItem(
                  icon: const Icon(FluentIcons.fabric_folder, size: 40, color: Colors.white,),
                  title: Text("CARDÁPIO", style: GalaxyFoodTheme.text.titleMedium,),
                  body: Container(
                    color: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
                    child: const Center(
                      child: Text("Cardápio"),
                    ),
                  ),
              ),
              PaneItem(
                  icon: const Icon(FluentIcons.settings, size: 40, color: Colors.white,),
                  title: Text("CONFIGURAÇÕES", style: GalaxyFoodTheme.text.titleMedium,),
                  body: Container(
                    color: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
                    child: const Center(
                      child: Text("Config"),
                    ),
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