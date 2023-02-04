import 'package:flutter/cupertino.dart';

class UserData with ChangeNotifier {
  final Map<DateTime, bool> showerMap = {};

  bool didShowerToday() {
    return didShowerOnDay(today());
  }

  bool didShowerOnDay(DateTime day) {
    return showerMap[day] ?? false;
  }

  void setDidShowerToday() {
    showerMap[today()] = true;
    notifyListeners();
  }

  DateTime today() {
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
      if (didShowerOnDay(today().subtract(Duration(days: i)))) {
        return i;
      }
    }

    return MAX_DAYS_WITHOUT_SHOWER;
  }

  int numContDaysShower() {
    int CONT_DAYS_WITH_SHOWER = 0;
    int days = 1;
    while (didShowerOnDay(_today().subtract(Duration(days: days)))) {
      CONT_DAYS_WITH_SHOWER += 1;
      days += 1;
    }

    return CONT_DAYS_WITH_SHOWER;
  }
}
