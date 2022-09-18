import 'package:flutter/material.dart';
import 'package:plant_house/UI/Components/bg_img.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
    required this.press,
  }) : super(key: key);

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGIN PAGE"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          BgImg(
            opacity: 0.7,
          ),
          Center(
              child: LoginForm(
            press: press,
          )),
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.press,
  }) : super(key: key);

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Card(
          color: Colors.white38,
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Image.asset("assets/icons/GoogleLogo.png", scale: 35,),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "Welcome to Plant House!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: press,
                  style: ElevatedButton.styleFrom(
                      elevation: 12.0,
                      backgroundColor: Colors.green,
                      textStyle: const TextStyle(color: Colors.white)),
                  child: const Text('Login In With Google'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
