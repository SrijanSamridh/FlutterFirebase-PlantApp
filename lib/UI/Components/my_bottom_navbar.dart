// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../utils/Constants.dart';
import '../../utils/Constants.dart';


class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LinearNavbar();
  }

  // CurvedNavigationBar buildCurvedNavigationBar() {
  //   return CurvedNavigationBar(
  //     backgroundColor: kPrimaryColor.withOpacity(0.0),
  //     color: kPrimaryColor.shade300,
  //     animationDuration: const Duration(milliseconds: 300),
  //     onTap: (index){
  //       print(index);
  //     },
  //     items: const [
  //   Icon(Icons.home),
  //   Icon(Icons.favorite_border),
  //   Icon(Icons.camera),
  //   Icon(Icons.person_outline),
  // ]);
  // }
}

class LinearNavbar extends StatelessWidget {
  const LinearNavbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
        bottom: kDefaultPadding,
      ),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -10),
            blurRadius: 35,
            color: kPrimaryColor.withOpacity(0.38),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: const Icon(
              Icons.home_filled,
              color: kPrimaryColor,
              size: 28,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/favourite');
            },
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.black12,
              size: 28,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cam_page');
            },
            icon: const Icon(
              Icons.camera,
              color: Colors.black12,
              size: 28,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: const Icon(
              Icons.person_outline,
              color: Colors.black12,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
