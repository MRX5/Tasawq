class FavouritesModel{
  bool status=false;
  Data? data;
  FavouritesModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=Data.fromJson(json['data']);
  }
}

class Data{
  int currentPage=1;
  List<FavouritesData> data=[];
  String firstPageUrl='';
  int? from;
  int lastPage=1;
  String lastPageUrl='';
  String? nextPageUrl;
  String path='';
  int perPage=0;
  String? prevPageUrl;
  int? to;
  int total=0;

  Data.fromJson(Map<String,dynamic>json){
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((element) {
        data.add(FavouritesData.fromJson(element));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class FavouritesData{
  int? id;
  Product? product;
  FavouritesData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    product=json['product']!=null?Product.fromJson(json['product']):null;
  }
}

class Product{
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String,dynamic>json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}