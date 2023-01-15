import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controller/hive_controller.dart';
import '../model/user.dart';

class MockDataProvider extends ChangeNotifier {
  final List<User> _users = [];

  initializeUsers({required bool firstTime}) async {
    final String response = await rootBundle.loadString('assets/mockdata.json');
    final List<dynamic> data = await json.decode(response);
    final box = HiveController.getUsers();
    if (firstTime) {
      for (var i = 0; i < data[0]['users'].length; i++) {
        String name = data[0]['users'][i]["name"];
        String id = data[0]['users'][i]["id"];
        // print(id);
        String aType = data[0]['users'][i]["atype"];
        User user = User(
          name: name,
          id: id,
          aType: aType,
        );
        // print("${user.name} ${user.id} ${user.aType}");
        _users.add(user);
        box.put(id, user);
      }
    } else {
      final List<int> keys = box.keys.map((e) => int.parse(e)).toList();
      keys.sort();
      for (var key in keys) {
        User? user = box.get(key.toString());
        // print(
        //     "$key ${user!.name} ${user.id} ${user.aType} ${user.age} ${user.gender}");
        _users.add(user!);
      }
    }
    notifyListeners();
    // print(data[0]['users'][0]);
  }

  updateAUser({required User updatedUser, required String id}) async {
    _users[_users.indexWhere((element) => element.id == id)] = updatedUser;
    // print(
    //     "$id ${updatedUser.name} ${updatedUser.age} ${updatedUser.gender} ${updatedUser.aType}");
    final box = HiveController.getUsers();
    box.delete(id);
    final List<int> keys = box.keys.map((e) => int.parse(e)).toList();
    keys.sort();
    // for (var key in keys) {
    //   User? user = box.get(key.toString());
    // print(
    //     "${user!.name} ${user.id} ${user.aType} ${user.age} ${user.gender} ${user.isLoggedIn}");
    // }
    box.put(id, updatedUser);
    notifyListeners();
  }

  List<User> get getAllUsers => [..._users];
}
