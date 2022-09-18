import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/widgets.dart';
import 'package:plant_house/UI/Screens/Home/components/body.dart';

import '../../Components/drawer.dart';
import '../../Components/my_bottom_navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    this.name = "",
    this.email = "",
    required this.press,
    required this.profilePicture,
  }) : super(key: key);

  final String name, email;
  final VoidCallback press;
  final GoogleUserCircleAvatar profilePicture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const Body(),
      drawer: MyDrawer(
        profilePicture: profilePicture,
        name: name,
        email: email,
        press: press,
      ),
      bottomNavigationBar: const MyBottomNavBar(),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    elevation: 0,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(
            CupertinoIcons.line_horizontal_3_decrease,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    ),
  );
}
