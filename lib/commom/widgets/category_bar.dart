import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';

class CategoryBar extends StatefulWidget {
  final List<String> categories;
  final int selectCategoryIndex;
  final ValueChanged<int> categorySelected;

  CategoryBar({
    required this.categorySelected, required this.selectCategoryIndex, required this.categories
  });

  @override
  State<CategoryBar> createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
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
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          final category = widget.categories[index];
          return GestureDetector(
            onTap: () => widget.categorySelected(index),
            child: Container(
              decoration: BoxDecoration(
                color: widget.selectCategoryIndex == index ? AppColors.otherGrey : Colors.transparent,
                borderRadius: BorderRadius.circular(24.0)
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Center(
                child: Text(category, style: TextStyle(
                  color: widget.selectCategoryIndex == index ? AppColors.white : AppColors.grey
                ),),
              ),
            ),
          );
        },
      ),
    );
  }
}