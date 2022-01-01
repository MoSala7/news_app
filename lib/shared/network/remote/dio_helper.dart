import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class DioHelper {
  static Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: false,
      ),
    );
  }

  static Future<Response> getData(
      {@required String url, @required Map<String, dynamic> query}) async {
    return dio.get(url, queryParameters: query);
  }
}
