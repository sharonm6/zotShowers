import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zotshowers/logic.dart';
import 'shop.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        child: BlocBuilder<UserDataCubit, UserData>(
          builder: (context, state) {
            return Column(
              children: [
                Shop(data: state),
              ],
            );
          },
        ),
      ),
    );
  }
}
