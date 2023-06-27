import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/widgets/app_header.dart';
import 'package:minha_estante/commom/widgets/custom_bottom_sheet.dart';
import 'package:minha_estante/services/secure_storage.dart';

import 'package:minha_estante/commom/constants/routes.dart';

class ProfilePage extends StatelessWidget {
  final _secureStorage = const SecureStorage();

  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => WillPopScope (
    onWillPop: () async {
      Navigator.popAndPushNamed(context, NamedRoute.splash);
      return false;
    },
    child: Scaffold(
      body: Stack(
        children: [
          const AppHeader(title: "Perfil",),
          Positioned(
            top: 300,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 68,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      // Ação do botão
                      Navigator.popAndPushNamed(
                          // Vai para a página de Editar Perfil
                          context,
                          NamedRoute.profileEdit);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 30,
                          color: AppColors.grey,
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          'Editar Perfil',
                          style: AppTextStyles.mediumText18
                              .copyWith(color: AppColors.grey),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0, // Espaçamento vertical entre os botões
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      // Ação do botão "Teste"
                      Navigator.popAndPushNamed(context, NamedRoute.useTherms);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.security_update_warning_outlined,
                            size: 30, color: AppColors.grey),
                        SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          'Termo de Uso',
                          style: AppTextStyles.mediumText18
                              .copyWith(color: AppColors.grey),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0, // Espaçamento vertical entre os botões
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      // Ação do botão "Excluir a minha conta"
                      customModalBottomSheet(
                        context,
                        content:
                            "Clique em Apagar, se deseja realmente excluir sua conta!",
                        buttonText: 'Apagar.',
                        onPressed: () {
                          // Obtenha a instância do usuário atualmente autenticado
                          User? user = FirebaseAuth.instance.currentUser;

                          if (user != null) {
                            // Exclua o usuário autenticado
                            user.delete().then((_) {
                              // O usuário foi excluído com sucesso, redireciona para a tela inicial
                              Navigator.popAndPushNamed(
                                context,
                                NamedRoute.initial,
                              );
                            }).catchError((error) {
                              // Erro ao excluir o usuário, exibe uma mensagem de erro
                              print('Erro ao excluir o usuário: $error');
                            });
                          }
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline,
                            size: 30, color: AppColors.grey),
                        SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          'Excluir a minha conta',
                          style: AppTextStyles.mediumText18
                              .copyWith(color: AppColors.grey),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0, // Espaçamento vertical entre os botões
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      // Nesse caso, diferente de excluir a conta, ele deleta a 'sessão' de acesso do usuário
                      _secureStorage.deleteOne(key: "CURRENT_USER").then(
                            (_) => Navigator.popAndPushNamed(
                              context,
                              NamedRoute.initial,
                            ),
                          );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app_outlined,
                            size: 30, color: AppColors.grey),
                        SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          'Sair',
                          style: AppTextStyles.mediumText18
                              .copyWith(color: AppColors.grey),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    )
  );
}
