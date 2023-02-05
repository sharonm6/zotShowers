// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'logic.dart';

// Shows the dirty or clean anteater image
class Shop extends StatelessWidget {
  final UserData data;

  const Shop({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(
        ALL_ACCESSORIES.length,
        <Widget>(index) {
          Image img;
          img = Image.asset(ALL_ACCESSORIES[index].imagePath, height: 100);
          return Card(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(children: [
                    SizedBox(height: 7),
                    img,
                    SizedBox(height: 5),
                    Text(
                        "${ALL_ACCESSORIES[index].name}", // indexing starts at 0
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15)),
                    SizedBox(height: 5),
                    Text(
                        "🪙 ${ALL_ACCESSORIES[index].price}", // indexing starts at 0
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15)),
                    SizedBox(height: 5),
                    SizedBox(
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Colors.blueAccent),
                        ),
                        onPressed: () {},
                        child: Text("BUY", // indexing starts at 0
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10)),
                      ),
                      height: 15,
                    ),
                  ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
