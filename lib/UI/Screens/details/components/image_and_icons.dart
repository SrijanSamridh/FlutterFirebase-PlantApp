import 'package:flutter/material.dart';

import '../../../../utils/Constants.dart';
import 'icon_card.dart';

class ImageAndIcons extends StatelessWidget {
  const ImageAndIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      child: SizedBox(
        height: size.height * 0.8,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: kDefaultPadding * 3),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                    ),
                    const Spacer(),
                    const IconCard(myIcon: Icons.sunny),
                    const IconCard(myIcon: Icons.water_drop_outlined),
                    const IconCard(myIcon: Icons.scale_outlined),
                    const IconCard(myIcon: Icons.air),
                  ],
                ),
              ),
            ),
            Container(
              height: size.height * 0.8,
              width: size.width * 0.75,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(68),
                  bottomLeft: Radius.circular(68),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 60,
                    color: kPrimaryColor.withOpacity(0.30),
                  )
                ],
                image: const DecorationImage(
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/img11.jpg"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
