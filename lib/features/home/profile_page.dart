import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/services/secure_storage.dart';

import '../../commom/constants/routes.dart';

class ProfilePage extends StatelessWidget {
  final _secureStorage = const SecureStorage();

  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.white, AppColors.iceWhite],
                ),
              ),
            ),
          ),
          Positioned.fill(
            left: 3,
            right: 2,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 150.0),
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: AppColors.greenTwo,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 68.0),
                    Text(
                      'Perfil',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bigText40.copyWith(
                        color: AppColors.iceWhite,
                         
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 68,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      // Ação do botão "Teste"
                    },
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined, size: 30, color: AppColors.grey,),
                        SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          'Editar Perfil',
                          style: AppTextStyles.mediumText18.copyWith(color: AppColors.grey),
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
                      Navigator.popAndPushNamed(
                        context, NamedRoute.useTherms
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.security_update_warning_outlined, size: 30, color: AppColors.grey),
                        SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          'Termo de Uso',
                          style: AppTextStyles.mediumText18.copyWith(color: AppColors.grey),
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
                    },
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, size: 30, color: AppColors.grey),
                        SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          'Excluir a minha conta',
                          style: AppTextStyles.mediumText18.copyWith(color: AppColors.grey),
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
                      _secureStorage.deleteOne(key: "CURRENT_USER").then(
                            (_) => Navigator.popAndPushNamed(
                              context,
                              NamedRoute.initial,
                            ),
                          );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app_outlined, size: 30, color: AppColors.grey),
                        SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          'Sair',
                          style: AppTextStyles.mediumText18.copyWith(color: AppColors.grey),
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
    );
  }
}