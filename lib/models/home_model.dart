import 'dart:core';

import 'package:shop_app/models/product_model.dart';

class HomeModel{
  bool? status;
  HomeData? data;
  HomeModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=HomeData.fromJson(json['data']);
  }
}

class HomeData{
  List<HomeBanner> banners=[];
  List<ProductModel>products=[];

  HomeData.fromJson(Map<String,dynamic>json){
    json['banners'].forEach((element){
      banners.add(HomeBanner.fromJson(element));
    });
    json['products'].forEach((element){
      products.add(ProductModel.fromJson(element));
    });
  }
}

class HomeBanner{
  int? id;
  String? image;
  HomeBanner.fromJson(Map<String,dynamic>json){
    id=json['id'];
    image=json['image'];
    }
}