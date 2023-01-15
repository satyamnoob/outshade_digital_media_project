import 'package:flutter/material.dart';
import 'package:outshade_digital_media_project/model/user.dart';
import 'package:outshade_digital_media_project/provider/mock_data_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/card_container.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
  });
  static const String pageRoute = '/profile-screen';

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User? user;

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.id == null ? 'User Profile' : user!.name as String),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              User updatedUser = User(
                name: user!.name,
                id: user!.id,
                aType: user!.aType,
              );
              updatedUser.setAgeGender(
                age: user!.age!,
                gender: user!.gender!,
              );
              updatedUser.logOut();
              Provider.of<MockDataProvider>(
                context,
                listen: false,
              ).updateAUser(updatedUser: updatedUser, id: user!.id!);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFF272A3C),
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter, //to align its child
        child: CardContainer(user: user!),
      ),
    );
  }
}
