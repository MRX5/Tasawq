import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../local/cache_helper.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(BuildContext context)=>BlocProvider.of(context);

  bool isDarkMode=false;

  void changeThemeMode({bool? fromSharedPref}){
    if(fromSharedPref!=null){
      isDarkMode=fromSharedPref;
      emit(AppThemeChangedState());
    }
    else {
      isDarkMode = !isDarkMode;
      CacheHelper.setThemeMode(isDark: isDarkMode)
          .then((value) {
        emit(AppThemeChangedState());
      });
    }
  }

}