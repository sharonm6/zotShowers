// ignore_for_file: prefer_const_constructors

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
    String showerPl = "SHOWERS";

    if (totShowers == 1) {
      showerPl = "SHOWER";
    }

    String statusImg;
    if (daysWoShower == 0) {
      statusImg = "../assets/anteater0.PNG";
    } else if (daysWoShower == 1) {
      statusImg = "../assets/anteater1.PNG";
    } else if (daysWoShower == 2) {
      statusImg = "../assets/anteater2.PNG";
    } else if (daysWoShower == 3) {
      statusImg = "../assets/anteater3.PNG";
    } else if (daysWoShower == 4) {
      statusImg = "../assets/anteater4.PNG";
    } else if (daysWoShower == 5) {
      statusImg = "../assets/anteater5.PNG";
    } else if (daysWoShower == 6) {
      statusImg = "../assets/anteater6.PNG";
    } else {
      statusImg = "../assets/anteater7.PNG";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 45),
        Text(
          "$totShowers TOTAL $showerPl",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
          textAlign: TextAlign.center,
        ),
        Text(
          "$streakShower day shower streak",
          style: TextStyle(color: Colors.white, fontSize: 30),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        SizedBox(
            child: Image.asset(statusImg, fit: BoxFit.fitHeight), height: 350)
      ],
    );
  }
}
