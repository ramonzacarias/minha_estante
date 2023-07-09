import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/constants/book_reading_status.dart';
import 'package:minha_estante/commom/widgets/CustomListOption.dart';
import 'package:minha_estante/commom/widgets/app_header.dart';
import 'package:minha_estante/commom/widgets/widget_border_divider.dart';
import 'package:minha_estante/features/profile/profile_controller.dart';
import 'package:minha_estante/services/user_library_service.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _profileController = const ProfileController();
  late UserLibraryService _userLibraryService; // Use o mesmo objeto UserLibraryService criado no initState
  int _booksReadCount = 0;
  int _booksToReadCount = 0;
  int _booksAbandonedCount = 0;
  int _booksBeingReadCount = 0;
  int _totalBooksCount = 0;

  @override
  void initState() {
    super.initState();
    _userLibraryService = UserLibraryService(); // Crie o objeto UserLibraryService aqui
    loadStatistics(); // Carregue as estatísticas ao iniciar a página
  }

  Future<void> loadStatistics() async {
    try {
      // Obtenha o ID do usuário atual
      String userId = await _userLibraryService.getUserId();

      // Carregue os valores das estatísticas
      _booksReadCount = await _userLibraryService.getBooksReadCount(userId);
      _booksToReadCount = await _userLibraryService.getBooksToReadCount(userId);
      _booksAbandonedCount = await _userLibraryService.getBooksAbandonedCount(userId);
      _booksBeingReadCount = await _userLibraryService.getBooksBeingReadCount(userId);
      _totalBooksCount = await _userLibraryService.getTotalBooksCount(userId);

      // Atualize o estado para refletir as alterações
      setState(() {});
    } catch (e) {
      // Lide com erros adequadamente
      print('Erro ao carregar as estatísticas: $e');
    }
  }

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
                          BookReadingStatus.lendo,
                          _booksBeingReadCount.toString(),
                        ),
                        buildRichText(
                          context,
                          BookReadingStatus.queroLer,
                          _booksToReadCount.toString(),
                        ),
                        buildRichText(
                          context,
                          BookReadingStatus.lido,
                          _booksReadCount.toString(),
                        ),
                        buildRichText(
                          context,
                          BookReadingStatus.abandonei,
                          _booksAbandonedCount.toString(),
                        ),
                        buildRichText(
                          context,
                          BookReadingStatus.todos,
                          _totalBooksCount.toString(),
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

  Widget buildRichText(BuildContext context, String label, String value) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: label + ": ",
            style: AppTextStyles.boldText.copyWith(
              color: AppColors.black,
            ),
          ),
          TextSpan(
            text: value,
            style: AppTextStyles.boldText.copyWith(
              color: AppColors.greenTwo,
            ),
          ),
        ],
      ),
    );
  }
}
