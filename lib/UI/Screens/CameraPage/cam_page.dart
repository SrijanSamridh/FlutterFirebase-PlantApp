import 'package:flutter/material.dart';
import '../../Components/my_bottom_navbar.dart';
import 'components/camera_screen.dart';

class CamPage extends StatelessWidget {
  const CamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Data"),
      ),
      body: const Body(),
      bottomNavigationBar: const MyBottomNavBar(),
    );
  }
}
