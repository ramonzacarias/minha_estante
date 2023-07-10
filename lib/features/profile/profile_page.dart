import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/widgets/CustomListOption.dart';
import 'package:minha_estante/commom/widgets/app_header.dart';
import 'package:minha_estante/commom/widgets/widget_border_divider.dart';
import 'package:minha_estante/features/profile/profile_controller.dart';
import 'package:minha_estante/features/profile/profile_state.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ProfileState<ProfilePage> {
  final ProfileController _profileController = ProfileController();

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
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildRichText(
                          context,
                          "Lendo",
                          booksBeingReadCount,
                        ),
                        buildRichText(
                          context,
                          "Quero Ler",
                          booksToReadCount,
                        ),
                        buildRichText(
                          context,
                          "Lido",
                          booksReadCount,
                        ),
                        buildRichText(
                          context,
                          "Abandonei",
                          booksAbandonedCount,
                        ),
                        buildRichText(
                          context,
                          "Todos",
                          totalBooksCount,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    widgetBorderDivider(),
                    SizedBox(
                      height: 35,
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

  Widget buildRichText(BuildContext context, String label, int value) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: label + ": ",
            style:
                AppTextStyles.boldText.copyWith(color: AppColors.black),
          ),
          TextSpan(
            text: value < 0 ? "" : value.toString(),
            style:
                AppTextStyles.boldText.copyWith(color: AppColors.green),
          ),
        ],
      ),
    );
  }
}
