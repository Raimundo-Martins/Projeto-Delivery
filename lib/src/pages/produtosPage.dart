import 'package:flutter/material.dart';

import '../componentes/cardProduto.dart';
import 'loginPage.dart';

class ProdutosPage extends StatefulWidget {
  var _nome, _idCategoria;

  ProdutosPage(nome, idCategoria) {
    this._nome = nome;
    this._idCategoria = idCategoria;
  }

  @override
  State<ProdutosPage> createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  var nomeBuscar, idCategoria;

  @override
  Widget build(BuildContext context) {
    nomeBuscar = widget._nome;
    idCategoria = widget._idCategoria;

    return Scaffold(
      appBar: appBar(),
      body: ListView(
        padding: EdgeInsets.only(left: 20, top: 30, right: 20),
        children: <Widget>[
          Column(
            children: <Widget>[
              CardProduto(nomeBuscar, widget._idCategoria, 650.0),
            ],
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  appBar() {
    if (nomeBuscar != "" || idCategoria != "") {
      return AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Busca por $nomeBuscar",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage()));
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
          )
        ],
      );
    }
  }
}
