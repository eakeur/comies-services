import 'package:comies/core.dart';
import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text('Bem vindo(a) ao Comies!', style: title, textAlign: TextAlign.left),
          ),
          Text('Agora você pode ajudar seu negócio a crescer com foco em seu cliente e na praticidade.', softWrap: true, textAlign: TextAlign.left)
        ]
      ),
    );
  }
}