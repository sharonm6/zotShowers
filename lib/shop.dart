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
            children: List.generate(8, <Widget>(index) {
              Image img;
              img = Image.asset("assets/anteater$index.PNG", height: 200);
              return Stack(children: [
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "$index", // indexing starts at 0
                      textAlign: TextAlign.center,
                    )),
                img,
              ]);
            }),
          ),
        ),
      ],
    );
  }
}
