import 'package:flutter/material.dart';
import 'package:minha_estante/locator.dart';

import 'app.dart';

void main() {
  setupDependencies(); // Fazendo a chamada para a criação das dependencias
  runApp(const App());
}
