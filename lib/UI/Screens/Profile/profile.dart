import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/Constants.dart';
import '../../Components/drawer.dart';
import '../../Components/my_bottom_navbar.dart';
import 'components/body.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Body(),
      bottomNavigationBar: const MyBottomNavBar(),
    );
  }
}



AppBar buildAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    title: GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/home');
      },
      child: const Text("PLANT HOUSE"),
    ),
    actions: [
      IconButton(
          onPressed: () {
            // Constants.prefs.setBool("loggedIn", false);
            Navigator.pushReplacementNamed(context, "/cam_page");
          },
          icon: const Icon(Icons.camera_alt_outlined))
    ],
  );
}
