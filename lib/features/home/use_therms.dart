import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/routes.dart';

import '../../commom/constants/app_colors.dart';
import '../../commom/constants/app_text_styles.dart';

class UseTherms extends StatelessWidget {
  const UseTherms({super.key});

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
                      'Termo de Uso',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.mediumText20.copyWith(
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 68,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      // Ação do botão "Teste"
                      Navigator.popAndPushNamed(
                        context, NamedRoute.splash
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_outlined, size: 30, color: AppColors.white,),
                      ],
                    ),
                  ),
                ),
              ]  
            ),
          ), 
        ]  
      ),
    );    
  }
}