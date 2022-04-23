class CategoryModel{
  bool? status;
  CategoryData? data;

  CategoryModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=CategoryData.fromJson(json['data']);
  }
}

class CategoryData{
    List<CategoryInfo>categoriesList=[];

    CategoryData.fromJson(Map<String,dynamic>json){
      json['data'].forEach((element) {
        categoriesList.add(CategoryInfo.fromJson(element));
      });
    }
}
class CategoryInfo{

  int? id;
  String? name;

  CategoryInfo.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
  }
}