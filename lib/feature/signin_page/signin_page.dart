import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food_restaurants/feature/signin_page/signin_viewmodel.dart';
import 'package:galaxy_food_restaurants/galaxy_theme.dart';

import '../../core/widgets/galaxy_button.dart';

class SignInPage extends StatefulWidget{
  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignInPageState();
  
}

class _SignInPageState extends State{

  final viewModel = SignInViewModel();

  @override
  Widget build(BuildContext context) {

    return ScaffoldPage(
      content: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 600,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Image.asset(
                    "lib/images/galaxyfood_logo.png",
                    height: 125,
                    color: Colors.white,
                  ),
                ),


                Form(
                  key: viewModel.formKey,
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 5),
                        child: Text(
                          "FAÇA SEU LOG IN",
                          style: GalaxyFoodTheme.text.titleLarge,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 5),
                        child: Observer(
                            builder: (context) {
                              return SizedBox(
                                height: 45,
                                child: TextFormBox(
                                  cursorColor: Colors.white,
                                  highlightColor: GalaxyFoodTheme.normal.activeColor,
                                  focusNode: viewModel.emailFocus,
                                  controller: viewModel.emailEditingController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: viewModel.emailValidator,
                                  style: GalaxyFoodTheme.text.bodyLarge,
                                  placeholder: "E-mail",
                                  onTapOutside: (_) => viewModel.emailFocus.unfocus(),
                                ),
                              );
                            }
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Observer(
                            builder: (context) {
                              return SizedBox(
                                height: 45,
                                child: TextFormBox(
                                  cursorColor: Colors.white,
                                  highlightColor: GalaxyFoodTheme.normal.activeColor,
                                  focusNode: viewModel.passwordFocus,
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
                                  onTapOutside: (_) => viewModel.passwordFocus.unfocus(),
                                ),
                              );
                            }
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 75, bottom: 10),
                        child: SizedBox(
                          height: 60,
                          width: double.maxFinite,
                          child: GalaxyButton(
                            onPressed: () async => await viewModel.submit(context),
                            child: const Text("ENTRE"),
                          ),
                        ),
                      ),

                      Text(
                        '---  ou  ---',
                        style: GalaxyFoodTheme.text.bodySmall,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          height: 60,
                          width: double.maxFinite,
                          child: GalaxyButton(
                            onPressed: () => viewModel.signup(context),
                            child: const Text("CADASTRE-SE"),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
  
}