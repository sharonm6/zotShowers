import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zotshowers/logic.dart';

class MoneyWidget extends StatelessWidget {
  final Color color;

  const MoneyWidget({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = context.watch<UserDataCubit>().state;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 12),
        Icon(Icons.monetization_on, color: color, size: 24),
        const SizedBox(width: 2),
        Text(
          "${data.coins}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            height: 1.4,
            color: color,
          ),
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}
