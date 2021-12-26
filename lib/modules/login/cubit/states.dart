import 'package:shop_app/models/login_model.dart';

abstract class ShopLoginStates{}

class LoginInitialState extends ShopLoginStates{}

class LoginLoadingState extends ShopLoginStates{}

class LoginSuccessState extends ShopLoginStates{
  final ShopLoginModel loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends ShopLoginStates{
  final eror;
  LoginErrorState(this.eror);
}
class LoginChangePasswordVisibilityState extends ShopLoginStates{}