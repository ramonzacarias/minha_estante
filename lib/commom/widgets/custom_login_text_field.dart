import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  final EdgeInsetsGeometry? pedding;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool? obscureText;

  const CustomTextField({super.key, this.pedding, this.hintText, this.labelText, this.controller, this.keyboardType, this.suffixIcon, this.obscureText});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final defaultBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.greenLightTwo),
    borderRadius: BorderRadius.circular(8.0)
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.pedding ?? const EdgeInsets.symmetric(
        vertical: 12.0, 
        horizontal: 37.0
      ),
      child: TextFormField(
        obscureText: widget.obscureText ?? false,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon,
          hintText: widget.hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.labelText?.toUpperCase(),
          labelStyle: AppTextStyles.inputLabelText.copyWith(
            color: AppColors.grey
          ),
          border: defaultBorder,
          enabledBorder: defaultBorder,
          focusedBorder: defaultBorder,
          errorBorder: defaultBorder.copyWith(
            borderSide: const BorderSide(
              color: Colors.red
            )
          ),
          focusedErrorBorder: defaultBorder.copyWith(
            borderSide: const BorderSide(
              color: Colors.red
            )
          )
        ),
      ),
    );
  }
}