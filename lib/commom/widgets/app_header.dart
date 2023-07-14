import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/constants/routes.dart';

class AppHeader extends StatefulWidget {
  final String? title;
  final String? userName;
  final String? email;
  const AppHeader({
    super.key,
    this.title,
    this.userName,
    this.email,
  });

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppColors.greenGradient,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(500, 30),
                bottomRight: Radius.elliptical(500, 30),
              ),
            ),
            height: 287,
          ),
        ),
        Positioned(
          left: 20,
          right: 0,
          top: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () =>
                    Navigator.popAndPushNamed(context, NamedRoute.splash),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 25.0,
                  color: AppColors.white,
                ),
              ),
              Expanded(
                child: Text(
                  widget.title!,
                  style: AppTextStyles.bigText.copyWith(color: AppColors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 40.0,
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 200,
          child: Text(
            'Olá, ${widget.userName}!', // Exibindo o nome do usuário na tela
            style: AppTextStyles.mediumText16.copyWith(color: AppColors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 220,
          child: Text(
            '${widget.email}!', // Exibindo o nome do usuário na tela
            style: AppTextStyles.smallText.copyWith(color: AppColors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ]),
    );
  }
}
