import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_layout_states.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favourites/favourites_screen.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/local/cache_helper.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates>{
  ShopLayoutCubit():super(ShopLayoutInitialState());

  static ShopLayoutCubit get(context)=>BlocProvider.of(context);

  int bottomNavIndex=0;

  List<Widget>bottomNavScreens=[
    HomeScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen()
  ];


  void changeBottomNavIndex(int index){
    bottomNavIndex=index;
    emit(ShopLayoutBottomNavChangeState());
  }



}