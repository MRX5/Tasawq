import 'package:dio/dio.dart';

class DioHelper {
  static const _BASE_URL = 'https://student.valuxapps.com/api/';
  static late Dio dio;

  static inti() {
    dio =
        Dio(BaseOptions(baseUrl: _BASE_URL, receiveDataWhenStatusError: true,contentType: 'application/json'));
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? query,
      String lang = 'en',
      String? token}) async {

      dio.options.headers={
        'lang':lang,
        'Authorization':token??'',
      };
    return await dio.get(url,queryParameters: query);
  }

  static Future<Response> postData(
      {required String url,
      required Map<String, dynamic> data,
      Map<String, dynamic>? query,
      String lang = 'en',
      String? token}) async {

      dio.options.headers={
        'lang':lang,
        'Authorization':token??'',
      };
    return  dio.post(url,data: data,queryParameters: query);
  }

  static Future<Response> putData(
      {required String url,
      required Map<String, dynamic> data,
      Map<String, dynamic>? query,
      String lang = 'en',
      String? token}) async {

      dio.options.headers={
        'lang':lang,
        'Authorization':token??'',
      };
    return dio.put(url,data: data,queryParameters: query);
  }

}
