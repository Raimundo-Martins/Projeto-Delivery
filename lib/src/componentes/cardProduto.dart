import 'package:delivery/src/config/config.dart';
import 'package:delivery/src/tabs/tabs.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class CardProduto extends StatefulWidget {
  var _nomeBusca, _idCategoria, _altura;

  CardProduto(nomeBusca, idCategoria, altura) {
    this._nomeBusca = nomeBusca;
    this._idCategoria = idCategoria;
    this._altura = altura;
  }
  @override
  State<CardProduto> createState() => _CardProdutoState();
}

class _CardProdutoState extends State<CardProduto> {
  var carregando = false;
  var cardText = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  var dados;
  var nome, imagem, valor;
  var buscar;

  var config = Configuracoes.url;
  var configSite = Configuracoes.url_site;

  @override
  void initState() {
    super.initState();
    _listarDados();
  }

  _listarDados() async {
    buscar = widget._nomeBusca;
    var response = await http.get(
        Uri.encodeFull(config +
            "produtos/listar.php?nome=${buscar}&idCategoria=${widget._idCategoria}"),
        headers: {"Accept": "application/json"});

    final map = json.decode(response.body);
    final itens = map["result"];
    if (map["result"] == 'Dados não encontrados!') {
      mensagem();
    } else {
      setState(() {
        carregando = true;
        this.dados = itens;
      });
    }
  }

  mensagem() {
    var alert = new AlertDialog(
      title: new Text('Listar Dados'),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[new Text('Produto não encontrado!')],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => Tabs('', '', ''),
            ),
          ),
          child: new Text('OK'),
        )
      ],
    );
    showDialog(context: context, child: alert);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Stack(
        children: <Widget>[
          Container(
            height: widget._altura,
            width: 340,
            child: !carregando
                ? LinearProgressIndicator()
                : new ListView.builder(
                    itemCount: this.dados != null ? this.dados.length : 0,
                    itemBuilder: (context, index) {
                      final item = this.dados[index];
                      return new Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              child: Image.network(
                                configSite +
                                    "images/produtos/" +
                                    item['imagem'],
                              ),
                            ),
                            Positioned(
                              left: 0,
                              bottom: 0,
                              width: 340,
                              height: 60,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [Colors.black, Colors.black12],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10,
                              bottom: 10,
                              right: 10,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        item['nome'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.star,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 16,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 16,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 16,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "5 - Avaliações",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        item['valor'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orangeAccent,
                                        ),
                                      ),
                                      Text(
                                        "Add",
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
