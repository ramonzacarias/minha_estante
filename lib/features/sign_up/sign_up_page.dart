// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minha_estante/commom/utils/uppercase_text_formatter.dart';
import 'package:minha_estante/commom/utils/validator.dart';
import 'package:minha_estante/commom/widgets/custom_bottom_sheet.dart';
import 'package:minha_estante/commom/widgets/custom_circular_progress_indicator.dart';
import 'package:minha_estante/commom/widgets/password_form_field.dart';
import 'package:minha_estante/features/sign_up/sign_up_controller.dart';
import 'package:minha_estante/features/sign_up/sign_up_state.dart';

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
  final _passwordControlled = TextEditingController();
  final controller = SignUpController();

  @override
  void dispose() {
    _passwordControlled.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      // Recebe a informação da mudança de estado
      // Exibe o estado atual
      if (controller.state is SignUpLoadingState) {
        // Exibe o estado de loading
        showDialog(
          context: context,
          builder: (context) => const CustomCircularProgressIndicator(),
        );
      }
      // Exibe a tela de acesso ao sistema
      if (controller.state is SignUpSuccessState) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(
                child: Text("Nova Tela"),
              ),
            ),
          ),
        );
      }
      if (controller.state is SignUpErrorState) {
        Navigator.pop(context);
        customModalBottomSheet(context);
      }
    });
  }

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
                  validator: Validator.validateName,
                ),
                const CustomTextFormField(
                  labelText: "e-mail",
                  hintText: "seuemail@email.com",
                  validator: Validator.validateEmail,
                ),
                PasswordFormField(
                  controller: _passwordControlled,
                  labelText: "senha",
                  hintText: "********",
                  validator: Validator.validatePassword,
                  helpText:
                      "Deve ter pelo menos 8 caracteres, uma letra maiúscula, uma letra minúscula, um número e um caractere especial",
                ),
                PasswordFormField(
                  labelText: "confirme sua senha",
                  hintText: "********",
                  validator: (value) => Validator.validateConfirmPassword(
                      value, _passwordControlled.text),
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
                  controller.doSignUp();
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
