import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

}