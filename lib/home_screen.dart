import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zotshowers/logic.dart';
import 'package:zotshowers/shower_calendar.dart';
import 'package:zotshowers/showering_prompt.dart';

import 'anteater_status.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = context.watch<UserDataCubit>().state;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BlocBuilder<UserDataCubit, UserData>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnteaterStatus(data: state),
                ShoweringPrompt(data: state),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: ShowerCalendar(data: state),
                ),
              ],
            );
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            const Icon(Icons.monetization_on, color: Colors.black, size: 24),
            const SizedBox(width: 2),
            Text(
              "${data.coins}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                height: 1.4,
                color: Colors.black,
              ),
            )
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            tooltip: "Go to the next page",
            onPressed: () {
              context.go("/shop");
            },
          )
        ],
      ),
    );
  }
}
