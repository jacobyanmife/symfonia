import 'package:dio/dio.dart';
import 'package:symfonia/src/model/coin.dart';
import 'package:symfonia/src/utils/custom_exception.dart';
import 'package:symfonia/src/utils/dio_error_util.dart';

import 'base_api.dart';

class CoinsApi extends BaseAPI {
  Future<List<Coin>> getCoins() async {
    String url =
        'coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false';
    try {
      final Response<dynamic> res = await dio().get<dynamic>(url);

      switch (res.statusCode) {
        case 200:
        case 201:
          try {
            List<Coin> list = [];
            res.data.forEach((a) {
              list.add(Coin.fromJson(a));
            });
            return list;
          } catch (e) {
            throw 'Parsing error';
          }
        default:
          throw res.data['message'];
      }
    } catch (e) {
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }
}
