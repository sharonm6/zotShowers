import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Displaying a box with button that asks if you showered
import 'logic.dart';

class ShoweringPrompt extends StatelessWidget {
  final UserData data;
  const ShoweringPrompt({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Card(
        color: Colors.blue,
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
      ),
    );
  }
}
