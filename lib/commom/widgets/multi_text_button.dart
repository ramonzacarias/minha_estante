// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MultiTextButton extends StatelessWidget {
  final List<Text> children;
  final VoidCallback onPressed;

// Construtor da classe MultiTextButton
  const MultiTextButton({
    Key? key,
    required this.children,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:
          onPressed, // Atribui a função de retorno de chamada ao onPressed do TextButton
      child: Row(
        mainAxisSize: MainAxisSize.min, // Define o tamanho principal do Row como mínimo, ocupando apenas o espaço necessário
        mainAxisAlignment: MainAxisAlignment.center, // Alinha os filhos do Row ao centro horizontalmente
        children:
            children, // Adiciona os widgets Text fornecidos à lista de filhos do Row
      ),
    );
  }
}
