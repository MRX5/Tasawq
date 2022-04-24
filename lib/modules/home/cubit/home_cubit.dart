import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/change_favourites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/modules/home/cubit/home_states.dart';
import 'package:shop_app/shared/remote/dio_helper.dart';
import 'package:shop_app/shared/remote/end_points.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/local/cache_helper.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit():super(HomeInitialState());
  static HomeCubit get(context)=>BlocProvider.of(context);


  HomeModel? homeModel;
  
  Map<int,bool>favourites={};

  void getHomeData(){
    emit(GetHomeDataLoadingState());
    DioHelper.getData(url: 'home',token: token)
    .then((value){
      homeModel=HomeModel.fromJson(value.data);
      homeModel?.data?.products.forEach((element) { 
        favourites.addAll({element.id! :element.in_favourites!});
      });
      emit(GetHomeDataSuccessState());
    }).catchError((error){
      emit(GetHomeDataErrorState(error.toString()));
    });
  }
  
  CategoryModel?categoryModel;
  void getCategories(){
    emit(GetCategoriesLoadingState());
    DioHelper.getData(url: 'categories')
        .then((value){
          categoryModel=CategoryModel.fromJson(value.data);
          emit(GetCategoriesSuccessState());
    }).catchError((error){
      GetCategoriesErrorState(error.toString());
    });
  }

  ChangeFavouritesModel? favouritesModel;
  void changeFavourites(int? productId){
    bool? fav=favourites[productId];
    favourites[productId!]=!fav!;
    emit(ChangeFavouritesState());
      DioHelper.postData(url: favorites, data: {'product_id':productId},token: token)
          .then((value){
            favouritesModel=ChangeFavouritesModel.fromJson(value.data);
            if(favouritesModel?.status==false){
                favourites[productId]=fav;
            }
          emit(ChangeFavouritesSuccessState(favouritesModel!));
      }).catchError((error){
        favourites[productId]=fav;
        emit(ChangeFavouritesErrorState('Check internet connection'));
      });
  }
}