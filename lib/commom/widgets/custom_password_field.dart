
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minha_estante/commom/widgets/custom_login_text_field.dart';

class PasswordCustomField extends StatefulWidget {
  final EdgeInsetsGeometry? pedding;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  const PasswordCustomField({super.key, this.pedding, this.hintText, this.labelText, this.controller, this.keyboardType});

  @override
  State<PasswordCustomField> createState() => _PasswordCustomFieldState();
}

class _PasswordCustomFieldState extends State<PasswordCustomField> {

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      obscureText: isHidden,
      pedding: widget.pedding,
      labelText: widget.labelText,
      hintText: widget.hintText,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      suffixIcon: InkWell(
      borderRadius: BorderRadius.circular(18.0),
      onTap: () {  //Nesse local estou alterando o estado do "olho" no campo de senha
        log('tap');
        setState(() { //assim que eu clicar sobre ele, a função setState faz um reload no Widget build
          isHidden = !isHidden; //esse reload vai alterar o comportamento do campo isHidden para falso ou verdadeiro
        });
      },
      //abaixo uma condição ternária
      child: Icon(isHidden ? Icons.visibility : Icons.visibility_off)
      ),
    );
  }
}