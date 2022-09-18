import 'package:flutter/material.dart';
import 'title_with_more_btn.dart';
import '../../../../../utils/Constants.dart';

import 'recommended_plants.dart';
import 'featured_plant.dart';
import 'header_with_searchbox.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // It will provide the total height and width of the Screen
    Size size = MediaQuery.of(context).size;
    // It enables Screen Scrolling in small devices
    return SingleChildScrollView(
      child: Column(
        children: [
          HeaderWithSearchBox(size: size),
          TitleWithMoreBtn(title: "Recommended", press: () {}),
          const RecommendPlants(),
          TitleWithMoreBtn(title: "Featured Plants", press: () {}),
          const FeaturedPlants(),
          const SizedBox(height: kDefaultPadding,)
        ],
      ),
    );
  }
}
