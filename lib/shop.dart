import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic.dart';

// Shows the dirty or clean anteater image
class Shop extends StatelessWidget {
  final UserData data;

  const Shop({Key? key, required this.data}) : super(key: key);

  void handleClick(BuildContext context, int idx) {
    if (!data.accessories.contains(ALL_ACCESSORIES[idx])) {
      context.read<UserDataCubit>().addAccessory(ALL_ACCESSORIES[idx]);
      context.read<UserDataCubit>().equipAccessory(ALL_ACCESSORIES[idx]);
    } else if (!data.equipped.contains(ALL_ACCESSORIES[idx])) {
      context.read<UserDataCubit>().equipAccessory(ALL_ACCESSORIES[idx]);
    } else {
      context.read<UserDataCubit>().unequipAccessory(ALL_ACCESSORIES[idx]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(
        ALL_ACCESSORIES.length,
        <Widget>(index) {
          final item = ALL_ACCESSORIES[index];
          Image img = Image.asset(ALL_ACCESSORIES[index].imagePath, height: 90);
          String buyEquip = "BUY";
          bool enabled = true;
          Color backgroundColor = Colors.blue;

          if (data.accessories.contains(item)) {
            if (data.equipped.contains(item)) {
              buyEquip = "UNEQUIP";
              backgroundColor = Colors.red;
            } else {
              buyEquip = "EQUIP";
              backgroundColor = Colors.green;
            }
          } else {
            enabled = item.price <= data.coins;
          }

          return Card(
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SizedBox(height: 5),
              img,
              const Spacer(),
              Text(ALL_ACCESSORIES[index].name, // indexing starts at 0
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15)),
              Text(
                data.accessories.contains(ALL_ACCESSORIES[index]) ? "Owned" : "🪙 ${ALL_ACCESSORIES[index].price}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: backgroundColor,
                  ),
                  onPressed: enabled ? () => handleClick(context, index) : null,
                  child: Text(
                    buyEquip, // indexing starts at 0
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
