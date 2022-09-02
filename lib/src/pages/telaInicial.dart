import 'package:flutter/material.dart';

import '../componentes/cabacalho.dart';
import '../componentes/categoria.dart';
import '../componentes/buscar.dart';
import '../componentes/cardProduto.dart';

class TelaInicial extends StatefulWidget {
  var _cpf;

  TelaInicial(cpf) {
    this._cpf = cpf;
  }
  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(left: 20, top: 30, right: 20),
        children: <Widget>[
          Cabecalho(),
          AreaCategoria(),
          Buscar(),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Produtos Mais Vendidos",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Ver Todos",
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Column(
            children: <Widget>[
              CardProduto('', '', 400.0),
            ],
          )
        ],
      ),
    );
  }
}
