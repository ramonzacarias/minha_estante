import 'package:flutter/painting.dart';

class AppTextStyles {
  AppTextStyles._(); // Chamando as propriedades dentro do construtor AppTextStyle()

  static const TextStyle bigText40 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 40.0,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle mediumText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 30.0,
    fontWeight: FontWeight.w700,
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
