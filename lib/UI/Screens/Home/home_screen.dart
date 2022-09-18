import 'package:flutter/material.dart';
import 'package:google_sign_in/widgets.dart';

import '../../Components/my_bottom_navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    this.name = "",
    this.email = "", required this.press, required this.profilePicture,
  }) : super(key: key);

  final String name, email;
  final VoidCallback press;
  final GoogleUserCircleAvatar profilePicture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
              leading: profilePicture,
              title: Text(name),
              subtitle: Text(email),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Signed In successfully!",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: press,
              child: const Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}
