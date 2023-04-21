import 'package:flutter/material.dart';
import 'package:minha_estante/commom/themes/default_theme.dart';
import 'package:minha_estante/features/sign_up/sign_up_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: defaultTheme,
      home: const SignUpPage()
    );
  }
}
