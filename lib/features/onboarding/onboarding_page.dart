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
      body: Align(
        child: Column(
          children: [
            const SizedBox(height: 48.0),
            Expanded(
              flex: 2,
              child: Image.asset(
                'assets/images/people.png',
              ),
            ),
            Text(
              'Gerencie Sua Biblioteca',
              style: AppTextStyles.bigText.copyWith(
                color: AppColors.greenLightTwo,
              ),
            ),
            Text(
              'De Leitura',
              style: AppTextStyles.bigText.copyWith(
                color: AppColors.greenLightTwo,
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
                    color: AppColors.greenLightTwo,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0)
          ],
        ),
      ),
    );
  }
}
