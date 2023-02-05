import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataCubit extends Cubit<UserData> {
  UserDataCubit()
      : super(UserData(
          showerSet: {},
          accessories: {},
          equipped: [],
          coins: 10,
        ));

  void setDidShowerToday() {
    emit(state.copyWith(
      showerDate: {...state.showerSet, state.today()},
      coins: state.coins + 1 + state.numContDaysShower(),
    ));
    save();
  }

  void addAccessory(Accessory item) {
    emit(state.copyWith(
      accessorySet: {...state.accessories, item},
      coins: max(state.coins - item.price, 0),
    ));
    save();
  }

  void equipAccessory(Accessory item) {
    emit(state.copyWith(equippedSet: [...state.equipped, item]));
    save();
  }

  void unequipAccessory(Accessory item) {
    emit(state.copyWith(equippedSet: state.equipped.where((element) => element != item).toList()));
    save();
  }

  void save() async {
    final Map<String, dynamic> map = {};
    map['coins'] = state.coins;
    map['showerSet'] = state.showerSet.map((dt) => dt.toIso8601String()).toList();
    map['accessories'] = state.accessories.map((a) => a.name).toList();
    map['equipped'] = state.equipped.map((a) => a.name).toList();

    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString("savedData", jsonEncode(map));
  }

  void load() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final str = sharedPrefs.getString("savedData");
    if (str == null) return;

    Map<String, dynamic> map = jsonDecode(str);
    emit(UserData(
      showerSet: (map['showerSet'] as List<dynamic>).map((s) => DateTime.parse(s)).toSet(),
      accessories: ALL_ACCESSORIES.where((a) => (map['accessories'] as List<dynamic>).contains(a.name)).toSet(),
      equipped: ALL_ACCESSORIES.where((a) => (map['equipped'] as List<dynamic>).contains(a.name)).toList(),
      coins: map['coins'],
    ));
  }
}

class Accessory extends Equatable {
  final String name;
  final String imagePath;
  final int price;
  final int height;

  const Accessory(this.name, this.imagePath, this.price, this.height);

  @override
  List<Object?> get props => [name, price, imagePath, height];
}

const List<Accessory> ALL_ACCESSORIES = [
  Accessory("Foam Finger", "assets/foam_finger_accessory.png", 2, 2),
  Accessory("Hat", "assets/hat_accessory.png", 4, 1),
  Accessory("Jersey", "assets/jersey_accessory.png", 8, 0),
  Accessory("Pink Ribbon", "assets/pink_ribbon_accessory.png", 1, 2),
];

class UserData extends Equatable {
  final Set<DateTime> showerSet;
  final Set<Accessory> accessories;
  final List<Accessory> equipped;
  final int coins;

  UserData({required this.showerSet, required this.accessories, required this.equipped, required this.coins}) {
    equipped.sort((a, b) => a.height.compareTo(b.height));
  }

  UserData copyWith({
    Set<DateTime>? showerDate,
    Set<Accessory>? accessorySet,
    List<Accessory>? equippedSet,
    int? coins,
  }) {
    return UserData(
      showerSet: showerDate ?? showerSet,
      accessories: accessorySet ?? accessories,
      equipped: equippedSet ?? equipped,
      coins: coins ?? this.coins,
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
  List<Object?> get props => [accessories, showerSet, equipped, coins];
}
