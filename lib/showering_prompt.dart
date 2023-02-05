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
        style: TextStyle(color: Colors.white, fontSize: 25),
        textAlign: TextAlign.center,
      );
    }
    return Card(
      child: SizedBox(
        width: 300,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Have you showered today?'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<UserDataCubit>().setDidShowerToday();
              },
              child: Text("Yes"),
            ),
          ],
        ),
      ),
    );
  }
}
