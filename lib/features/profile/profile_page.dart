import 'package:flutter/material.dart';
import 'package:minha_estante/commom/widgets/CustomListOption.dart';
import 'package:minha_estante/commom/widgets/app_header.dart';
import 'package:minha_estante/features/profile/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController _profileController = const ProfileController();

  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          _profileController.navigateToSplash(context);
          return false;
        },
        child: Scaffold(
          body: Stack(
            children: [
              const AppHeader(
                title: "Perfil",
              ),
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
                    CustomListOption(
                      icon: Icons.edit_outlined,
                      opcao: 'Editar Perfil',
                      onTap: () =>
                          _profileController.navigateToProfileEdit(context),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    CustomListOption(
                      icon: Icons.security_update_warning_outlined,
                      opcao: 'Termo de Uso',
                      onTap: () =>
                          _profileController.navigateToTermsOfUse(context),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    CustomListOption(
                      icon: Icons.delete_outline,
                      opcao: 'Excluir a minha conta',
                      onTap: () =>
                          _profileController.showDeleteAccountDialog(context),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    CustomListOption(
                      icon: Icons.exit_to_app_outlined,
                      opcao: 'Sair',
                      onTap: () => _profileController.toDoLogout(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
