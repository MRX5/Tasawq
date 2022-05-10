import 'package:shop_app/models/login_model.dart';

abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class GetProfileLoadingState extends ProfileStates {}

class GetProfileSuccessState extends ProfileStates {
  final LoginModel loginModel;

  GetProfileSuccessState(this.loginModel);
}

class GetProfileErrorState extends ProfileStates {
  final String error;

  GetProfileErrorState(this.error);
}

//Edit profile states
class EditProfileLoadingState extends ProfileStates {}

class EditProfileSuccessState extends ProfileStates {
  final LoginModel loginModel;

  EditProfileSuccessState(this.loginModel);
}

class EditProfileErrorState extends ProfileStates {
  final String error;

  EditProfileErrorState(this.error);
}

// Log out states

class UserLogoutSuccessState extends ProfileStates {
  final String message;

  UserLogoutSuccessState(this.message);
}

class UserLogoutErrorState extends ProfileStates {
  final String error;

  UserLogoutErrorState(this.error);
}
