// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minha_estante/commom/utils/uppercase_text_formatter.dart';
import 'package:minha_estante/commom/widgets/password_form_field.dart';

import '../../commom/constants/app_colors.dart';
import '../../commom/constants/app_text_styles.dart';
import '../../commom/widgets/custom_text_form_field.dart';
import '../../commom/widgets/multi_text_button.dart';
import '../../commom/widgets/primary_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // physics cria um efeito ao tentar rolar a página quando ela estiver no limite
        physics: const ClampingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          const SizedBox(height: 25.0),
          Text(
            'Crie Sua Conta',
            textAlign: TextAlign.center,
            style: AppTextStyles.bigText.copyWith(
              color: AppColors.greenOne,
            ),
          ),
          const SizedBox(height: 12.0),
          Image.asset(
            'assets/images/sign_up_image.png',
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  labelText: "nome",
                  hintText: "Digite Seu Nome Completo",
                  inputFormatters: [
                    UpperCaseTextInputFormatter(),
                  ],
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Esse campo não pode ser vazio";
                    }
                    return null;
                  },
                ),
                const CustomTextFormField(
                  labelText: "e-mail",
                  hintText: "seuemail@email.com",
                ),
                const PasswordFormField(
                  labelText: "senha",
                  hintText: "********",
                ),
                const PasswordFormField(
                  labelText: "confirme sua senha",
                  hintText: "********",
                ),
              ],
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
              text: 'Criar Conta',
              onPressed: () {
                final valid = _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  log("Continuar Lógica de Login");
                } else {
                  log("Erro ao logar");
                }
              },
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
                  color: AppColors.greenOne,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}