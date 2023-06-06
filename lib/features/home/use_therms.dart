import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/routes.dart';

import '../../commom/constants/app_colors.dart';
import '../../commom/constants/app_text_styles.dart';

class UseTherms extends StatelessWidget {
  const UseTherms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.symmetric(horizontal: 13.0),
          child: InkWell(
            onTap: () {
              // Ação do botão redireciona para rota Splash
              //A rota Splash sempre direciona para Home
              Navigator.popAndPushNamed(context, NamedRoute.splash);
            },
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_outlined,
                  size: 30,
                  color: AppColors.iceWhite,
                ),
              ],
            ),
          ),
        ),
        toolbarHeight: 80.0,
        iconTheme: IconThemeData(
          color: AppColors.iceWhite
        ),
        title: Text(
          'Termo de Uso',
          style: AppTextStyles.mediumText20.copyWith(
            color: AppColors.iceWhite,
          ),
        ),
        backgroundColor: AppColors.greenTwo,
      ),
      //O Stack customiza o background para ter uma cor gradiente
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
          //Esse bloco de código faz print do texto na tela com um Scroll de movimento
          Center(
            child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    " 1.	Objeto do aplicativo: o aplicativo de gerenciamento de leitura tem como objetivo fornecer aos usuários uma plataforma para organizar e acompanhar seus hábitos de leitura.\n\n"
                    " 2.	Uso do aplicativo: o aplicativo é gratuito para uso pessoal. Os usuários podem criar uma conta, adicionar livros à sua lista de leitura, salvar seu progresso de leitura e avaliar os livros.\n\n"
                    " 3.	Responsabilidades do usuário: o usuário é responsável por manter suas informações de conta atualizadas e proteger sua senha de acesso. O usuário também concorda em não violar os direitos autorais dos livros ou conteúdos adicionados ao aplicativo.\n\n"
                    " 4.	Privacidade e segurança: o aplicativo respeita a privacidade dos usuários e não compartilha informações pessoais com terceiros. O aplicativo também utiliza medidas de segurança para proteger as informações dos usuários.\n\n"
                    " 5.	Disponibilidade e interrupções: o aplicativo se esforça para manter a disponibilidade contínua, mas não é responsável por interrupções causadas por problemas técnicos ou de manutenção.\n\n"
                    " 6.	Propriedade intelectual: todo o conteúdo do aplicativo, incluindo a marca, logotipo e design, são propriedade exclusiva do desenvolvedor do aplicativo.\n\n"
                    " 7.	Cancelamento da conta: o usuário pode cancelar sua conta a qualquer momento, e todas as informações e dados associados serão excluídos do sistema.\n\n"
                    " 8.	Alterações nos termos de uso: o desenvolvedor do aplicativo pode alterar os termos de uso a qualquer momento, e os usuários serão notificados sobre quaisquer alterações relevantes.\n\n"
                    " 9.	Rescisão do acesso: o desenvolvedor do aplicativo reserva-se o direito de rescindir o acesso de qualquer usuário que viole os termos de uso ou cause problemas ao sistema.\n\n"
                    " 10.	Lei aplicável: estes termos de uso serão regidos e interpretados de acordo com as leis do país onde o desenvolvedor do aplicativo está localizado.",
                    textAlign: TextAlign.left,
                    style: AppTextStyles.mediumText18,
                  ),
                )
              ],
            ),
          ),
          ) 
        ]  
      ),
    );    
  }
}