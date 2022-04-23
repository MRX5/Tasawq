import '../../../models/login_model.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}
class LoginChangePasswordVisibilityState extends LoginStates{}
class LoginUserLoadingState extends LoginStates{}
class LoginUserSuccessState extends LoginStates{
  final LoginModel loginModel;
  LoginUserSuccessState(this.loginModel);
}
class LoginUserErrorState extends LoginStates{
  final String error;
  LoginUserErrorState(this.error);
}