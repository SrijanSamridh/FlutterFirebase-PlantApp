import 'package:flutter/material.dart';

import '../../Components/my_bottom_navbar.dart';
import '../../Components/next_plant.dart';

class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  State<Scan> createState() => _MyAppState();
}

class _MyAppState extends State<Scan> {
  final TextEditingController _nameController = TextEditingController();
  var myText = "Next plant!";
  var cnt = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: NextPlant(cnt: cnt, myText: myText, nameController: _nameController),
      bottomNavigationBar: const MyBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            myText = _nameController.text;
            cnt++;
            cnt %= 7;
          });
        },
        child: const Icon(Icons.refresh),
      ),
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

