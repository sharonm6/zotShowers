import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Displaying a box with button that asks if you showered
import 'logic.dart';

class ShoweringPrompt extends StatelessWidget {
  final UserData data;

  const ShoweringPrompt({Key? key, required this.data}) : super(key: key);

  Widget buildContent(BuildContext context) {
    if (data.didShowerToday()) {
      return Column(
        children: const [
          Text(
            "You showered today!",
            style: TextStyle(fontSize: 20, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            "Your fellow anteaters thank you!",
            style: TextStyle(fontSize: 20, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Have you showered today?',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffffbf00),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
          onPressed: () {
            context.read<UserDataCubit>().setDidShowerToday();
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: buildContent(context),
    );
  }
}
