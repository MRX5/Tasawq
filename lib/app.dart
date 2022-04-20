import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/register/cubit/register_cubit.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';
import 'package:shop_app/shared/styles/styles.dart';

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  const MyApp(this.isDark,this.startWidget,{Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create:(BuildContext context)=>AppCubit()..changeThemeMode(fromSharedPref: isDark)
          ),
          BlocProvider(
              create: (context)=>LoginCubit()
          ),
          BlocProvider(
              create: (context)=>RegisterCubit()
          ),
        ],

        child:BlocConsumer<AppCubit,AppStates>(
          builder: (context,state){
            var cubit=AppCubit.get(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Tasawq',
              themeMode: cubit.isDarkMode?ThemeMode.dark:ThemeMode.light,
              theme: lightTheme,
              darkTheme: darkTheme,
              home: startWidget,
            );
          },
          listener: (context,state){},
        )
    );
  }
}