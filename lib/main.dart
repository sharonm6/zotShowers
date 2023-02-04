import 'package:flutter/material.dart';
import 'package:zotshowers/anteater_status.dart';
import 'package:zotshowers/shower_calendar.dart';
import 'package:zotshowers/showering_prompt.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            AnteaterStatus(),
            ShoweringPrompt(),
            ShowerCalendar(),
          ],
        ),
      ),
    );
  }
}
