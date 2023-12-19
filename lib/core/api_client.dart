import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio = Dio();

  BaseOptions options = BaseOptions(
      // connectTimeout: Duration(milliseconds: 10000),
      // receiveTimeout: Duration(milliseconds: 10000),
      validateStatus: (status) {
        return status! <= 500;
      },
      contentType: "application/json",
      headers: {
        "Content-Type": "application/json",
        "Connection": "Keep-Alive",
        // "User-Agent": deviceInfo.getEncryptedAppId(),
      });

  Dio getDio() {
    dio.options = options;
    return dio;
  }
}
