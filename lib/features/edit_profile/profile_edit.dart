import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/widgets/primary_button.dart';
import 'package:minha_estante/commom/constants/routes.dart';
import 'package:minha_estante/commom/utils/uppercase_text_formatter.dart';
import 'package:minha_estante/commom/utils/validator.dart';
import 'package:minha_estante/commom/widgets/custom_text_form_field.dart';
import 'package:minha_estante/commom/widgets/password_form_field.dart';
import 'package:minha_estante/locator.dart';
import 'package:minha_estante/features/sign_in/sign_in_controller.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _controller = locator.get<SignInController>();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  // Método do Firebase para envio de e-mail de confirmação
  Future<void> _sendPasswordResetEmail() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.sendEmailVerification(); // Confirmação da alteração da senha
    }
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          Navigator.popAndPushNamed(context, NamedRoute.splash);
          return false;
        },
        child: Scaffold(
          body: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.all(9.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Botão para voltar a página Home
                      InkWell(
                        onTap: () {
                          Navigator.popAndPushNamed(context, NamedRoute.splash);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_outlined,
                              size: 25,
                              color: AppColors.graffite,
                            ),
                            Expanded(
                              child: Text(
                                'Edite seu Perfil!',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.bigText.copyWith(
                                  color: AppColors.greenOne,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 20.0),
              Image.asset(
                'assets/images/livros.png',
                width: 264.0,
                height: 200.0,
              ),
              const SizedBox(height: 20.0),
              // Página que irá editar o perfil do usuário
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _nameController,
                      labelText: "nome",
                      hintText: "Edite seu nome aqui...",
                      inputFormatters: [
                        UpperCaseTextInputFormatter(),
                      ],
                      validator: Validator.validateName,
                    ),
                    PasswordFormField(
                      controller: _passwordController,
                      labelText: "nova senha",
                      hintText: "*********",
                      helpText:
                          "Deve ter pelo menos 8 caracteres, uma letra maiúscula, uma letra minúscula, um número e um caractere especial",
                      validator: Validator.validatePassword,
                    ),
                    PasswordFormField(
                      controller: _passwordConfirmController,
                      labelText: "confirmar senha",
                      hintText: "*********",
                      validator: (value) => Validator.validateConfirmPassword(
                          value, _passwordController.text),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 32.0,
                        right: 32.0,
                        top: 24.0,
                        bottom: 4.0,
                      ),
                      child: PrimaryButton(
                        text: 'Salvar Alterações',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Confere se as validações foram satisfeitas

                            if (_nameController.text.isNotEmpty) {
                              // Se a informação de nome não for vazia, atualize o Nome do Usuário

                              await _controller.updateUserName(
                                  "CURRENT_USER", _nameController.text);
                            }

                            if (_passwordController.text.isNotEmpty) {
                              // Se a informação de senha não for vazia, atualize a Senha do Usuário

                              await _controller.updatePassword(
                                  newPassword: _passwordController.text);
                              await _sendPasswordResetEmail();
                            }

                            // Mensagem de sucesso para as atualizações salvas
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.graffite,
                                content: Text(
                                  'Alterações salvas com sucesso!',
                                  style: AppTextStyles.smallText
                                      .copyWith(color: AppColors.darkGrey),
                                ),
                              ),
                            );
                          } else {
                            // Mensagem de insucesso caso haja algum problema
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.graffite,
                                content: Text(
                                  'Alterações não foram salvas por conta de um erro!',
                                  style: AppTextStyles.smallText
                                      .copyWith(color: AppColors.red),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
