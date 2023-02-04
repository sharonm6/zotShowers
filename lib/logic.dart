import 'package:flutter/cupertino.dart';

class UserData with ChangeNotifier {
  final Map<DateTime, bool> showerMap = {};

  bool didShowerToday() {
    return didShowerOnDay(_today());
  }

  bool didShowerOnDay(DateTime day) {
    return showerMap[day] ?? false;
  }

  void setDidShowerToday() {
    showerMap[_today()] = true;
    notifyListeners();
  }

  DateTime _today() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return today;
  }

  int numTotalShowers() {
    return showerMap.length;
  }

  int numDaysWithoutShower() {
    int MAX_DAYS_WITHOUT_SHOWER = 7;
    for (int i = 0; i < MAX_DAYS_WITHOUT_SHOWER; i++) {
      if (didShowerOnDay(_today().subtract(Duration(days: 1)))) {
        return i;
      }
    }

    return MAX_DAYS_WITHOUT_SHOWER;
  }
}