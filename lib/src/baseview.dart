import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../locator.dart';
import 'viewmodels/base_vm.dart';

class BaseView<T extends BaseModel> extends StatefulWidget {
  const BaseView({required this.builder, this.onModelReady, Key? key})
      : super(key: key);

  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T)? onModelReady;

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
        value: model, child: Consumer<T>(builder: widget.builder));
  }
}
