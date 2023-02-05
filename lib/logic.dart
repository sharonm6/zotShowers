import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDataCubit extends Cubit<UserData> {
  UserDataCubit() : super(UserData(showerSet: {}, accessories: {}));

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
  Accessory("Jersey", "assets/anteater0.png", 200),
  Accessory("Hat", "assets/anteater1.png", 100),
];

class UserData extends Equatable {
  final Set<DateTime> showerSet;
  final Set<Accessory> accessories;

  UserData({required this.showerSet, required this.accessories});

  UserData copyWith({DateTime? showerDate, Accessory? accessory}) {
    return UserData(
      showerSet: showerDate == null ? showerSet : {...showerSet, showerDate},
      accessories: accessory == null ? accessories : {...accessories, accessory},
    );
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
