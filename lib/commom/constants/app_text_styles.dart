import 'package:flutter/painting.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';

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

  static const TextStyle mediumText20 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle smallText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle inputLabelText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle inputText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );

 static const TextStyle inputHintText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle categoriesText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16.0,
    fontWeight: FontWeight.w800,
    color: AppColors.otherGrey
  );
}
