import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';

class CustomListOption extends StatelessWidget {
  final IconData icon;
  final String opcao;
  final VoidCallback onTap;

  const CustomListOption({
    required this.icon,
    required this.opcao,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: AppColors.grey,
            ),
            SizedBox(
              width: 12.0,
            ),
            Text(
              opcao,
              style: AppTextStyles.mediumText18.copyWith(color: AppColors.grey),
            )
          ],
        ),
      ),
    );
  }
}
