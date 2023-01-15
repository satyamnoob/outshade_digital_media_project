import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:outshade_digital_media_project/model/user.dart';
import 'package:outshade_digital_media_project/provider/mock_data_provider.dart';
import 'package:outshade_digital_media_project/view/main_views/profile_view.dart';
import 'package:provider/provider.dart';

import 'view/entry_views/splash_view.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  _hiveInititalization();
  runApp(const MyApp());
}

Future<void> _hiveInititalization() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('users');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MockDataProvider(),
      child: MaterialApp(
        title: 'Outshade Digital Media Project Assignment',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const SplashView(),
        routes: {
          ProfileView.pageRoute: (context) => const ProfileView(),
        },
      ),
    );
  }
}
