import 'package:brasil_fields/brasil_fields.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food_restaurants/feature/signup_page/signup_viewmodel.dart';

import '../../core/widgets/galaxy_button.dart';
import '../../galaxy_theme.dart';

class SignUpPage extends StatefulWidget{
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => SignUpPageState();

}

class SignUpPageState extends State<SignUpPage>{

  final viewModel = SignUpViewModel();

  final ownerCpfFocus = FocusNode();
  final ownerRgFocus = FocusNode();
  final ownerNameFocus = FocusNode();
  final ownerBirthDateFocus = FocusNode();
  final cnpjFocus = FocusNode();
  final emailFocus = FocusNode();
  final nameFocus = FocusNode();
  final specialtyFocus = FocusNode();
  final passwordFocus = FocusNode();
  final cepFocus = FocusNode();
  final streetFocus = FocusNode();
  final numberFocus = FocusNode();
  final neighborhoodFocus = FocusNode();
  final cityFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: SingleChildScrollView(
        child: Center(
          child: SizedBox(
              width: 600,
              child: Observer(
                builder: (context) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Image.asset(
                          "lib/images/galaxyfood_logo.png",
                          height: 125,
                          color: Colors.white,
                        ),
                      ),

                      if (viewModel.existsOwner == null)
                        ..._buildCheckOwner()
                      else
                        ..._buildForms()

                    ],
                  );
                }
              ),
            ),
        ),
      ),
    );
  }

  _buildForms(){
    return [
      Form(
        key: viewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 5),
              child: Center(
                child: Text(
                  "CADASTRE-SE",
                  style: GalaxyFoodTheme.text.titleLarge,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 5),
              child: Text("CNPJ:",  style: GalaxyFoodTheme.text.bodyLarge,),
            ),

            SizedBox(
              height: 45,
              child: TextFormBox(
                cursorColor: Colors.white,
                highlightColor: GalaxyFoodTheme.normal.activeColor,
                focusNode: cnpjFocus,
                controller: viewModel.cnpjEditingController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CnpjInputFormatter(),
                ],
                validator: viewModel.textValidator,
                style: GalaxyFoodTheme.text.bodyLarge,
                placeholder: "CNPJ",
                onTapOutside: (_) => cnpjFocus.unfocus(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 5),
              child: Text("E-mail:",  style: GalaxyFoodTheme.text.bodyLarge,),
            ),

            SizedBox(
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
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 5),
              child: Text("Nome:",  style: GalaxyFoodTheme.text.bodyLarge,),
            ),

            SizedBox(
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
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 5),
              child: Text("Especialidade:",  style: GalaxyFoodTheme.text.bodyLarge,),
            ),

            SizedBox(
              height: 45,
              child: TextFormBox(
                cursorColor: Colors.white,
                highlightColor: GalaxyFoodTheme.normal.activeColor,
                focusNode: specialtyFocus,
                controller: viewModel.specialtyEditingController,
                validator: viewModel.textValidator,
                style: GalaxyFoodTheme.text.bodyLarge,
                placeholder: "Especialidade",
                onTapOutside: (_) => specialtyFocus.unfocus(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 5),
              child: Text("Senha:",  style: GalaxyFoodTheme.text.bodyLarge,),
            ),

            SizedBox(
              height: 45,
              child: TextFormBox(
                cursorColor: Colors.white,
                highlightColor: GalaxyFoodTheme.normal.activeColor,
                focusNode: passwordFocus,
                controller: viewModel.passwordEditingController,
                obscureText: !viewModel.seePassword,
                validator: viewModel.passwordValidator,
                style: GalaxyFoodTheme.text.bodyLarge,
                placeholder: "Senha",
                suffix: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: GestureDetector(
                      onTap: viewModel.changeVisibilityPassword,
                      child: Icon(viewModel.seePassword
                          ? material.Icons.visibility_off_outlined
                          : material.Icons.visibility_outlined,
                        color: Colors.white,
                        size: 25,
                      )
                  ),
                ),
                onTapOutside: (_) => passwordFocus.unfocus(),
              ),
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

            SizedBox(
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
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 5),
              child: Text("Rua:",  style: GalaxyFoodTheme.text.bodyLarge,),
            ),

            SizedBox(
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
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 5),
              child: Text("Número:",  style: GalaxyFoodTheme.text.bodyLarge,),
            ),

            SizedBox(
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
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 5),
              child: Text("Bairro:",  style: GalaxyFoodTheme.text.bodyLarge,),
            ),

            SizedBox(
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
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 5),
              child: Text("Cidade:",  style: GalaxyFoodTheme.text.bodyLarge,),
            ),

            SizedBox(
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
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 5),
              child: Text("Estado:",  style: GalaxyFoodTheme.text.bodyLarge,),
            ),

            SizedBox(
              height: 50,
              child: ComboBox(
                value: viewModel.state,
                placeholder: const Text("Estado"),
                items: List.generate(
                    Estados.listaEstados.length,
                        (index){
                      var state = Estados.listaEstadosSigla[index];
                      return ComboBoxItem(
                        value: state,
                        child: Text(Estados.listaEstados[index], style: GalaxyFoodTheme.text.bodyLarge),
                      );
                    }
                ),
                onChanged: viewModel.onChangeState,
              ),
            ),

            if (!viewModel.existsOwner!)
              ...[
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text("Dono", style: GalaxyFoodTheme.text.titleMedium),
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 20),
                  child: Divider(),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 5),
                  child: Text("CPF:",  style: GalaxyFoodTheme.text.bodyLarge,),
                ),

                SizedBox(
                  height: 45,
                  child: TextFormBox(
                    cursorColor: Colors.white,
                    highlightColor: GalaxyFoodTheme.normal.activeColor,
                    focusNode: ownerCpfFocus,
                    controller: viewModel.ownerCpfEditingController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                    validator: viewModel.textValidator,
                    style: GalaxyFoodTheme.text.bodyLarge,
                    placeholder: "CPF",
                    onTapOutside: (_) => ownerCpfFocus.unfocus(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 5),
                  child: Text("RG:",  style: GalaxyFoodTheme.text.bodyLarge,),
                ),

                SizedBox(
                  height: 45,
                  child: TextFormBox(
                    cursorColor: Colors.white,
                    highlightColor: GalaxyFoodTheme.normal.activeColor,
                    focusNode: ownerRgFocus,
                    controller: viewModel.ownerRgEditingController,
                    keyboardType: TextInputType.number,
                    validator: viewModel.textValidator,
                    style: GalaxyFoodTheme.text.bodyLarge,
                    placeholder: "RG",
                    onTapOutside: (_) => ownerRgFocus.unfocus(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 5),
                  child: Text("Nome:",  style: GalaxyFoodTheme.text.bodyLarge,),
                ),

                SizedBox(
                  height: 45,
                  child: TextFormBox(
                    cursorColor: Colors.white,
                    highlightColor: GalaxyFoodTheme.normal.activeColor,
                    focusNode: ownerNameFocus,
                    controller: viewModel.ownerNameEditingController,
                    validator: viewModel.textValidator,
                    style: GalaxyFoodTheme.text.bodyLarge,
                    placeholder: "Nome",
                    onTapOutside: (_) => ownerNameFocus.unfocus(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 5),
                  child: Text("Data de Nascimento:",  style: GalaxyFoodTheme.text.bodyLarge,),
                ),

                SizedBox(
                  height: 45,
                  child: TextFormBox(
                    cursorColor: Colors.white,
                    highlightColor: GalaxyFoodTheme.normal.activeColor,
                    focusNode: ownerBirthDateFocus,
                    controller: viewModel.ownerBirthDateEditingController,
                    keyboardType: TextInputType.datetime,
                    validator: viewModel.birthDateValidator,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      DataInputFormatter()
                    ],
                    style: GalaxyFoodTheme.text.bodyLarge,
                    placeholder: "Data de Nascimento",
                    onTapOutside: (_) => ownerBirthDateFocus.unfocus(),
                  ),
                ),
              ],

            Padding(
              padding: const EdgeInsets.only(top: 75, bottom: 10),
              child: SizedBox(
                height: 60,
                width: double.maxFinite,
                child: GalaxyButton(
                  onPressed: () async => await viewModel.submit(context),
                  child: const Text("SALVAR"),
                ),
              ),
            ),

            Center(
              child: Text(
                '---  ou  ---',
                style: GalaxyFoodTheme.text.bodySmall,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 50),
              child: SizedBox(
                height: 60,
                width: double.maxFinite,
                child: GalaxyButton(
                  onPressed: () => viewModel.signin(context),
                  child: const Text("ENTRAR"),
                ),
              ),
            ),

          ],
        ),
      ),
    ];
  }

  _buildCheckOwner(){
    return [
      Form(
        key: viewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 5),
              child: Center(
                child: Text(
                  "CADASTRE-SE",
                  style: GalaxyFoodTheme.text.titleLarge,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 5),
              child: Text("DIGITE O CPF DO DONO:",  style: GalaxyFoodTheme.text.bodyLarge,),
            ),

            SizedBox(
              height: 45,
              child: TextFormBox(
                cursorColor: Colors.white,
                highlightColor: GalaxyFoodTheme.normal.activeColor,
                focusNode: ownerCpfFocus,
                controller: viewModel.ownerCpfEditingController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                validator: viewModel.textValidator,
                style: GalaxyFoodTheme.text.bodyLarge,
                placeholder: "CPF",
                onTapOutside: (_) => ownerCpfFocus.unfocus(),
              ),
            ),



            Padding(
              padding: const EdgeInsets.only(top: 75, bottom: 10),
              child: SizedBox(
                height: 60,
                width: double.maxFinite,
                child: GalaxyButton(
                  onPressed: () async => await viewModel.checkOwner(context),
                  child: const Text("CONTINUAR"),
                ),
              ),
            ),

            Center(
              child: Text(
                '---  ou  ---',
                style: GalaxyFoodTheme.text.bodySmall,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 50),
              child: SizedBox(
                height: 60,
                width: double.maxFinite,
                child: GalaxyButton(
                  onPressed: () => viewModel.signin(context),
                  child: const Text("VOLTAR"),
                ),
              ),
            ),

          ],
        ),
      ),
    ];
  }

}


