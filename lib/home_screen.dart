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
    final data = context.read<UserDataCubit>().state;

    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<UserDataCubit, UserData>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnteaterStatus(data: state),
                ShoweringPrompt(data: state),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: ShowerCalendar(data: state),
                ),
              ],
            );
          },
        ),
      ),
      appBar: AppBar(
        leading: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 10),
            Icon(Icons.monetization_on),
            Text("${data.coins}", style: TextStyle(fontWeight: FontWeight.bold, 
            fontSize: 18,
            ))
          ],
        ),
        title: const Text(
          "Zot Showers",
          style: TextStyle(fontFamily: "BelloScript", fontSize: 26),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart),
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
