// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic.dart';

// Shows the dirty or clean anteater image
class Shop extends StatelessWidget {
  final UserData data;

  const Shop({Key? key, required this.data}) : super(key: key);

  handleClick(BuildContext context, int idx) {
    if (!data.accessories.contains(ALL_ACCESSORIES[idx])) {
      context.read<UserDataCubit>().addAccessory(ALL_ACCESSORIES[idx]);
    } else {
      if (!data.equipped.contains(ALL_ACCESSORIES[idx])) {
        context.read<UserDataCubit>().equipAccessory(ALL_ACCESSORIES[idx]);
      } else {
        context.read<UserDataCubit>().unequipAccessory(ALL_ACCESSORIES[idx]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(
        ALL_ACCESSORIES.length,
        <Widget>(index) {
          Image img;
          img = Image.asset(ALL_ACCESSORIES[index].imagePath, height: 100);
          String buyEquip = "BUY";

          if (data.accessories.contains(ALL_ACCESSORIES[index])) {
            buyEquip = "EQUIP";
            if (data.equipped.contains(ALL_ACCESSORIES[index])) {
              buyEquip = "UNEQUIP";
            } else {
              buyEquip = "EQUIP";
            }
          }

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
                        onPressed: () => handleClick(context, index),
                        child: Text(buyEquip, // indexing starts at 0
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10)),
                      ),
                      height: 17,
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
