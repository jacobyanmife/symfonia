import 'package:dio/dio.dart';

class BaseAPI {
  Dio dio() {
    return Dio(
      BaseOptions(
        baseUrl: "https://api.coingecko.com/api/v3/",
        sendTimeout: 30000,
        connectTimeout: 50000,
        receiveTimeout: 50000,
        contentType: 'application/json',
        validateStatus: (int? s) => s! < 500,
      ),
    );
  }
}
