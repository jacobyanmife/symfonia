import 'package:flutter/cupertino.dart';
// ignore: unused_import
import 'package:provider/provider.dart';
import 'package:symfonia/src/api/coin_listing_api.dart';
import 'package:symfonia/src/model/coin.dart';
import 'package:symfonia/src/utils/custom_Exception.dart';
import '../../locator.dart';
import 'base_vm.dart';

class CoinsViewModel extends BaseModel {
  final CoinsApi _api = locator<CoinsApi>();
  String? error;

  List<Coin> _filteredCoins = [];
  List<Coin> get filteredCoins => _filteredCoins;

  Future<void> getCoins(BuildContext context) async {
    setBusy(true);
    try {
      var allCoins = await _api.getCoins();
      _filteredCoins = allCoins;
      setBusy(false);
    } on CustomException catch (e) {
      error = e.message;
      setBusy(false);
    }
  }
}
