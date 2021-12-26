import 'package:shop_app/models/login_model.dart';

abstract class ShopRegisterStates{}

class RegisterInitialState extends ShopRegisterStates{}

class RegisterLoadingState extends ShopRegisterStates{}

class RegisterSuccessState extends ShopRegisterStates{
  final ShopLoginModel loginModel;
  RegisterSuccessState(this.loginModel);
}

class RegisterErrorState extends ShopRegisterStates{
  final eror;
  RegisterErrorState(this.eror);
}
class RegisterChangePasswordVisibilityState extends ShopRegisterStates{}