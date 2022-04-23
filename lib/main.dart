import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/local/cache_helper.dart';
import 'package:shop_app/shared/remote/dio_helper.dart';

import 'app.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(() async {
    DioHelper.inti();
    await CacheHelper.init();
    bool isDark = CacheHelper.getThemeMode();
    bool? onBoarding=CacheHelper.getData(key: IS_FIRST_TIME);
    token=CacheHelper.getData(key: TOKEN);
    print(token);
    Widget startWidget;

    if(onBoarding!=null){
      if(token!=null){
        startWidget=ShopLayout();
      }else {
        startWidget = LoginScreen();
      }
    }else{
      startWidget= OnBoardingScreen();
    }

    runApp( MyApp(isDark,startWidget));
  }, blocObserver: MyBlocObserver());
}

