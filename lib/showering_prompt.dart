import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Displaying a box with button that asks if you showered
import 'logic.dart';

class ShoweringPrompt extends StatelessWidget {
  final UserData data;

  const ShoweringPrompt({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.didShowerToday()) {
      return Text(
        "Foo showered today! \n Your fellow anteaters thank you!",
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      );
    }
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Have you showered today?',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffffbf00),
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
            onPressed: () {
              context.read<UserDataCubit>().setDidShowerToday();
            },
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }
}
