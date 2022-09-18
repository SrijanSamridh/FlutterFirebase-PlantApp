import 'package:flutter/material.dart';
import 'package:plant_house/UI/Components/bg_img.dart';

class NextPlant extends StatelessWidget {
  final int cnt;
  final String myText;
  final TextEditingController _nameController;

  const NextPlant({
    Key? key,
    required this.cnt,
    required this.myText,
    required TextEditingController nameController,
  })  : _nameController = nameController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Column(
          children: [
            BgImg(cnt: cnt, opacity: 0.0,),
            const SizedBox(
              height: 20,
            ),
            Text(
              myText,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter here",
                  labelText: "Name",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

