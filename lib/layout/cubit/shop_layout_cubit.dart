import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_layout_states.dart';
import 'package:shop_app/models/cart/cart_model.dart';
import 'package:shop_app/models/cart/change_cart_model.dart';
import 'package:shop_app/modules/cart/cart_screen.dart';
import 'package:shop_app/modules/favourites/favourites_screen.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import '../../models/category_model.dart';
import '../../models/favourites/change_favourites_model.dart';
import '../../models/favourites/favouritesModel.dart';
import '../../models/home_model.dart';
import '../../models/product_details_model.dart';
import '../../shared/remote/dio_helper.dart';
import '../../shared/remote/end_points.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates>{
  ShopLayoutCubit():super(ShopLayoutInitialState());

  static ShopLayoutCubit get(context)=>BlocProvider.of(context);

  int bottomNavIndex=0;

  List<Widget>bottomNavScreens=[
    HomeScreen(),
    CartScreen(),
    FavouritesScreen(),
    SettingsScreen()
  ];


  void changeBottomNavIndex(int index){
    bottomNavIndex=index;
    emit(ShopLayoutBottomNavChangeState());
  }

  HomeModel? homeModel;

  Map<int,bool>favourites={};
  Map<int,bool>inCart={};

  void getHomeData(){
    emit(GetHomeDataLoadingState());
    DioHelper.getData(url: 'home',token: token)
        .then((value){
      homeModel=HomeModel.fromJson(value.data);
      homeModel?.data?.products.forEach((element) {
        favourites.addAll({element.id! :element.in_favourites!});
      });

      homeModel?.data?.products.forEach((element) {
        inCart.addAll({element.id! :element.in_cart!});
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

  ChangeFavouritesModel? changeFavouritesModel;
  void changeFavourites(int? productId){
    bool? fav=favourites[productId];
    favourites[productId!]=!fav!;
    emit(ChangeFavouritesState());
    DioHelper.postData(url: favorites, data: {'product_id':productId},token: token)
        .then((value){
      changeFavouritesModel=ChangeFavouritesModel.fromJson(value.data);
      if(changeFavouritesModel?.status==false){
        favourites[productId]=fav;
      }else{
        getFavouritesProducts();
      }
      emit(ChangeFavouritesSuccessState(changeFavouritesModel!));
    }).catchError((error){
      favourites[productId]=fav;
      emit(ChangeFavouritesErrorState('Check internet connection'));
    });
  }

  FavouritesModel? favouritesModel;
  void getFavouritesProducts(){
    emit(GetFavouritesLoadingState());
    DioHelper.getData(url: favorites,token: token)
        .then((value){
      favouritesModel=FavouritesModel.fromJson(value.data);
      favouritesModel?.data?.data.forEach((element) {
        favourites.addAll({element.product!.id! :true});
      });
      emit(GetFavouritesSuccessState());
    }).catchError((error){
      emit(GetFavouritesErrorState());
    });
  }

  ChangeCartModel? changeCartModel;
  void changeCart(int? productId){
    bool? cart=inCart[productId!];
    inCart[productId]=!cart!;
    emit(ChangeCartState());
    DioHelper.postData(url: 'carts', data: {'product_id':productId},token: token)
    .then((value){
      changeCartModel=ChangeCartModel.fromJson(value.data);
      if(changeCartModel?.status==false){
        inCart[productId]=cart;
      }else{
        getInCartProducts();
      }
      emit(ChangeCartSuccessState(changeCartModel!));
    }).catchError((error){
      inCart[productId]=cart;
      emit(ChangeCartErrorState('Check internet connection'));
    });
  }
  
  CartModel? cartModel;
  void getInCartProducts(){
      emit(GetCartLoadingState());
      DioHelper.getData(url: 'carts',token: token)
      .then((value){
        cartModel=CartModel.fromJson(value.data);
        cartModel?.data?.cartItems.forEach((element) {
          inCart.addAll({element.product!.id :true});
        });
        emit(GetCartSuccessState(cartModel!));
      }).catchError((_){
        emit(GetCartErrorState('Check internet connection'));
      });
  }

  ProductDetailsModel? productDetailsModel;
  void getProductDetails({
    required int productId,
  }){
    productDetailsModel=null;
    emit(GetProductLoadingState());
    DioHelper.getData(
        url: 'products/$productId',
        token: token
    ).then((value){
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      print(productDetailsModel!.data!.id);
      emit(GetProductSuccessStateState(productDetailsModel!));
    }).catchError((error){
      emit(GetProductErrorState('Check internet connection'));
    });
  }

  void increaseProductQuantity({required int productId}){
    cartModel?.data?.cartItems[productId].quantity++;
    int sum=cartModel?.data?.subTotal??0;
    sum+=(cartModel?.data?.cartItems[productId].product?.price) ??0;
    cartModel?.data?.subTotal = sum;
    cartModel?.data?.total=sum;
    emit(IncreaseProductQuantityState());
  }
  void decreaseProductQuantity({required int productId}){
    int quantity=cartModel?.data?.cartItems[productId].quantity ?? 0;
    if(quantity>0) {
      cartModel?.data?.cartItems[productId].quantity--;
      int sum = cartModel?.data?.subTotal ?? 0;
      sum -= (cartModel?.data?.cartItems[productId].product?.price) ?? 0;
      cartModel?.data?.subTotal = sum;
      cartModel?.data?.total = sum;
      emit(DecreaseProductQuantityState());
    }
  }

}