
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class CustomTextFormField extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  final String? labelText;
  final String? hintText;
  final TextCapitalization? textCapitalization;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextInputAction? textInputAction;

  const CustomTextFormField({
    Key? key,
    this.padding,
    this.labelText,
    this.hintText,
    this.textCapitalization,
    this.controller,
    this.keyboardType,
    this.maxLength,
    this.textInputAction,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  // Desenha um retângulo arredondado ao redor do contêiner
  final defaultBorder = const OutlineInputBorder(
    // criando um variavél para otimizar a chamada dentro do decoration
    borderSide: BorderSide(
      color: AppColors.greenLightTwo,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 12.0,
          ),
      child: TextFormField(
        textInputAction:
            widget.textInputAction, // Alterar o botão de ação no teclado
        maxLength: widget.maxLength, // Adiciona limite de character no campo
        keyboardType: widget
            .keyboardType, // Exibe o tipo de teclado para o tipo que será digitado no campo
        controller: widget.controller,
        textCapitalization: widget.textCapitalization ??
            TextCapitalization.none, // Torna a primeira letra maiscula
        decoration: InputDecoration(
          hintText: widget.hintText,
          floatingLabelBehavior: FloatingLabelBehavior
              .always, // Permite que o labelText sempre fique no top da borda
          labelText: widget.labelText?.toUpperCase(),
          labelStyle:
              AppTextStyles.inputLabelText.copyWith(color: AppColors.grey),
          focusedBorder: defaultBorder,
          errorBorder: defaultBorder.copyWith(
            borderSide: const BorderSide(color: AppColors.red),
          ),
          focusedErrorBorder: defaultBorder
            ..copyWith(
              borderSide: const BorderSide(color: AppColors.red),
            ),
          enabledBorder: defaultBorder,
          disabledBorder: defaultBorder,
        ),
      ),
    );
  }
}