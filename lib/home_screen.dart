import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zotshowers/logic.dart';
import 'package:zotshowers/shower_calendar.dart';
import 'package:zotshowers/showering_prompt.dart';

import 'anteater_status.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        child: BlocBuilder<UserDataCubit, UserData>(
          builder: (context, state) {
            return Column(
              children: [
                AnteaterStatus(data: state),
                ShoweringPrompt(data: state),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ShowerCalendar(data: state),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
