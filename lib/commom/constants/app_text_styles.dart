import 'package:flutter/painting.dart';

class AppTextStyles {
  AppTextStyles._(); // Chamando as propriedades dentro do construtor AppTextStyle()

  static const TextStyle bigText40 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 40.0,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle bigText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 25.0,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle mediumText18 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle smallText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );
}
