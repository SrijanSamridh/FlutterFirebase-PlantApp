import 'package:flutter/material.dart';
import 'package:plant_house/UI/Screens/details/components/title_and_price.dart';
import 'package:plant_house/utils/Constants.dart';

import 'image_and_icons.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          const ImageAndIcons(),
          const TitleAndPrice(title: "Angelica", country: "Russia", price: 400),
          Row(
            children: const [
              DetailsBtn(
                  color: kPrimaryColor,
                  radius: 20,
                  text: 'Buy Now',
                  textColor: Colors.white),
              Expanded(
                  child: DetailsBtn(
                      color: Colors.transparent,
                      radius: 20,
                      text: 'Description',
                      textColor: kTextColor)),
            ],
          ),
        ],
      ),
    );
  }
}

class DetailsBtn extends StatelessWidget {
  const DetailsBtn({
    Key? key,
    required this.color,
    required this.radius,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  final Color color;
  final double radius;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / 2,
      height: 84,
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ))),
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(radius),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
