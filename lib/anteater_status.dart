// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';

import 'logic.dart';

// Shows the dirty or clean anteater image
class AnteaterStatus extends StatelessWidget {
  final UserData data;

  const AnteaterStatus({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totShowers = data.numTotalShowers();
    int streakShower = data.numContDaysShower();
    int daysWoShower = data.numDaysWithoutShower();
    String showerPl = totShowers == 1 ? "Shower" : "Showers";

    String? statusImg;
    if (daysWoShower == 0) {
      statusImg = null;
    } else if (daysWoShower == 1) {
      statusImg = "assets/stink1.png";
    } else if (daysWoShower == 2) {
      statusImg = "assets/stink2.png";
    } else if (daysWoShower == 3) {
      statusImg = "assets/stink3.png";
    } else if (daysWoShower == 4) {
      statusImg = "assets/stink4.png";
    } else if (daysWoShower == 5) {
      statusImg = "assets/stink5.png";
    } else if (daysWoShower == 6) {
      statusImg = "assets/stink6.png";
    } else {
      statusImg = "assets/stink7.png";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 32),
        SizedBox(
          height: 500,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Image.asset("assets/zot_showers_logo_non_circle.png", height: 250),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset("assets/anteater0.png", fit: BoxFit.fitHeight, height: 350),
              ),
              for (final accessory in data.equipped)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(accessory.imagePath, fit: BoxFit.fitHeight, height: 350),
                ),
              if (statusImg != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    statusImg,
                    fit: BoxFit.fitHeight,
                    height: 350,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          "$totShowers Total $showerPl",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "🚿 $streakShower day shower streak",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
