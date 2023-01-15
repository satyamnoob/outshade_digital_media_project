import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:outshade_digital_media_project/provider/mock_data_provider.dart';
import 'package:outshade_digital_media_project/view/main_views/home_view.dart';
import 'package:provider/provider.dart';

import '../../controller/hive_controller.dart';
import '../../model/user.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          Hive.openBox<User>('users');
          final box = HiveController.getUsers();
          if (mounted) {
            // ignore: prefer_is_empty
            if (box.keys.length == 0) {
              Provider.of<MockDataProvider>(
                context,
                listen: false,
              ).initializeUsers(firstTime: true);
            } else {
              Provider.of<MockDataProvider>(
                context,
                listen: false,
              ).initializeUsers(firstTime: false);
            }
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset(
            'assets/splash_png.png',
            height: 50,
          ),
          const SizedBox(
            height: 5.0,
          ),
          const Text("Hey Recruiter!"),
        ],
      ),
      function: () async {},
      nextScreen: const HomeView(title: "Dashboard"),
      splashTransition: SplashTransition.slideTransition,
    );
  }
}
