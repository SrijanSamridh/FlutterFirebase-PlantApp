import 'package:flutter/material.dart';

import '../../../../utils/Constants.dart';


class FeaturedPlants extends StatelessWidget {
  const FeaturedPlants({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FeaturedPlantCards(
            image: "assets/images/img9.jpg",
            press: () {},
          ),
          FeaturedPlantCards(
            image: "assets/images/img5.jpg",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class FeaturedPlantCards extends StatelessWidget {
  const FeaturedPlantCards({
    Key? key,
    required this.image,
    required this.press,
  }) : super(key: key);
  final String image;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2,
        ),
        width: size.width * 0.8,
        height: 185,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(image))),
      ),
    );
  }
}
