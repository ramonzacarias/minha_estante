import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/widgets/custom_login_text_field.dart';
import 'package:minha_estante/commom/widgets/primary_button.dart';
import '../../commom/widgets/multi_text_button.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.iceWhite,
      body: ListView(
        children: [
        const SizedBox(height: 64.0),
        Text('Bem-vindo!',
        textAlign: TextAlign.center,
        style: AppTextStyles.bigText40.copyWith(
          color: AppColors.greenLightTwo
        ),
        ),
        Expanded(child: Image.asset(
          'assets/images/livro_login.png',
          width: 264.0,
          height: 180.0,
        )),
        Form(
          child: 
            Column(
              children: const[
                CustomTextField(
                  labelText: 'Email',
                  hintText: 'your@email.com',
                ),
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
              text: 'Entrar',
              onPressed: () => log('tap'),
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
      ]),
    );
  }
}