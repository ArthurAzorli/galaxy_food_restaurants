import 'package:brasil_fields/brasil_fields.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food_restaurants/core/service/repository/restaurant_owner_repository_service.dart';
import 'package:galaxy_food_restaurants/feature/configuration_page/edit_restaurant_view.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:on_popup_window_widget/on_popup_window_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/domain/phone.dart';
import '../../core/domain/restaurant.dart';
import '../../core/service/repository/restaurant_repository_service.dart';
import '../../core/utils/exception/repository_exception.dart';
import '../../core/widgets/galaxy_button.dart';
import '../../galaxy_theme.dart';

part 'configuration_viewmodel.g.dart';

class ConfigurationViewModel = ConfigurationViewModelBase with _$ConfigurationViewModel;

abstract class ConfigurationViewModelBase with Store{

  @observable
  Restaurant? restaurant;

  ConfigurationViewModelBase(BuildContext context){
    _getRestaurant(context);
  }

  void _getRestaurant(BuildContext context) async{
    try {
      restaurant = await RestaurantRepositoryService.getUser();
    } on RepositoryException catch(e) {
      e.showMessageDialog(context, (){
        Navigator.of(context).pop();
        context.go("/signin");
      });
    }
  }

  String? _textValidator(String? text){
    if (text == null || text.isEmpty) return "Campo vazio!";
    return null;
  }

  String? _passwordValidator(String? text){
    if (text == null || text.isEmpty) return "Campo vazio!";
    if (text.length < 8) return "A senha deve ter ao menos 8 caracteres";
    return null;
  }

  @observable
  bool seeOldPassword = false;

  @observable
  bool seeNewPassword = false;

  @observable
  bool seePassword = false;

