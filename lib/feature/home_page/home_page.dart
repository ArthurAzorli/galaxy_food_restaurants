import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food_restaurants/core/utils/bytes.dart';
import 'package:galaxy_food_restaurants/feature/home_page/home_viewmodel.dart';
import 'package:galaxy_food_restaurants/galaxy_theme.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();

}

class HomePageState extends State<HomePage>{

  late HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = HomeViewModel(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          Observer(
            builder: (context) {

              String name = viewModel.restaurant != null
                  ? viewModel.restaurant!.name
                  : "Usuário";

              var image = viewModel.restaurant?.image?.toUint8List;

              return Container(
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
                    image != null
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          opacity: 0.5,
                          image: Image.memory(image).image
                      )
                      : null,
                    borderRadius: const BorderRadius.vertical(bottom: Radius.elliptical(1800, 200)),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xa0000000),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 20
                      )
                    ]
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    child: Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: SizedBox(
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Olá, $name", style: GalaxyFoodTheme.text.headlineSmall,  textAlign: TextAlign.start,),
                                  Text(viewModel.restaurant?.cnpj??"", style: GalaxyFoodTheme.text.titleMedium)
                                ],
                              )
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: SizedBox(
                              width: double.maxFinite,
                              child: Text(viewModel.restaurant?.speciality??"", style: GalaxyFoodTheme.text.titleMedium, textAlign: TextAlign.start,)
                          ),
                        ),

                      ],
                    )
                ),
              );
            }
          ),

          Padding(
            padding: const EdgeInsets.only(top: 17.5),
            child: SizedBox(
              width: 700,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          color: GalaxyFoodTheme.normal.cardColor,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        padding: const EdgeInsets.all(25),
                        width: 325,
                        child: Row(
                          children: [

                            SizedBox(
                              width: 275,
                              child: Observer(
                                builder: (context) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Text("ENDEREÇO:", style: GalaxyFoodTheme.text.titleSmall,),
                                      ),
                                      Text(viewModel.restaurant?.address.toString()??"", style: GalaxyFoodTheme.text.bodyMedium,)
                                    ],
                                  );
                                }
                              ),
                            ),


                          ],
                        ),
                      ),


                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          color: GalaxyFoodTheme.normal.cardColor,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        width: 325,
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Row(
                            children: [

                              SizedBox(
                                width: 275,
                                child: Observer(
                                    builder: (context) {

                                      final list = List.generate(
                                          viewModel.restaurant?.phones.length??0,
                                          (index){
                                            return ListTile(
                                              title: Text(viewModel.restaurant!.phones[index].phone),
                                            );
                                          }
                                      );

                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Text("TELEFONES:", style: GalaxyFoodTheme.text.titleSmall,),
                                          ),

                                          Builder(
                                            builder: (context) {
                                              return Container(
                                                height: 250,
                                                width: double.maxFinite,
                                                decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                                  color: GalaxyFoodTheme.normal.menuColor,
                                                ),
                                                padding: const EdgeInsets.all(20),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: list,
                                                  ),
                                                ),
                                              );
                                            }
                                          ),
                                        ],
                                      );
                                    }
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          color: GalaxyFoodTheme.normal.cardColor,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Observer(
                            builder: (context) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          viewModel.restaurant?.score.toStringAsFixed(1)??"0.0",
                                          style: GalaxyFoodTheme.text.headlineMedium,
                                        ),
                                        const Icon(material.Icons.star, color: material.Colors.amber, size: 30,),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      color: GalaxyFoodTheme.normal.menuColor,
                                    ),
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Text("${viewModel.qtdOrders}  PEDIDOS REALIZADOS"),
                                        Text("${viewModel.qtdFoods} COMIDAS DISPONÍVEIS"),
                                        Text("${viewModel.qtdCombos}  COMBOS DISPONÍVEIS"),
                                      ],
                                    ),
                                  ),

                                ],
                              );
                            }
                          ),
                        ),
                      ),


                      Container(
                        width: 275,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          color: GalaxyFoodTheme.normal.cardColor,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        padding: const EdgeInsets.all(25),
                        child: Observer(
                            builder: (context) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text("DONO:", style: GalaxyFoodTheme.text.titleSmall,),
                                  ),
                                  Text(viewModel.restaurant?.owner.name??"", style: GalaxyFoodTheme.text.bodyLarge,),
                                  Text(viewModel.restaurant?.owner.cpf??"", style: GalaxyFoodTheme.text.bodyLarge,)
                                ],
                              );
                            }
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
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