import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zotshowers/logic.dart';
import 'package:zotshowers/money_widget.dart';

import 'shop.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop"),
        actions: const [
          MoneyWidget(color: Colors.white),
        ],
      ),
      body: BlocBuilder<UserDataCubit, UserData>(
        builder: (context, state) {
          return Shop(data: state);
        },
      ),
    );
  }
}