  @action
  addNewPhone(BuildContext context){

    final phoneFocus = FocusNode();
    final formKey = GlobalKey<FormState>();
    final phoneEditingController = TextEditingController();

    showDialog(
        context: context,
        builder: (context)
        {
          return OnPopupWindowWidget(
            backgroundColor: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
            divider: Container(),
            centerTitle: true,
            title: Text("ADICIONAR TELEFONE", style: GalaxyFoodTheme.text.titleLarge,),
            child: Form(
              key: formKey,
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 5),
                    child: Observer(
                        builder: (context) {
                          return SizedBox(
                            height: 45,
                            child: TextFormBox(
                              cursorColor: Colors.white,
                              highlightColor: GalaxyFoodTheme.normal.activeColor,
                              focusNode: phoneFocus,
                              controller: phoneEditingController,
                              validator: _textValidator,
                              style: GalaxyFoodTheme.text.bodyLarge,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TelefoneInputFormatter()
                              ],
                              placeholder: "Número de Telefone",
                              onTapOutside: (_) => phoneFocus.unfocus(),
                            ),
                          );
                        }
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20),
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
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()){
                                      try{
                                        final phone = Phone(phone: phoneEditingController.text);
                                        phoneEditingController.text = "";

                                        restaurant = await RestaurantRepositoryService.addPhone(phone);
                                        Navigator.pop(context);

                                      } on RepositoryException catch(e){
                                        e.showMessageDialog(context, () => Navigator.pop(context));
                                      }
                                    }
                                  },
                                  child: const Text("ADICIONAR")
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
            ),
          );
        }
    );

  }

  @action
  removePhone(BuildContext context, Phone phone) async{
    try{
      restaurant = await RestaurantRepositoryService.remPhone(phone.id!);
      _successMessage(
        context: context,
        title: "Sucesso!",
        content: "Telefone ${phone.phone} removido com sucesso!"
      );
    } on RepositoryException catch(e){
      e.showMessageDialog(context, ()=>Navigator.pop(context));
    }
  }

  @action
  changePassword(BuildContext context){
    final newPasswordFocus = FocusNode();
    final oldPasswordFocus = FocusNode();
    final formKey = GlobalKey<FormState>();
    final newPasswordEditingController = TextEditingController();
    final oldPasswordEditingController = TextEditingController();

    showDialog(
        context: context,
        builder: (context)
        {
          return OnPopupWindowWidget(
            backgroundColor: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
            divider: Container(),
            centerTitle: true,
            title: Text("ALTERAR SENHA", style: GalaxyFoodTheme.text.titleLarge,),
            child: Form(
              key: formKey,
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 5),
                    child: Observer(
                      builder: (context) {
                        return SizedBox(
                          height: 45,
                          child: TextFormBox(
                            cursorColor: Colors.white,
                            highlightColor: GalaxyFoodTheme.normal.activeColor,
                            focusNode: oldPasswordFocus,
                            controller: oldPasswordEditingController,
                            obscureText: !seeOldPassword,
                            validator: _passwordValidator,
                            style: GalaxyFoodTheme.text.bodyLarge,
                            placeholder: "Senha Atual",
                            suffix: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: GestureDetector(
                                  onTap: () => seeOldPassword = !seeOldPassword,
                                  child: Icon(seeOldPassword
                                      ? material.Icons.visibility_off_outlined
                                      : material.Icons.visibility_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  )
                              ),
                            ),
                            onTapOutside: (_) => oldPasswordFocus.unfocus(),
                          ),
                        );
                      }
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
                              focusNode: newPasswordFocus,
                              controller: newPasswordEditingController,
                              obscureText: !seeNewPassword,
                              validator: _passwordValidator,
                              style: GalaxyFoodTheme.text.bodyLarge,
                              placeholder: "Senha Nova",
                              suffix: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: GestureDetector(
                                    onTap: () => seeNewPassword = !seeNewPassword,
                                    child: Icon(seeNewPassword
                                        ? material.Icons.visibility_off_outlined
                                        : material.Icons.visibility_outlined,
                                      color: Colors.white,
                                      size: 25,
                                    )
                                ),
                              ),
                              onTapOutside: (_) => oldPasswordFocus.unfocus(),
                            ),
                          );
                        }
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20),
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
                                onPressed: () async {
                                  if (formKey.currentState!.validate()){
                                    try{
                                      final oldPassword = oldPasswordEditingController.text;
                                      final newPassword = newPasswordEditingController.text;
                                      oldPasswordEditingController.text = "";
                                      newPasswordEditingController.text = "";

                                      final result = await RestaurantRepositoryService.changePassword(
                                        newPassword: newPassword,
                                        oldPassword: oldPassword
                                      );

                                      if(result) {
                                        _successMessage(
                                          context: context,
                                          title: "Sucesso!",
                                          content: "Senha alterada com sucesso!",
                                          onClose: () => Navigator.pop(context)
                                        );
                                      }

                                    } on RepositoryException catch(e){
                                      e.showMessageDialog(context, () => Navigator.pop(context));
                                    }
                                  }
                                },
                                child: const Text("ALTERAR")
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
            ),
          );
        }
    );

  }

  @action
  editRestaurant(BuildContext context){
    showDialog(
        context: context,
        builder: (context)
        {
          return OnPopupWindowWidget(
            backgroundColor: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
            divider: Container(),
            centerTitle: true,
            title: Text("EDITAR RESTAURANTE", style: GalaxyFoodTheme.text.titleLarge,),
            child: EditRestaurantView(restaurant: restaurant!, onSave: (restaurant) => onSaveRestaurant(context, restaurant)),
          );
        }
    );
  }
  
  @action
  onSaveRestaurant(BuildContext context, Restaurant restaurant){
    this.restaurant = restaurant;
    _successMessage(context: context, title: "Sucesso!", content: "O Restaurante foi editado com Sucesso!");
  }  

  @action
  editRestaurantOwner(BuildContext context){

    final nameFocus = FocusNode();
    final formKey = GlobalKey<FormState>();
    final nameEditingController = TextEditingController()..text = restaurant!.owner.name;

    showDialog(
        context: context,
        builder: (context)
        {
          return OnPopupWindowWidget(
            backgroundColor: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
            divider: Container(),
            centerTitle: true,
            title: Text("EDITAR DONO DO RESTAURANTE", style: GalaxyFoodTheme.text.titleLarge,),
            child: Form(
              key: formKey,
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 5),
                    child: Observer(
                        builder: (context) {
                          return SizedBox(
                            height: 45,
                            child: TextFormBox(
                              cursorColor: Colors.white,
                              highlightColor: GalaxyFoodTheme.normal.activeColor,
                              focusNode: nameFocus,
                              controller: nameEditingController,
                              validator: _textValidator,
                              style: GalaxyFoodTheme.text.bodyLarge,
                              placeholder: "Nome do Restaurante",
                              onTapOutside: (_) => nameFocus.unfocus(),
                            ),
                          );
                        }
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20),
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
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()){
                                      try{
                                        final name = nameEditingController.text;
                                        nameEditingController.text = "";

                                        restaurant!.owner = await RestaurantOwnerRepositoryService.update(
                                          restaurant!,
                                          restaurant!.owner..name = name
                                        );

                                        _successMessage(
                                          context: context,
                                          title: "Sucesso!",
                                          content: "Dono editado com Sucesso!",
                                          onClose: () => Navigator.pop(context)
                                        );

                                      } on RepositoryException catch(e){
                                        e.showMessageDialog(context, () => Navigator.pop(context));
                                      }
                                    }
                                  },
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
            ),
          );
        }
    );

  }

  @action
  logout(BuildContext context){
    GetIt.I.get<SharedPreferencesWithCache>().clear();
    context.go("/signin");
  }

  @action
  deleteRestaurant(BuildContext context){
    final emailFocus = FocusNode();
    final passwordFocus = FocusNode();
    final formKey = GlobalKey<FormState>();
    final emailEditingController = TextEditingController();
    final passwordEditingController = TextEditingController();

    showDialog(
        context: context,
        builder: (context)
        {
          return OnPopupWindowWidget(
            backgroundColor: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
            divider: Container(),
            centerTitle: true,
            title: Text("CONFIRME A AÇÃO", style: GalaxyFoodTheme.text.titleLarge,),
            child: Form(
              key: formKey,
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 5),
                    child: Observer(
                        builder: (context) {
                          return SizedBox(
                            height: 45,
                            child: TextFormBox(
                              cursorColor: Colors.white,
                              highlightColor: GalaxyFoodTheme.normal.activeColor,
                              focusNode: emailFocus,
                              controller: emailEditingController,
                              keyboardType: TextInputType.emailAddress,
                              validator: _textValidator,
                              style: GalaxyFoodTheme.text.bodyLarge,
                              placeholder: "E-mail",
                              onTapOutside: (_) => emailFocus.unfocus(),
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
                              focusNode: passwordFocus,
                              controller: passwordEditingController,
                              obscureText: !seePassword,
                              validator: _passwordValidator,
                              style: GalaxyFoodTheme.text.bodyLarge,
                              placeholder: "Senha",
                              suffix: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: GestureDetector(
                                    onTap: () => seePassword = !seePassword,
                                    child: Icon(seePassword
                                        ? material.Icons.visibility_off_outlined
                                        : material.Icons.visibility_outlined,
                                      color: Colors.white,
                                      size: 25,
                                    )
                                ),
                              ),
                              onTapOutside: (_) => passwordFocus.unfocus(),
                            ),
                          );
                        }
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20),
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
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()){
                                      try{
                                        final email = emailEditingController.text;
                                        final password = passwordEditingController.text;
                                        emailEditingController.text = "";
                                        passwordEditingController.text = "";

                                        final result = await RestaurantRepositoryService.delete(user: email, password: password);

                                        if(result) {
                                          _successMessage(
                                              context: context,
                                              title: "Sucesso!",
                                              content: "Restaurante deletado com Sucesso!",
                                              onClose: () {
                                                Navigator.pop(context);
                                                logout(context);
                                              }
                                          );
                                        }

                                      } on RepositoryException catch(e){
                                        e.showMessageDialog(context, () => Navigator.pop(context));
                                      }
                                    }
                                  },
                                  child: const Text("DELETAR")
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
            ),
          );
        }
    );
  }

  @action
  deleteOwner(BuildContext context){
    final emailFocus = FocusNode();
    final passwordFocus = FocusNode();
    final formKey = GlobalKey<FormState>();
    final emailEditingController = TextEditingController();
    final passwordEditingController = TextEditingController();

    showDialog(
        context: context,
        builder: (context)
        {
          return OnPopupWindowWidget(
            backgroundColor: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
            divider: Container(),
            centerTitle: true,
            title: Text("CONFIRME A AÇÃO", style: GalaxyFoodTheme.text.titleLarge,),
            child: Form(
              key: formKey,
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 5),
                    child: Observer(
                        builder: (context) {
                          return SizedBox(
                            height: 45,
                            child: TextFormBox(
                              cursorColor: Colors.white,
                              highlightColor: GalaxyFoodTheme.normal.activeColor,
                              focusNode: emailFocus,
                              controller: emailEditingController,
                              keyboardType: TextInputType.emailAddress,
                              validator: _textValidator,
                              style: GalaxyFoodTheme.text.bodyLarge,
                              placeholder: "E-mail",
                              onTapOutside: (_) => emailFocus.unfocus(),
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
                              focusNode: passwordFocus,
                              controller: passwordEditingController,
                              obscureText: !seePassword,
                              validator: _passwordValidator,
                              style: GalaxyFoodTheme.text.bodyLarge,
                              placeholder: "Senha",
                              suffix: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: GestureDetector(
                                    onTap: () => seePassword = !seePassword,
                                    child: Icon(seePassword
                                        ? material.Icons.visibility_off_outlined
                                        : material.Icons.visibility_outlined,
                                      color: Colors.white,
                                      size: 25,
                                    )
                                ),
                              ),
                              onTapOutside: (_) => passwordFocus.unfocus(),
                            ),
                          );
                        }
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20),
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
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()){
                                      try{
                                        final email = emailEditingController.text;
                                        final password = passwordEditingController.text;
                                        emailEditingController.text = "";
                                        passwordEditingController.text = "";

                                        final result = await RestaurantOwnerRepositoryService.delete(user: email, password: password);

                                        if(result) {
                                          _successMessage(
                                              context: context,
                                              title: "Sucesso!",
                                              content: "Dono de Restaurante deletado com Sucesso!",
                                              onClose: () {
                                                Navigator.pop(context);
                                                logout(context);
                                              }
                                          );
                                        }

                                      } on RepositoryException catch(e){
                                        e.showMessageDialog(context, () => Navigator.pop(context));
                                      }
                                    }
                                  },
                                  child: const Text("DELETAR")
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
            ),
          );
        }
    );
  }

  _successMessage({required BuildContext context, required String title, required String content, Function()? onClose}){
    showDialog(
        context: context,
        builder: (context)
        {
          return OnPopupWindowWidget(
            backgroundColor: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
            divider: Container(),
            centerTitle: true,
            title: Text(title, style: GalaxyFoodTheme.text.titleLarge,),
            child: Column(
              children: [

                Padding(
                    padding: const EdgeInsets.only(),
                    child: Text(content, style: GalaxyFoodTheme.text.bodyLarge,)
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        height: 50,
                        width: 180,
                        child: GalaxyButton(
                            onPressed: () {
                              Navigator.pop(context);
                              if (onClose != null) onClose();
                            },
                            child: const Text("FECHAR")
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
    );
  }

}

