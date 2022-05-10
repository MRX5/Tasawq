import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/logout_model.dart';
import 'package:shop_app/modules/profile/cubit/profile_states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/remote/dio_helper.dart';
import 'package:shop_app/shared/remote/end_points.dart';

import '../../../models/login_model.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void getUserProfile() {
    emit(GetProfileLoadingState());
    DioHelper.getData(url: PROFILE_END_POINT, token: token).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(GetProfileSuccessState(loginModel!));
    }).catchError((error) {
      emit(GetProfileErrorState('Check internet connection'));
    });
  }

  void updateUserProfile({
      required String username,
      required String email,
      required String phone}) {
    emit(EditProfileLoadingState());
    DioHelper.putData(
        url: UPDATE_PROFILE_END_POINT,
        token: token,
        data: {
          'name': username,
          'email': email,
          'phone': phone,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(EditProfileSuccessState(loginModel!));
    }).catchError((error) {
      emit(EditProfileErrorState(error.toString()));
    });
  }

  void logout() {
    DioHelper.postData(url: LOGOUT_END_POINT, data: {}, token: token)
        .then((value) {
      var logoutModel = LogoutModel.fromJson(value.data);
      if (logoutModel.status == false) {
        emit(UserLogoutErrorState('${logoutModel.message}'));
      } else {
        emit(UserLogoutSuccessState('${logoutModel.message}'));
      }
    }).catchError((error) {
      emit(UserLogoutErrorState('Check internet connection'));
    });
  }
}
