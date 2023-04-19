import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';

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
              style: AppTextStyles.mediumText.copyWith(
                color: AppColors.greenLightTwo,
              ),
            ),
            Text(
              'De Leitura',
              style: AppTextStyles.mediumText.copyWith(
                color: AppColors.greenLightTwo,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 35.00,
                vertical: 20.00,
              ),
              child: PrimaryButton(
                text: 'Vamos Começar!',
                onPressed: () {},
                ),
            ),
            Text(
              'Já Tem Uma Conta? Fazer Login',
              style: AppTextStyles.smallText.copyWith(
                color: AppColors.grey,
              ),
            ),
            const SizedBox(height: 30.0)
          ],
        ),
      ),
    );
  }
}

