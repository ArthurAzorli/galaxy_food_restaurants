import 'package:fluent_ui/fluent_ui.dart';
import 'package:galaxy_food_restaurants/core/service/repository/restaurant_repository_service.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import '../../core/utils/exception/repository_exception.dart';

part 'signin_viewmodel.g.dart';

class SignInViewModel = SignInViewModelBase with _$SignInViewModel;

abstract class SignInViewModelBase with Store{

  final formKey = GlobalKey<FormState>();

  @observable
  var seePassword = false;

  @observable
  var emailFocus = FocusNode();

  @observable
  var emailEditingController = TextEditingController()..text="siri.cascudo@gmail.com";

  @observable
  var passwordFocus = FocusNode();

  @observable
  var passwordEditingController = TextEditingController()..text="12345678";

  @action
  void changeVisibilityPassword(){
    seePassword = !seePassword;
  }

  @action
  String? emailValidator(String? email){
    if (email == null || email.isEmpty) return 'Campo do E-mail vazio!';
    return null;
  }

  @action
  String? passwordValidator(String? password){
    if (password == null || password.isEmpty) return 'Campo da Senha vazio!';
    if (password.length < 8) return 'A senha deve ter, ao menos, 8 digitos!';
    return null;
  }

  @action
  Future<void> submit(BuildContext context) async{
    if (formKey.currentState!.validate()) {

      final email = emailEditingController.text;
      final password = passwordEditingController.text;

      try{
        await RestaurantRepositoryService.login(user: email, password: password);
        context.go("/");

      } on RepositoryException catch(e) {

        e.showMessageDialog(context, ()=>Navigator.of(context).pop(), title: "ao fazer o LOG IN");

      }
    }
  }

  @action
  void signup(BuildContext context){
    context.go("/signup");
  }
}