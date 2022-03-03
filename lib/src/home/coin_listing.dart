import 'package:coolicons/coolicons.dart';
import 'package:flutter/material.dart';
import 'package:symfonia/src/model/coin.dart';
import 'package:symfonia/src/utils/utils.dart';
import 'package:symfonia/src/viewmodels/coins_vm.dart';
import '../baseview.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<CoinsViewModel>(
          onModelReady: (model) => model.getCoins(context),
          builder: (_, CoinsViewModel model, __) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).padding.top,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'History',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                        ),
                        Row(
                          children: [
                            const Icon(Coolicons.slider_02),
                            const SizedBox(width: 8),
                            Text(
                              'Sort/Filter',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    model.busy
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 16),
                            shrinkWrap: true,
                            itemCount: model.filteredCoins.length,
                            itemBuilder: (BuildContext context, int index) {
                              var coin = model.filteredCoins[index];
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 40),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: coin.image != null
                                          ? Image.network(
                                              coin.image ?? '-',
                                              width: 30,
                                              height: 30,
                                            )
                                          : Image.asset(
                                              'assets/images/bitcoin.png',
                                              width: 30,
                                              height: 30,
                                            )),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        coin.name ?? '-',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        '\$${coin.currentPrice}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        Utils.formatDate(DateTime.parse(
                                                coin.lastUpdated ??
                                                    DateTime.now()
                                                        .toIso8601String())
                                            .toIso8601String()),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${coin.priceChange24h?.toStringAsFixed(2).changeInPrice()}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.green),
                                  )
                                ],
                              );
                            },
                          ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
