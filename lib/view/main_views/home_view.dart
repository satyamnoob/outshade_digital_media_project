import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:outshade_digital_media_project/provider/mock_data_provider.dart';
import 'package:provider/provider.dart';

// import '../../controller/hive_controller.dart';
import '../../model/user.dart';
import '../../widgets/user_list_tile.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  refreshView() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<User> users = Provider.of<MockDataProvider>(context).getAllUsers;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return UserListTile(
                  refreshView: refreshView,
                  user: users[index],
                );
              },
              itemCount: users.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 5,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
