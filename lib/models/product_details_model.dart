
import 'package:shop_app/models/product_model.dart';

class ProductDetailsModel {
  bool status = false;
  String? message;
  ProductModel? data;

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ProductModel.fromJson(json['data']) : null;
  }

}