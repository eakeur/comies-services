import 'package:comies/core.dart';
import 'package:flutter/material.dart';

class ErrorWidget2 extends StatelessWidget {
  final String message;
  const ErrorWidget2({Key? key, this.message = 'Ops, nada foi encontrado'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [Image.asset(burguer), Text(message)],
    ));
  }
}
