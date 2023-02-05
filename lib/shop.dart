import 'package:flutter/material.dart';
import 'logic.dart';

// Shows the dirty or clean anteater image
class Shop extends StatelessWidget {
  final UserData data;

  const Shop({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 800,
          child: GridView.count(
            crossAxisCount: 4,
            children: List.generate(
              2,
              <Widget>(index) {
                Image img;
                img =
                    Image.asset(ALL_ACCESSORIES[index].imagePath, height: 200);
                return Card(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(children: [
                          img,
                          SizedBox(height: 20),
                          Text(
                              "${ALL_ACCESSORIES[index].name}", // indexing starts at 0
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20)),
                          SizedBox(height: 5),
                          Text(
                              "🪙 ${ALL_ACCESSORIES[index].price}", // indexing starts at 0
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20)),
                          SizedBox(height: 10),
                          TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.blueAccent),
                            ),
                            onPressed: () {},
                            child: Text("BUY", // indexing starts at 0
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15)),
                          ),
                        ]),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
