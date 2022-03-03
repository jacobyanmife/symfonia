import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'src/api/coin_listing_api.dart';
import 'src/viewmodels/coins_vm.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => CoinsApi());
  locator.registerFactory(() => CoinsViewModel());
}

final List<SingleChildWidget> allProviders = <SingleChildWidget>[
  ChangeNotifierProvider<CoinsViewModel>(create: (_) => CoinsViewModel()),
];
