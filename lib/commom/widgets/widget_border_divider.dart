import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';

class widgetBorderDivider extends StatelessWidget {
  const widgetBorderDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30.0,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.otherGrey,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}