import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minha_estante/firebase_options.dart';
import 'package:minha_estante/locator.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupDependencies(); // Fazendo a chamada para a criação das dependencias
  runApp(const App());
}
