import 'package:flutter/material.dart';
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
  final data = UserData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AnteaterStatus(),
              ShoweringPrompt(data: data),
              ShowerCalendar(),
            ],
          ),
        ),
      ),
    );
  }
}
