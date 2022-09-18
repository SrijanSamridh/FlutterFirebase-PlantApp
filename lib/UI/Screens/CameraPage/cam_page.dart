import 'package:flutter/material.dart';
import 'components/body.dart';

class CamPage extends StatelessWidget {
  const CamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Body(),
    );
  }
}
