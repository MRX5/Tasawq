class LogoutModel{
  bool status=false;
  String? message;

  LogoutModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}