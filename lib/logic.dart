import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataCubit extends Cubit<UserData> {
  UserDataCubit() : super(UserData(showerSet: {}, accessories: {}, coins: 0));

  void setDidShowerToday() {
    emit(state.copyWith(showerDate: state.today()));
  }
}

class Accessory extends Equatable {
  final String name;
  final String imagePath;
  final int price;

  const Accessory(this.name, this.imagePath, this.price);

  @override
  List<Object?> get props => [name, price];
}

const List<Accessory> ALL_ACCESSORIES = [
  Accessory("Foam Finger", "assets/foam_finger_accessory.png", 200),
  Accessory("Hat", "assets/hat_accessory.png", 300),
  Accessory("Jersey", "assets/jersey_accessory.png", 400),
  Accessory("Pink Ribbon", "assets/pink_ribbon_accessory.png", 100),
];

class UserData extends Equatable {
  final Set<DateTime> showerSet;
  final Set<Accessory> accessories;
  final int coins;

  UserData(
      {required this.showerSet,
      required this.accessories,
      required this.coins});

  UserData copyWith({DateTime? showerDate, Accessory? accessory, int? coins}) {
    return UserData(
        showerSet: showerDate == null ? showerSet : {...showerSet, showerDate},
        accessories:
            accessory == null ? accessories : {...accessories, accessory},
        coins: coins == null ? this.coins : coins);
  }

  bool didShowerToday() {
    return didShowerOnDay(today());
  }

  bool didShowerOnDay(DateTime day) {
    return showerSet.contains(day);
  }

  DateTime today() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return today;
  }

  int numTotalShowers() {
    return showerSet.length;
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
    int streak = 0;
    int days = 1;
    while (didShowerOnDay(today().subtract(Duration(days: days)))) {
      streak += 1;
      days += 1;
    }

    if (didShowerToday()) {
      streak += 1;
    }

    return streak;
  }

  @override
  List<Object?> get props => [accessories, showerSet];
}
