import 'package:flutter/material.dart';
import 'package:outshade_digital_media_project/controller/shared_preferences_controller.dart';
import 'package:outshade_digital_media_project/provider/mock_data_provider.dart';
import 'package:outshade_digital_media_project/view/main_views/profile_view.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class UserListTile extends StatefulWidget {
  const UserListTile({
    super.key,
    required this.user,
    required this.refreshView,
  });
  final User user;
  final VoidCallback refreshView;
  @override
  State<UserListTile> createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {
  bool isLoading = false;
  final TextEditingController _dummyController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  List<String> genders = ['Male', 'Female'];
  String dropdownvalue = 'Male';
  final bool _validate = false;

  @override
  Widget build(BuildContext context) {
    final isLoggedIn =
        widget.user.isLoggedIn != null && widget.user.isLoggedIn == true;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 5.0,
            ),
            decoration: const ShapeDecoration(
              color: Color(0xFF272A3C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            child: ListTile(
              key: UniqueKey(),
              tileColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              title: InkWell(
                onTap: () async {
                  _logInMechanism(
                    context: context,
                    isLoggedIn: isLoggedIn,
                  );
                },
                child: Text(
                  widget.user.name!,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              trailing: isLoggedIn
                  ? ElevatedButton(
                      onPressed: () {
                        User updatedUser = User(
                          name: widget.user.name,
                          id: widget.user.id,
                          aType: widget.user.aType,
                        );
                        updatedUser.setAgeGender(
                          age: widget.user.age!,
                          gender: dropdownvalue,
                        );
                        updatedUser.logOut();
                        Provider.of<MockDataProvider>(
                          context,
                          listen: false,
                        ).updateAUser(
                          updatedUser: updatedUser,
                          id: widget.user.id!,
                        );
                      },
                      child: const Text('Signout!'),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        final isCredentialsAdded =
                            await SharedPreferencesController
                                .checkingIfIdCredentialsAdded(widget.user.id!);
                        if (mounted) {
                          if (isCredentialsAdded) {
                            User updatedUser = User(
                              name: widget.user.name,
                              id: widget.user.id,
                              aType: widget.user.aType,
                            );
                            updatedUser.setAgeGender(
                              age: widget.user.age!,
                              gender: dropdownvalue,
                            );
                            updatedUser.logIn();
                            Provider.of<MockDataProvider>(
                              context,
                              listen: false,
                            ).updateAUser(
                              updatedUser: updatedUser,
                              id: widget.user.id!,
                            );
                          } else if (!isCredentialsAdded && !isLoggedIn) {
                            _logInMechanism(
                              context: context,
                              isLoggedIn: isLoggedIn,
                            );
                          }
                        }
                      },
                      child: const Text('Signin!'),
                    ),
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Basic Details'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter the Value',
                        errorText: _validate ? 'Value Can\'t Be Empty' : null,
                        hintText: 'Age',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _ageController.text = _dummyController.text;
                        });
                      },
                      keyboardType: TextInputType.number,
                      controller: _dummyController,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    DropdownButton(
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: genders.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    setState(() {
                      dropdownvalue = "Male";
                      Navigator.pop(context);
                    });
                  },
                ),
                TextButton(
                  child: const Text('Save'),
                  onPressed: () {
                    _saveBasicData();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  _logInMechanism({required BuildContext context, required isLoggedIn}) async {
    // print("Here");
    final isCredentialsAdded =
        await SharedPreferencesController.checkingIfIdCredentialsAdded(
            widget.user.id!);
    if (mounted) {
      if (!isCredentialsAdded && //if data not entered and user not signed in
          widget.user.isLoggedIn != false) {
        _displayTextInputDialog(context);
      } else if (isCredentialsAdded && !isLoggedIn) {
        User updatedUser = User(
          name: widget.user.name,
          id: widget.user.id,
          aType: widget.user.aType,
        );
        updatedUser.setAgeGender(
          age: int.parse(_ageController.text),
          gender: dropdownvalue,
        );
        updatedUser.logIn();
        Provider.of<MockDataProvider>(
          context,
          listen: false,
        ).updateAUser(
          updatedUser: updatedUser,
          id: widget.user.id!,
        );
        Navigator.of(context)
            .pushNamed(ProfileView.pageRoute, arguments: widget.user)
            .then(
              (value) => widget.refreshView(),
            );
      } else {
        Navigator.of(context)
            .pushNamed(ProfileView.pageRoute, arguments: widget.user)
            .then(
              (value) => widget.refreshView(),
            );
      }
    }
  }

  _saveBasicData() {
    User updatedUser = User(
      name: widget.user.name,
      id: widget.user.id,
      aType: widget.user.aType,
    );
    updatedUser.setAgeGender(
      age: int.parse(_ageController.text),
      gender: dropdownvalue,
    );
    updatedUser.logIn();
    Provider.of<MockDataProvider>(
      context,
      listen: false,
    ).updateAUser(
      updatedUser: updatedUser,
      id: widget.user.id!,
    );
    SharedPreferencesController.updatingCredentialsCheck(widget.user.id!);
    setState(() {
      dropdownvalue = "Male";
      _dummyController.text = "";
      _ageController.text = "";
    });
    widget.refreshView();
    Navigator.pop(context);
  }
}
