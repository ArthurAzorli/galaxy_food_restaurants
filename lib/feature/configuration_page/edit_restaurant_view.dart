import 'package:brasil_fields/brasil_fields.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food_restaurants/feature/configuration_page/edit_restaurant_viewmodel.dart';

import '../../core/domain/restaurant.dart';
import '../../core/utils/exception/repository_exception.dart';
import '../../core/widgets/galaxy_button.dart';
import '../../galaxy_theme.dart';

class EditRestaurantView extends StatefulWidget{

  final Restaurant restaurant;
  final Function(Restaurant) onSave;

  const EditRestaurantView({super.key, required this.restaurant, required this.onSave});

  @override
  State<StatefulWidget> createState() => EditRestaurantViewState();
}

class EditRestaurantViewState extends State<EditRestaurantView>{

  late final EditRestaurantViewModel viewModel;
  final emailFocus = FocusNode();
  final nameFocus = FocusNode();
  final specialtyFocus = FocusNode();
  final streetFocus = FocusNode();
  final numberFocus = FocusNode();
  final neighborhoodFocus = FocusNode();
  final cityFocus = FocusNode();
  final cepFocus = FocusNode();

  @override
  void initState() {
    viewModel = EditRestaurantViewModel(widget.restaurant);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewModel.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 5),
            child: Text("E-mail:", style: GalaxyFoodTheme.text.bodyLarge,),
          ),

          Observer(
              builder: (context) {
                return SizedBox(
                  height: 45,
                  child: TextFormBox(
                    cursorColor: Colors.white,
                    highlightColor: GalaxyFoodTheme.normal.activeColor,
                    focusNode: emailFocus,
                    controller: viewModel.emailEditingController,
                    keyboardType: TextInputType.emailAddress,
                    validator: viewModel.textValidator,
                    style: GalaxyFoodTheme.text.bodyLarge,
                    placeholder: "E-mail",
                    onTapOutside: (_) => emailFocus.unfocus(),
                  ),
                );
              }
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 5),
            child: Text("Nome:",  style: GalaxyFoodTheme.text.bodyLarge,),
          ),

          Observer(
              builder: (context) {
                return SizedBox(
                  height: 45,
                  child: TextFormBox(
                    cursorColor: Colors.white,
                    highlightColor: GalaxyFoodTheme.normal.activeColor,
                    focusNode: nameFocus,
                    controller: viewModel.nameEditingController,
                    validator: viewModel.textValidator,
                    style: GalaxyFoodTheme.text.bodyLarge,
                    placeholder: "Nome",
                    onTapOutside: (_) => nameFocus.unfocus(),
                  ),
                );
              }
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 5),
            child: Text("Especialidade:",  style: GalaxyFoodTheme.text.bodyLarge,),
          ),

          Observer(
              builder: (context) {
                return SizedBox(
                  height: 45,
                  child: TextFormBox(
                    cursorColor: Colors.white,
                    highlightColor: GalaxyFoodTheme.normal.activeColor,
                    focusNode: specialtyFocus,
                    validator: viewModel.textValidator,
                    controller: viewModel.specialtyEditingController,
                    style: GalaxyFoodTheme.text.bodyLarge,
                    placeholder: "Especialidade",
                    onTapOutside: (_) => specialtyFocus.unfocus(),
                  ),
                );
              }
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: Text("IMAGEM:", style: GalaxyFoodTheme.text.titleSmall,),
          ),

          Observer(
            builder: (context) {
              return AspectRatio(
                aspectRatio: 16/9,
                child: GestureDetector(
                  onTap: viewModel.selectImage,
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: GalaxyFoodTheme.normal.cardColor,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        image: viewModel.image == null || viewModel.image!.isEmpty
                            ? null
                            :
                        DecorationImage(
                            image: Image
                                .memory(viewModel.image!)
                                .image
                        )
                    ),
                    child: !(viewModel.image == null || viewModel.image!.isEmpty)
                        ? null
                        :
                    const Center(
                        child: Text("Selecione uma imagem")
                    ),
                  ),
                ),
              );
            }
          ),

          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text("Endereço", style: GalaxyFoodTheme.text.titleMedium),
          ),

          const Padding(
            padding: EdgeInsets.only(top: 5, bottom: 20),
            child: Divider(),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("CEP:",  style: GalaxyFoodTheme.text.bodyLarge,),
          ),

          Observer(
              builder: (context) {
                return SizedBox(
                  height: 45,
                  child: TextFormBox(
                    cursorColor: Colors.white,
                    highlightColor: GalaxyFoodTheme.normal.activeColor,
                    focusNode: cepFocus,
                    controller: viewModel.cepEditingController,
                    validator: viewModel.textValidator,
                    style: GalaxyFoodTheme.text.bodyLarge,
                    placeholder: "CEP",
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter(ponto: false),
                    ],
                    onTapOutside: (_) => cepFocus.unfocus(),
                  ),
                );
              }
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 5),
            child: Text("Rua:",  style: GalaxyFoodTheme.text.bodyLarge,),
          ),

          Observer(
              builder: (context) {
                return SizedBox(
                  height: 45,
                  child: TextFormBox(
                    cursorColor: Colors.white,
                    highlightColor: GalaxyFoodTheme.normal.activeColor,
                    focusNode: streetFocus,
                    controller: viewModel.streetEditingController,
                    validator: viewModel.textValidator,
                    style: GalaxyFoodTheme.text.bodyLarge,
                    placeholder: "Rua/Avenida",
                    onTapOutside: (_) => streetFocus.unfocus(),
                  ),
                );
              }
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 5),
            child: Text("Número:",  style: GalaxyFoodTheme.text.bodyLarge,),
          ),

          Observer(
              builder: (context) {
                return SizedBox(
                  height: 45,
                  child: TextFormBox(
                    cursorColor: Colors.white,
                    highlightColor: GalaxyFoodTheme.normal.activeColor,
                    focusNode: numberFocus,
                    controller: viewModel.numberEditingController,
                    validator: viewModel.textValidator,
                    style: GalaxyFoodTheme.text.bodyLarge,
                    placeholder: "Número",
                    onTapOutside: (_) => numberFocus.unfocus(),
                  ),
                );
              }
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 5),
            child: Text("Bairro:",  style: GalaxyFoodTheme.text.bodyLarge,),
          ),

          Observer(
              builder: (context) {
                return SizedBox(
                  height: 45,
                  child: TextFormBox(
                    cursorColor: Colors.white,
                    highlightColor: GalaxyFoodTheme.normal.activeColor,
                    focusNode: neighborhoodFocus,
                    controller: viewModel.neighborhoodEditingController,
                    validator: viewModel.textValidator,
                    style: GalaxyFoodTheme.text.bodyLarge,
                    placeholder: "Bairro",
                    onTapOutside: (_) => neighborhoodFocus.unfocus(),
                  ),
                );
              }
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 5),
            child: Text("Cidade:",  style: GalaxyFoodTheme.text.bodyLarge,),
          ),

          Observer(
              builder: (context) {
                return SizedBox(
                  height: 45,
                  child: TextFormBox(
                    cursorColor: Colors.white,
                    highlightColor: GalaxyFoodTheme.normal.activeColor,
                    focusNode: cityFocus,
                    controller: viewModel.cityEditingController,
                    validator: viewModel.textValidator,
                    style: GalaxyFoodTheme.text.bodyLarge,
                    placeholder: "Cidade",
                    onTapOutside: (_) => cityFocus.unfocus(),
                  ),
                );
              }
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 5),
            child: Text("Estado:",  style: GalaxyFoodTheme.text.bodyLarge,),
          ),

          Observer(
            builder: (context) {
              return SizedBox(
                height: 50,
                child: ComboBox(
                  value: viewModel.state,
                  placeholder: const Text("Estado"),
                  items: List.generate(
                      Estados.listaEstados.length,
                      (index){
                        var state = Estados.listaEstadosSigla[index];
                        return ComboBoxItem(
                          enabled: state != viewModel.restaurant.address.state,
                          value: state,
                          child: Text(Estados.listaEstados[index], style: GalaxyFoodTheme.text.bodyLarge),
                        );
                      }
                  ),
                  onChanged: viewModel.onChangeState,
                ),
              );
            }
          ),


          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      height: 50,
                      width: 180,
                      child: GalaxyButton(
                          onPressed: () => viewModel.onSubmit(context, widget.onSave),
                          child: const Text("SALVAR")
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      height: 50,
                      width: 180,
                      child: GalaxyButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("CANCELAR")
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )


        ],
      ),
    );
  }
  
}