import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/remote/dio_helper.dart';
import 'package:shop_app/shared/remote/end_points.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInitialState());

  static LoginCubit get(BuildContext context)=>BlocProvider.of(context);


  bool isPassword=true;
  IconData suffixIcon=Icons.visibility_outlined;

  changePasswordVisibility(){
    isPassword=!isPassword;
    suffixIcon=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }
  
  void userLogin({
  required String email,
    required String password
}){
    emit(LoginUserLoadingState());
    DioHelper.postData(
        url: LOGIN_END_POINT,
        data:{
          'email':email,
          'password':password
        }).then((value){
          print(value);
          var loginModel=LoginModel.fromJson(value.data);
          emit(LoginUserSuccessState(loginModel));
    }).catchError((error){
      emit(LoginUserErrorState(error.toString()));
    });
  }

}