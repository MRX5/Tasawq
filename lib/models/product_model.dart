class ProductModel{
  int? id;
  String? name;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? description;
  List<String> images=[];
  bool? in_favourites;
  bool? in_cart;

  ProductModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    description=json['description'];
    in_favourites=json['in_favorites'];
    in_cart=json['in_cart'];
    json['images'].forEach((element){
      images.add(element.toString());
    });
  }
}