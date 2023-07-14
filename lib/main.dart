import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minha_estante/firebase_options.dart';
import 'package:minha_estante/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configurar o suporte offline
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
      Settings(persistenceEnabled: true);

  setupDependencies(); // Fazendo a chamada para a criação das dependências
  runApp(const App());
}
