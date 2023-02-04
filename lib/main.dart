import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zotshowers/anteater_status.dart';
import 'package:zotshowers/logic.dart';
import 'package:zotshowers/shower_calendar.dart';
import 'package:zotshowers/showering_prompt.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserDataCubit(),
      child: MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: BlocBuilder<UserDataCubit, UserData>(
              builder: (context, state) {
                return Column(
                  children: [
                    AnteaterStatus(data: state),
                    ShoweringPrompt(data: state),
                    ShowerCalendar(data:state),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
