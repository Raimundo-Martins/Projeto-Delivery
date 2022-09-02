import 'package:delivery/src/componentes/cardPageCategoria.dart';
import 'package:flutter/material.dart';

class CategoriasPage extends StatefulWidget {
  @override
  State<CategoriasPage> createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(left: 20, top: 30, right: 20),
        children: <Widget>[
          Column(
            children: <Widget>[
              CardPageCategoria(),
            ],
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
