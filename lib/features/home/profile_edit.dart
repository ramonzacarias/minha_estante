import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';

import '../../commom/constants/routes.dart';
import '../../commom/utils/validator.dart';
import '../../commom/widgets/custom_text_form_field.dart';
import '../../commom/widgets/password_form_field.dart';
import '../../locator.dart';
import '../sign_in/sign_in_contoller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  //inal _controller = locator.get<SignInController>();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(9.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          size: 30,
                          color: AppColors.graffite,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Edite seu Perfil!',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bigText40.copyWith(
                      color: AppColors.greenOne,
                    ),
                  ),
              ],
            )
          ),
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
                  //validator: Validator.validateName(),
                ),
                PasswordFormField(
                  controller: _passwordController,
                  labelText: "senha atual",
                  hintText: "*********",
                  validator: Validator.validatePassword,
                ),
                PasswordFormField(
                  controller: _passwordController,
                  labelText: "nova senha",
                  hintText: "*********",
                  validator: Validator.validatePassword,
                ),
                PasswordFormField(
                  controller: _passwordController,
                  labelText: "confirmar senha",
                  hintText: "*********",
                  validator: Validator.validatePassword,
                ),
              ],
            ),
          ),
        ],
      ),
    );      
  }
}