import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';

class CategoryBar extends StatelessWidget {
  final List<String> categories = ['Tecnologia', 'Contos', 'Ficção Científica', 'Terror/Horror', 'Drama', 'Educação'];
  final int selectCategoryIndex;
  final void Function(int) categorySelected;

  CategoryBar({
    required this.categorySelected, required this.selectCategoryIndex
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.graffite),
        borderRadius: BorderRadius.circular(24.0)
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () => categorySelected(index),
            child: Container(
              decoration: BoxDecoration(
                color: selectCategoryIndex == index ? AppColors.grey : Colors.transparent,
                borderRadius: BorderRadius.circular(24.0)
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Center(
                child: Text(category, style: TextStyle(
                  color: selectCategoryIndex == index ? AppColors.white : AppColors.grey
                ),),
              ),
            ),
          );
        },
      ),
    );
  }
}