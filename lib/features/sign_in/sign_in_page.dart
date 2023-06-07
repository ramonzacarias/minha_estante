import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minha_estante/commom/widgets/custom_bottom_sheet.dart';
import 'package:minha_estante/features/sign_in/sign_in_contoller.dart';
import 'package:minha_estante/features/sign_in/sign_in_state.dart';
import 'package:minha_estante/locator.dart';
import 'package:minha_estante/services/firebase_auth_service.dart';

import '../../commom/constants/app_colors.dart';
import '../../commom/constants/app_text_styles.dart';
import '../../commom/constants/routes.dart';
import '../../commom/utils/validator.dart';
import '../../commom/widgets/custom_circular_progress_indicator.dart';
import '../../commom/widgets/custom_text_form_field.dart';
import '../../commom/widgets/multi_text_button.dart';
import '../../commom/widgets/password_form_field.dart';
import '../../commom/widgets/primary_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _controller = locator.get<SignInController>();

  final _recoverPwd = FirebaseAuthService();

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
          Navigator.pushReplacementNamed(
            context,
            NamedRoute.home,
          );
        }

        if (_controller.state is SignInStateError) {
          Navigator.pop(context);
          customModalBottomSheet(
            context,
            content: "Seu usuário ou senha estão incorretos!",
            buttonText: "Tentar novamente",
          );
        }
      },
    );
  }

  void _popUpRecoverPwd(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 20.0),
          Text(
            'Bem-vindo!',
            textAlign: TextAlign.center,
            style: AppTextStyles.bigText40.copyWith(
              color: AppColors.greenOne,
            ),
          ),
          const SizedBox(height: 30.0),
          Image.asset(
            'assets/images/sign_in_image.png',
            width: 264.0,
            height: 180,
          ),
          const SizedBox(height: 20.0),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _emailController,
                  labelText: "e-mail",
                  hintText: "Digite seu email",
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
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    final email = _emailController.text.trim();
                    if (email.isEmpty) {
                      _popUpRecoverPwd(context, 'Erro',
                          'Por favor, informe um email para recuperar a senha');
                      return;
                    } else {
                      try {
                        await _recoverPwd.recoverPwd(email: email);
                        _popUpRecoverPwd(context, 'Sucesso',
                            'Email de recuperação de senha enviado com sucesso.');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          _popUpRecoverPwd(
                              context, 'Erro', 'Email não cadastrado.');
                        } else if (e.code == 'invalid-email') {
                          _popUpRecoverPwd(context, 'Erro',
                              'Por favor, informe um email válido para recuperar a senha.');
                        } else {
                          _popUpRecoverPwd(context, 'Erro',
                              'Ocorreu um erro ao enviar o email de recuperação.');
                        }
                      } catch (e) {
                        _popUpRecoverPwd(context, 'Erro',
                            'Ocorreu um erro ao enviar o email de recuperação.');
                      }
                    }
                  },
                  child: Text(
                    'Esqueceu sua senha?',
                    style: AppTextStyles.inputHintText.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
              right: 32.0,
              top: 25.0,
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
                  log("Erro ao logar");
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
                'Criar conta.',
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
