class SearchModel {
  bool? status;
  String? message;
  Data? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<SearchItem> items=[];

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      items =[];
      json['data'].forEach((v) {
        items.add(SearchItem.fromJson(v));
      });
    }
  }
}

class SearchItem {
  int? id;
  dynamic price;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  SearchItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}