import 'package:flutter/material.dart';
import 'package:todo_app/Screen/home_screen.dart';

import '../common-widgets/widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustonContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://static.vecteezy.com/system/resources/thumbnails/038/516/357/small_2x/ai-generated-eagle-logo-design-in-black-style-on-transparant-background-png.png",
              color: Colors.white,
              scale: 2,
            ),
            getText("Welcome to "),
            getText("Bright Future"),
            SizedBox(
              height: 70,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Text("Continue".toUpperCase()))
          ],
        ),
      ),
    );
  }

  getText(String title) {
    return Text(
      title.toString().toUpperCase(),
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
    );
  }
}
