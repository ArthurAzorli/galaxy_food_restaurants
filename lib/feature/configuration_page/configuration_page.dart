import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food_restaurants/core/utils/bytes.dart';
import 'package:galaxy_food_restaurants/feature/configuration_page/configuration_viewmodel.dart';

import '../../core/widgets/galaxy_button.dart';
import '../../galaxy_theme.dart';

class ConfigurationPage extends StatefulWidget{
  const ConfigurationPage({super.key});

  @override
  State<StatefulWidget> createState() => ConfigurationPageState();

}

class ConfigurationPageState extends State<ConfigurationPage>{

  late ConfigurationViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ConfigurationViewModel(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          Observer(
            builder: (context) {

              var image = viewModel.restaurant?.image?.toUint8List;

              return Container(
                height: 225,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    color: GalaxyFoodTheme.normal.activeColor,
                    border: const Border(
                        bottom: BorderSide(
                            width: 1,
                            color: Color(0xfffafafa)
                        )
                    ),
                    image:
                    image == null || image.isEmpty
                        ? null
                        : DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.memory(image).image
                    ),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.elliptical(1800, 200)),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xa0000000),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 20
                      )
                    ]
                ),
                child: Center(
                  child:  Text(
                    "CONFIGURAÇÕES", style: GalaxyFoodTheme.text.titleLarge,
                  ),
                ),
              );
            }
          ),

          Padding(
            padding: const EdgeInsets.only(top: 17.5),
            child: SizedBox(
              width: 700,
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Icon(material.Icons.phone, size: 25,),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("Telefones", style: GalaxyFoodTheme.text.titleMedium),
                        ),
                      ],
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Divider(),
                  ),

                  Observer(
                    builder: (context) {
                      return Container(
                        height: 300,
                        margin: const EdgeInsets.only(top: 30, bottom: 15, left: 50, right: 50),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: GalaxyFoodTheme.normal.inactiveBackgroundColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: viewModel.restaurant == null || viewModel.restaurant!.phones.isEmpty
                          ? Center(
                            child: Text(
                              "NENHUM TELEFONE CADASTRADO!",
                              textAlign: TextAlign.center,
                              style: GalaxyFoodTheme.text.titleLarge?.merge(
                                  TextStyle(color: GalaxyFoodTheme.normal.cardColor)
                              ),
                            ),
                          )
                          : ListView.builder(
                            itemCount: viewModel.restaurant!.phones.length,
                            itemBuilder: (context, index){
                              final phone = viewModel.restaurant!.phones[index];
                              return ListTile(
                                tileColor: WidgetStatePropertyAll(GalaxyFoodTheme.normal.cardColor),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                trailing: IconButton(
                                  icon: const Icon(material.Icons.close, size: 25,),
                                  onPressed: () => viewModel.removePhone(context, phone)
                                ),
                                title: Text(phone.phone, style: GalaxyFoodTheme.text.bodyLarge,),
                              );
                            },
                          ),
                      );
                    }
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 45, left: 50, right: 50),
                    child: SizedBox(
                      height: 60,
                      width: double.maxFinite,
                      child: GalaxyButton(
                          onPressed: () => viewModel.addNewPhone(context),
                          child: Text("ADICIONAR", style: GalaxyFoodTheme.text.titleMedium,)
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Icon(material.Icons.settings, size: 25,),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("Configurações", style: GalaxyFoodTheme.text.titleMedium),
                        ),
                      ],
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 45),
                    child: Divider(),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 50, right: 50),
                    child: SizedBox(
                      height: 80,
                      width: double.maxFinite,
                      child: GalaxyButton(
                          onPressed: () => viewModel.changePassword(context),
                          child: Text("ALTERAR SENHA", style: GalaxyFoodTheme.text.titleMedium,)
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 50, right: 50),
                    child: SizedBox(
                      height: 80,
                      width: double.maxFinite,
                      child: GalaxyButton(
                          onPressed: () => viewModel.editRestaurant(context),
                          child: Text("EDITAR RESTAURANTE", style: GalaxyFoodTheme.text.titleMedium,)
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 50, right: 50),
                    child: SizedBox(
                      height: 80,
                      width: double.maxFinite,
                      child: GalaxyButton(
                          onPressed: () => viewModel.editRestaurantOwner(context),
                          child: Text("EDITAR DONO", style: GalaxyFoodTheme.text.titleMedium,)
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 50, right: 50),
                    child: SizedBox(
                      height: 80,
                      width: double.maxFinite,
                      child: GalaxyButton(
                          onPressed: () => viewModel.logout(context),
                          child: Text("SAIR DA CONTA", style: GalaxyFoodTheme.text.titleMedium,)
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, left: 50, right: 50),
                    child: SizedBox(
                      height: 80,
                      width: double.maxFinite,
                      child: GalaxyButton(
                          onPressed: () {},
                          child: Text("DELETAR RESTAURANTE", style: GalaxyFoodTheme.text.titleMedium,)
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 30, left: 50, right: 50),
                    child: SizedBox(
                      height: 80,
                      width: double.maxFinite,
                      child: GalaxyButton(
                          onPressed: () {},
                          child: Text("DELETAR DONO", style: GalaxyFoodTheme.text.titleMedium,)
                      ),
                    ),
                  ),


                ],
              )
            )
          ),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),

          const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Text("Todos os direitos reservados © 2024 Galaxy Food"),
          )

        ],
      ),
    );
  }

}