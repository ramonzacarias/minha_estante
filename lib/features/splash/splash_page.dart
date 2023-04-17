import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF63B5AF),
                    Color(0xFF438883)
                  ])),
        child: const Text(
          "Minha Estante", 
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.w700,
            fontFamily: "Inter",
            color:Color(0xFFFFFFFF))),
      ),
    );
  }
}
