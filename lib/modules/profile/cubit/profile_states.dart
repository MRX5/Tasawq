import 'package:shop_app/models/login_model.dart';

abstract class ProfileStates{}
class ProfileInitialState extends ProfileStates{}

class GetProfileLoadingState extends ProfileStates{}
class GetProfileSuccessState extends ProfileStates{
  final LoginModel loginModel;
  GetProfileSuccessState(this.loginModel);
}
class GetProfileErrorState extends ProfileStates{
  final String error;
  GetProfileErrorState(this.error);
}