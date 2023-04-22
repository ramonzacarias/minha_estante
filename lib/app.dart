import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/routes.dart';
import 'package:minha_estante/features/onboarding/onboarding_page.dart';
import 'package:minha_estante/features/sign_in/sign_in_page.dart';
import 'package:minha_estante/features/sign_up/sign_up_page.dart';
import 'package:minha_estante/features/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: defaultTheme,
      initialRoute: NamedRoute.splash,

      routes: {
        NamedRoute.initial:(context) => const OnboardingPage(),
        NamedRoute.splash:(context) => const SplashPage(),
        NamedRoute.signUp:(context) => const SignUpPage(),
        NamedRoute.signIn: (context) => const SignInPage(),
      },
    );
  }
}
