// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/routes.dart';
import 'package:minha_estante/commom/utils/uppercase_text_formatter.dart';
import 'package:minha_estante/commom/utils/validator.dart';
import 'package:minha_estante/commom/widgets/custom_bottom_sheet.dart';
import 'package:minha_estante/commom/widgets/custom_circular_progress_indicator.dart';
import 'package:minha_estante/commom/widgets/password_form_field.dart';
import 'package:minha_estante/features/sign_up/sign_up_controller.dart';
import 'package:minha_estante/features/sign_up/sign_up_state.dart';
import 'package:minha_estante/locator.dart';

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
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordControlled = TextEditingController();
  final controller = locator.get<SignUpController>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
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
        Navigator.pushReplacementNamed(
          context,
          NamedRoute.home,
        );
      }
      if (controller.state is SignUpErrorState) {
        final error = controller.state as SignUpErrorState;
        Navigator.pop(context);
        customModalBottomSheet(
          context,
          content: error.message,
          buttonText: "Tente novamente",
        );
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
          const SizedBox(height: 43.0),
          Image.asset(
            'assets/images/sign_up_image.png',
            width: 264.0,
            height: 180,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _nameController,
                  labelText: "nome",
                  hintText: "Digite Seu Nome Completo",
                  inputFormatters: [
                    UpperCaseTextInputFormatter(),
                  ],
                  validator: Validator.validateName,
                ),
                CustomTextFormField(
                  controller: _emailController,
                  labelText: "e-mail",
                  hintText: "digiteseuemail@email.com",
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
                  controller.signUp(
                    name: _nameController.text,
                    email: _emailController.text,
                    password: _passwordControlled.text,
                  );
                } else {
                  log("Erro ao logar");
                }
              },
            ),
          ),
          MultiTextButton(
            onPressed: () => Navigator.popAndPushNamed(
              context,
              NamedRoute.signIn,
            ),
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
