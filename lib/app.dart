import 'package:flutter/material.dart';
import 'features/sign_in/login_page.dart';
import 'package:minha_estante/features/onboarding/onboarding_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OnboardingPage()
    );
  }
}
