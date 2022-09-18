import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'components/http_networking.dart';
import '../../Components/my_bottom_navbar.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _MyAppState();
}

class _MyAppState extends State<Favourite> {
  final TextEditingController _nameController = TextEditingController();
  var myText = "Next plant!";
  var cnt = 0;
  var url = Uri.parse("https://jsonplaceholder.typicode.com/photos");
  dynamic data;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var res = await http.get(url);
    data = jsonDecode(res.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body:HttpNetworking(data: data),
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
