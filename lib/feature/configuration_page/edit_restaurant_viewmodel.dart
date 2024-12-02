import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:galaxy_food_restaurants/core/utils/bytes.dart';
import 'package:mobx/mobx.dart';

import '../../core/domain/restaurant.dart';
import '../../core/service/repository/restaurant_repository_service.dart';
import '../../core/utils/exception/repository_exception.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

part 'edit_restaurant_viewmodel.g.dart';

class EditRestaurantViewModel = EditRestaurantViewModelBase with _$EditRestaurantViewModel;

abstract class EditRestaurantViewModelBase with Store{

  final formKey = GlobalKey<FormState>();

  final _picker = ImagePickerPlatform.instance;

  @observable
  Restaurant restaurant;

  @observable
  var emailEditingController = TextEditingController();

  @observable
  var nameEditingController = TextEditingController();

  @observable
  var specialtyEditingController = TextEditingController();

  @observable
  var streetEditingController = TextEditingController();

  @observable
  var numberEditingController = TextEditingController();

  @observable
  var neighborhoodEditingController = TextEditingController();

  @observable
  var cityEditingController = TextEditingController();

  @observable
  var cepEditingController = TextEditingController();

  @observable
  String? state;

  @observable
  Uint8List? image;

  EditRestaurantViewModelBase(this.restaurant){
    emailEditingController.text = restaurant.email;
    nameEditingController.text = restaurant.name;
    specialtyEditingController.text = restaurant.specialty??"";
    cepEditingController.text = restaurant.address.cep;
    streetEditingController.text = restaurant.address.street;
    numberEditingController.text = restaurant.address.number;
    neighborhoodEditingController.text = restaurant.address.neighborhood;
    cityEditingController.text = restaurant.address.city;
    state = restaurant.address.state;
    image = restaurant.image?.toUint8List;
  }

  String? textValidator(String? text){
    if (text == null || text.isEmpty) return "Campo vazio!";
    return null;
  }

  String? passwordValidator(String? text){
    if (text == null || text.isEmpty) return "Campo vazio!";
    if (text.length < 8) return "A senha deve ter ao menos 8 caracteres";
    return null;
  }

  @observable
  bool seePassword = false;

  @action
  selectImage() async {
    final result = await _picker.getMedia(
        options: const MediaOptions(
          allowMultiple: false,
        )
    );
    if (result.isEmpty) return;
    image = await result.first.readAsBytes();
  }

  @action
  onChangeState(String? selectState){
    if (selectState != null){
      state = selectState;
    }
  }

  @action
  onSubmit(BuildContext context, Function(Restaurant) onSave) async{
    if (formKey.currentState!.validate()){
      try{
        final email = emailEditingController.text;
        final name = nameEditingController.text;
        final specialty = specialtyEditingController.text;
        final cep = cepEditingController.text;
        final street = streetEditingController.text;
        final number = numberEditingController.text;
        final neighborhood = neighborhoodEditingController.text;
        final city = cityEditingController.text;

        emailEditingController.text = "";
        nameEditingController.text = "";
        specialtyEditingController.text = "";
        cepEditingController.text = "";
        streetEditingController.text = "";
        numberEditingController.text = "";
        neighborhoodEditingController.text = "";
        cityEditingController.text = "";

        restaurant.email = email;
        restaurant.name = name;
        restaurant.specialty = specialty;
        restaurant.image = image;
        restaurant.address.cep = cep;
        restaurant.address.street = street;
        restaurant.address.number = number;
        restaurant.address.neighborhood = neighborhood;
        restaurant.address.city = city;
        restaurant.address.state = state!;

        restaurant = await RestaurantRepositoryService.update(restaurant);
        onSave(restaurant);

      } on RepositoryException catch(e){
        e.showMessageDialog(context, () => Navigator.pop(context));
      }
    }
  }

}

