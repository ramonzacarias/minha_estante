import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minha_estante/features/sign_in/sign_in_contoller.dart';
import 'package:minha_estante/features/sign_in/sign_in_state.dart';

import '../../commom/constants/app_colors.dart';
import '../../commom/constants/app_text_styles.dart';
import '../../commom/constants/routes.dart';
import '../../commom/utils/validator.dart';
import '../../commom/widgets/custom_bottom_sheet.dart';
import '../../commom/widgets/custom_circular_progress_indicator.dart';
import '../../commom/widgets/custom_text_form_field.dart';
import '../../commom/widgets/multi_text_button.dart';
import '../../commom/widgets/password_form_field.dart';
import '../../commom/widgets/primary_button.dart';
import '../../services/mock_auth_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _controller = SignInController(MockAuthService());

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () {
        if (_controller.state is SignInStateLoading) {
          showDialog(
            context: context,
            builder: (context) => const CustomCircularProgressIndicator(),
          );
        }
        if (_controller.state is SignInStateSuccess) {
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

        if (_controller.state is SignInStateError) {
          final error = _controller.state as SignInStateError;
          Navigator.pop(context);
          customModalBottomSheet(
            context,
            content: error.message,
            buttonText: "Tentar novamente",
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text(
            'Welcome Back!',
            textAlign: TextAlign.center,
            style: AppTextStyles.bigText.copyWith(
              color: AppColors.greenOne,
            ),
          ),
          Image.asset(
            'assets/images/sign_in_image.png',
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _emailController,
                  labelText: "e-mail",
                  hintText: "digiteseuemail@email.com",
                  validator: Validator.validateEmail,
                ),
                PasswordFormField(
                  controller: _passwordController,
                  labelText: "senha",
                  hintText: "*********",
                  validator: Validator.validatePassword,              
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
              right: 32.0,
              top: 16.0,
              bottom: 4.0,
            ),
            child: PrimaryButton(
              text: 'Entrar',
              onPressed: () {
                final valid = _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  _controller.signIn(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                } else {
                  log("erro ao logar");
                }
              },
            ),
          ),
          MultiTextButton(
            onPressed: () => Navigator.popAndPushNamed(
              context,
              NamedRoute.signUp,
            ),
            children: [
              Text(
                'Não tem uma conta? ',
                style: AppTextStyles.smallText.copyWith(
                  color: AppColors.grey,
                ),
              ),
              Text(
                'Criar conta',
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
