// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/widgets/custom_text_form_field.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController? controller;
  final EdgeInsetsGeometry? padding;
  final String? hintText;
  final String? labelText;
  final FormFieldValidator<String>? validator;
  final String? helpText;

  const PasswordFormField({
    Key? key,
    this.controller,
    this.padding,
    this.hintText,
    this.labelText,
    this.validator,
    this.helpText,
  }) : super(key: key);

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {

  bool isHidden = true; // Variavel para definir o valor como sendo true

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      helpText: widget.helpText,
      validator: widget.validator,
      obscureText: isHidden, // Oculta o  texto digitado na senha
      controller: widget.controller,
      padding: widget.padding,
      hintText: widget.hintText,
      labelText: widget.labelText,
      suffixIcon: InkWell( // Utilizando o suffixIcon para criar o icone no campo senha
        borderRadius: BorderRadius.circular(23.0), // Adiciona o efeito de sombra ao clicar no icone
        onTap: () {
          log("pressed"); 
          setState(() { // Reconstroir o widget
            isHidden = !isHidden; // Inverter o estado da varivél, assim alterando a visibilidade do texto
          });
        },
        child: Icon(
          isHidden ? Icons.visibility : Icons.visibility_off, // Selecionando o icon com base no status da variavel
          color: AppColors.greenTwo,
          ),
      ),
    );
  }
}
