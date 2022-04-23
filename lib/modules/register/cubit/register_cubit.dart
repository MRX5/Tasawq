import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register/cubit/register_states.dart';
import 'package:shop_app/shared/remote/dio_helper.dart';
import 'package:shop_app/shared/remote/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit():super(RegisterInitialState());

  static RegisterCubit get(BuildContext context)=>BlocProvider.of(context);

  bool isPassword=true;
  IconData suffixIcon=Icons.visibility_outlined;

  changePasswordVisibility(){
    isPassword=!isPassword;
    suffixIcon=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }
  
  void userRegister({
  required String email,
    required String username,
    required String password,
    required String phone
  }){

    emit(RegisterUserLoadingState());
    DioHelper.postData(url: REGISTER,
        data: {
          'email':email,
          'name':username,
          'password':password,
          'phone':phone
        }
    ).then((value){
        print(value.data);
        var model=LoginModel.fromJson(value.data);
        emit(RegisterUserSuccessState(model.data));
    }).catchError((error){
        emit(RegisterUserErrorState(error.toString()));
    });
  }
}