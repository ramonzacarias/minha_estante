import 'dart:developer';
import 'package:flutter/material.dart';

import '../../commom/constants/app_colors.dart';
import '../../commom/constants/app_text_styles.dart';
import '../../commom/widgets/multi_text_button.dart';
import '../../commom/widgets/primary_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // physics cria um efeito ao tentar rolar a página quando ela estiver no limite
        physics: const ClampingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          Text(
            'Gerencie Sua Biblioteca',
            textAlign: TextAlign.center,
            style: AppTextStyles.bigText.copyWith(
              color: AppColors.greenLightTwo,
            ),
          ),
          Text(
            'De Leitura',
            textAlign: TextAlign.center,
            style: AppTextStyles.bigText.copyWith(
              color: AppColors.greenLightTwo,
            ),
          ),
          Image.asset(
            'assets/images/sign_up_image.png',
          ),
          Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "NOME",
                    border: OutlineInputBorder(),
                  ),
                )
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
              right: 32.0,
              top: 24.0,
              bottom: 4.0,
            ),
            child: PrimaryButton(
              text: 'Criar Conta',
              onPressed: () => log('tap'),
            ),
          ),
          MultiTextButton(
            onPressed: () => log('tap'),
            children: [
              Text(
                'Já Tem Conta? ',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.grey,
                ),
              ),
              Text(
                'Fazer Login',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.greenLightTwo,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}