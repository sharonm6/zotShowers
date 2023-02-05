import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zotshowers/logic.dart';

import 'shop.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop"),
      ),
      body: BlocBuilder<UserDataCubit, UserData>(
        builder: (context, state) {
          return Shop(data: state);
        },
      ),
    );
  }
}
