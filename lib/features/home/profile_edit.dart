import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 20.0),
          Text(
            'Edite seu Perfil!',
            textAlign: TextAlign.center,
            style: AppTextStyles.bigText40.copyWith(
              color: AppColors.greenOne,
            ),
          ),
          const SizedBox(height: 30.0),
          Image.asset(
              'assets/images/livros.png',
              width: 264.0,
              height: 195.0,
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );      
  }
}