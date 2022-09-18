import 'package:flutter/material.dart';

class BgImg extends StatelessWidget {
  dynamic opacity;
  final int cnt;

  BgImg({
    Key? key,
    this.cnt = 6,
    this.opacity = 0.0,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/img$cnt.jpg",
      fit: BoxFit.cover,
      color: Colors.black.withOpacity(opacity),
      colorBlendMode: BlendMode.darken,
    );
  }
}