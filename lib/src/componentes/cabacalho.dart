import 'package:flutter/material.dart';

class Cabecalho extends StatelessWidget {
  final tituloStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final subTituloStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              "O que você deseja comer?",
              style: tituloStyle,
            ),
            Text(
              "Temos diversas opções.",
              style: subTituloStyle,
            ),
          ],
        ),
        Icon(Icons.notifications),
      ],
    );
  }
}
