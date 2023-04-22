import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/widgets/custom_login_text_field.dart';
import 'package:minha_estante/commom/widgets/custom_password_field.dart';
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
        const SizedBox(height: 123.0),
        Text('Bem-vindo!',
        textAlign: TextAlign.center,
        style: AppTextStyles.bigText40.copyWith(
          color: AppColors.greenOne
          ),
        ),
        const SizedBox(height: 52.0),
        Expanded(child: Image.asset(
          'assets/images/livro_login.png',
          width: 264.0,
          height: 180.0,
        )),
        const SizedBox(height: 75.0),
        Form(
          child: 
            Column(
              children: const[
                CustomTextField(
                  labelText: 'Email',
                  hintText: 'your@email.com',
                ),
                PasswordCustomField(
                  labelText: 'Senha',
                  hintText: '********',
                )
              ],
            )    
        ),
        Padding(
            padding: const EdgeInsets.only(
              left: 35.0,
              right: 35.0,
              top: 32.0,
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
                  color: AppColors.greenOne,
                ),
              ),
            ],
        ),
        const SizedBox(height: 32.0)
      ]),
    );
  }
}