class CartModel {
  bool status=false;
  String? message;
  Data? data;

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<CartItems> cartItems=[];
  double? subTotal;
  double? total;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      json['cart_items'].forEach((v) {
        cartItems.add(CartItems.fromJson(v));
      });
    }
    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class CartItems {
  int id=0;
  int quantity=0;
  Product? product;

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }

}

class Product {
  int id=0;
  dynamic price=0;
  dynamic oldPrice=0;
  dynamic discount=0;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool inFavorites=false;
  bool inCart=false;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}