import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String? name;

  @HiveField(1)
  final String? id;

  @HiveField(2)
  final String? aType;

  @HiveField(3)
  int? age;

  @HiveField(4)
  String? gender;

  @HiveField(5)
  bool? isLoggedIn;

  User({required this.name, required this.id, required this.aType});

  setAgeGender({required int age, required String gender}) {
    this.age = age;
    this.gender = gender;
  }

  logIn() {
    isLoggedIn = true;
  }

  logOut() {
    isLoggedIn = false;
  }
}
