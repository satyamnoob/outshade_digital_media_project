import 'package:hive/hive.dart';

import '../model/user.dart';

class HiveController {
  static Box<User> getUsers() => Hive.box<User>('users');
}
