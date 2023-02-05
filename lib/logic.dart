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
          coins: 50,
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
    emit(state.copyWith(equippedSet: [...state.equipped.where((e) => e.height != item.height), item]));
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

  const Accessory({required this.name, required this.imagePath, required this.price, required this.height});

  @override
  List<Object?> get props => [name, price, imagePath, height];
}

class Type {
  static const HAT = 10;
  static const JERSEY = 1;
  static const HAT_ADDITION = 11;
  static const HAND_ITEM = 20;
  static const ONESIE = 0;
}

const List<Accessory> ALL_ACCESSORIES = [
  Accessory(name: "Blue Gold Jersey", imagePath: "assets/bg_jersey_accessory.png", price: 8, height: Type.JERSEY),
  Accessory(name: "White Blue Jersey", imagePath: "assets/wb_jersey_accessory.png", price: 8, height: Type.JERSEY),
  Accessory(name: "Pink Ribbon", imagePath: "assets/pink_ribbon_accessory.png", price: 1, height: Type.HAT_ADDITION),
  Accessory(name: "Foam Finger", imagePath: "assets/foam_finger_accessory.png", price: 2, height: Type.HAND_ITEM),
  Accessory(name: "Hat", imagePath: "assets/hat_accessory.png", price: 4, height: Type.HAT),
  Accessory(name: "Fedora", imagePath: "assets/fedora_accessory.png", price: 4, height: Type.HAT),
  Accessory(name: "Crown", imagePath: "assets/crown_accessory.png", price: 4, height: Type.HAT),
  Accessory(name: "Magic Wand", imagePath: "assets/wand.png", price: 3, height: Type.HAND_ITEM),
  Accessory(name: "Football", imagePath: "assets/football_accessory.png", price: 2, height: Type.HAND_ITEM),
  Accessory(name: "Blue Dino Onesie", imagePath: "assets/dino_accessory.png", price: 15, height: Type.ONESIE),
  Accessory(name: "Green Dino Onesie", imagePath: "assets/green_dino_accessory.png", price: 15, height: Type.ONESIE),
  Accessory(name: "Purple Dino Onesie", imagePath: "assets/purple_dino_accessory.png", price: 15, height: Type.ONESIE),
  Accessory(name: "Sully Onesie", imagePath: "assets/sully_accessory.png", price: 20, height: Type.ONESIE),
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
