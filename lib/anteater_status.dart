import 'package:flutter/material.dart';

// Shows the dirty or clean anteater image
class AnteaterStatus extends StatelessWidget {
  const AnteaterStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Zot Showers!!!",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Image.asset("assets/anteater2.jpeg", height: 200),
        ],
      ),
    );
  }
}
