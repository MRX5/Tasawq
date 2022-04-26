import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/profile/cubit/profile_states.dart';
import 'package:shop_app/shared/remote/dio_helper.dart';
import 'package:shop_app/shared/remote/end_points.dart';

import '../../../models/login_model.dart';

class ProfileCubit extends Cubit<ProfileStates>{
  ProfileCubit():super(ProfileInitialState());

  static ProfileCubit get(context)=>BlocProvider.of(context);

  LoginModel? loginModel;
  getUserProfile(){
    emit(GetProfileLoadingState());
    DioHelper.getData(url: PROFILE_END_POINT)
    .then((value){
        loginModel=LoginModel.fromJson(value.data);
        emit(GetProfileSuccessState(loginModel!));
    }).catchError((error){
      emit(GetProfileErrorState('Check internet connection'));
    });
  }
}