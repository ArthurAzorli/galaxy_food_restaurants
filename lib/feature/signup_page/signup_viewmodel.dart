import 'package:brasil_fields/brasil_fields.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:galaxy_food_restaurants/core/domain/address.dart';
import 'package:galaxy_food_restaurants/core/domain/package.dart';
import 'package:galaxy_food_restaurants/core/domain/restaurant.dart';
import 'package:galaxy_food_restaurants/core/domain/restaurant_owner.dart';
import 'package:galaxy_food_restaurants/core/service/repository/package_repository_service.dart';
import 'package:galaxy_food_restaurants/core/service/repository/restaurant_owner_repository_service.dart';
import 'package:galaxy_food_restaurants/core/service/repository/restaurant_repository_service.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:on_popup_window_widget/on_popup_window_widget.dart';

import '../../core/utils/exception/repository_exception.dart';
import '../../core/widgets/galaxy_button.dart';
import '../../galaxy_theme.dart';

part 'signup_viewmodel.g.dart';

class SignUpViewModel = SignUpViewModelBase with _$SignUpViewModel;

abstract class SignUpViewModelBase with Store{

  final formKey = GlobalKey<FormState>();

  @observable
  bool? existsOwner;

  @observable
  String? idOwner;

  @observable
  var seePassword = false;

  @observable
  String? state;

  @observable
  var ownerCpfEditingController = TextEditingController();

  @observable
  var ownerRgEditingController = TextEditingController();

  @observable
  var ownerNameEditingController = TextEditingController();

  @observable
  var ownerBirthDateEditingController = TextEditingController();

  @observable
  var cnpjEditingController = TextEditingController();

  @observable
  var emailEditingController = TextEditingController();

  @observable
  var nameEditingController = TextEditingController();

  @observable
  var specialtyEditingController = TextEditingController();

  @observable
  var passwordEditingController = TextEditingController();

  @observable
  var cepEditingController = TextEditingController();

  @observable
  var streetEditingController = TextEditingController();

  @observable
  var numberEditingController = TextEditingController();

  @observable
  var neighborhoodEditingController = TextEditingController();

  @observable
  var cityEditingController = TextEditingController();

  @action
  void changeVisibilityPassword(){
    seePassword = !seePassword;
  }

  @action
  checkOwner(BuildContext context) async{
    try{
      final cpf = ownerCpfEditingController.text;
      var result = await RestaurantOwnerRepositoryService.exists(cpf);
      existsOwner = result['result'];
      if (existsOwner!) idOwner = result['id'];
    } on RepositoryException catch(e) {
      e.showMessageDialog(context, ()=>Navigator.of(context).pop());
    }
  }

  @action
  String? textValidator(String? text){
    if (text == null || text.isEmpty) return 'Campo vazio!';
    return null;
  }

  @action
  String? passwordValidator(String? password){
    if (password == null || password.isEmpty) return 'Campo vazio!';
    if (password.length < 8) return 'A senha deve ter, ao menos, 8 digitos!';
    return null;
  }

  @action
  String? birthDateValidator(String? date){
    if (date == null || date.isEmpty) return 'Campo vazio!';
    var dateTime = UtilData.obterDateTime(date);
    if (!UtilData.validarData(date) ||
        dateTime.isAfter(DateTime.now()) ||
        dateTime.isBefore(DateTime(1900))
    ) return 'Data inválida!';
    return null;
  }

  @action
  onChangeState(String? selectState){
    if (selectState != null){
      state = selectState;
    }
  }

  @action
  Future<void> submit(BuildContext context) async{
    if (formKey.currentState!.validate() && state != null) {

      final cnpj = cnpjEditingController.text;
      final email = emailEditingController.text;
      final name = nameEditingController.text;
      final specialty = specialtyEditingController.text;
      final password = passwordEditingController.text;

      final cep = cepEditingController.text;
      final street = streetEditingController.text;
      final number = numberEditingController.text;
      final neighborhood = neighborhoodEditingController.text;
      final city = cityEditingController.text;

      try{
        RestaurantOwner owner;

        if (!existsOwner!){

          String ownerCpf = ownerCpfEditingController.text;
          String ownerRg = ownerRgEditingController.text;
          String ownerName = ownerNameEditingController.text;
          DateTime ownerBirthDate = UtilData.obterDateTime(ownerBirthDateEditingController.text);

          owner = RestaurantOwner(rg: ownerRg, cpf: ownerCpf, birthDate: ownerBirthDate, name: ownerName);
          owner = await RestaurantOwnerRepositoryService.create(owner);

        } else {
          owner = await RestaurantOwnerRepositoryService.get(idOwner!);
        }

        var restaurant = Restaurant(
          id: null,
          cnpj: cnpj,
          email: email,
          name: name,
          specialty: specialty,
          address: Address(
              street: street,
              number: number,
              neighborhood: neighborhood,
              city: city,
              state: state!,
              cep: cep
          ),
          phones: [],
          owner: owner
        )..password = password;

        restaurant = await RestaurantRepositoryService.create(restaurant);
        await PackageRepositoryService.create(
            Package(name: "cardápio", parent: null, restaurant: restaurant.id!)
        );

        showDialog(
            context: context,
            builder: (context)
            {
              return OnPopupWindowWidget(
                backgroundColor: GalaxyFoodTheme.normal.scaffoldBackgroundColor,
                divider: Container(),
                centerTitle: true,
                title: Text("Sucesso!", style: GalaxyFoodTheme.text.titleLarge,),
                child: Column(
                  children: [

                    Padding(
                        padding: const EdgeInsets.only(),
                        child: Text("Restaurante cadastrado com Sucesso!", style: GalaxyFoodTheme.text.bodyLarge,)
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
                                  context.go("/");
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

      } on RepositoryException catch(e) {

        e.showMessageDialog(context, ()=>Navigator.of(context).pop(), title: "ao fazer ao Cadastrar");

      }
    }
  }

  @action
  void signin(BuildContext context){
    context.go("/signin");
  }
}