import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';

import '../../commom/widgets/multi_text_button.dart';
import '../../commom/widgets/primary_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.iceWhite,
      body: Column(
        children: [
          const SizedBox(height: 48.0),
          Expanded(
            child: Image.asset(
              'assets/images/onboarding_image.png',
            ),
          ),
          Text(
            'Gerencie Sua Biblioteca',
            textAlign: TextAlign.center,
            style: AppTextStyles.bigText.copyWith(
              color: AppColors.greenOne,
            ),
          ),
          Text(
            'De Leitura',
            textAlign: TextAlign.center,
            style: AppTextStyles.bigText.copyWith(
              color: AppColors.greenOne,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
              right: 32.0,
              top: 24.0,
              bottom: 4.0,
            ),
            child: PrimaryButton(
              text: 'Fazer Login',
              onPressed: () {},
            ),
          ),
          MultiTextButton(
            onPressed: () => log('tap') ,
            children: [
              Text(
                'Não tem uma conta? ',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.grey,
                ),
              ),
              Text(
                'Criar Conta.',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.greenOne,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25.0)
        ],
      ),
    );
  }
}
