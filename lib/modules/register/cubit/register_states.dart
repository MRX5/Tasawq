import 'package:shop_app/models/login_model.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}
class RegisterChangePasswordVisibilityState extends RegisterStates{}
class RegisterUserLoadingState extends RegisterStates{}
class RegisterUserSuccessState extends RegisterStates{
  final LoginModel loginModel;
  RegisterUserSuccessState(this.loginModel);
}
class RegisterUserErrorState extends RegisterStates{
  final String error;
  RegisterUserErrorState(this.error);
}