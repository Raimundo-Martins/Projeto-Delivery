import 'package:delivery/src/config/config.dart';
import 'package:flutter/material.dart';

class CardCategorias extends StatelessWidget {
  final String nome;
  final String imagem;
  final String totalProdutos;

  CardCategorias({this.nome, this.imagem, this.totalProdutos});

  var configSite = Configuracoes.url_site;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: <Widget>[
              Container(
                child:
                    Image.network(configSite + "images/categorias/" + imagem),
                height: 65,
                width: 65,
              ),
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    nome,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "$totalProdutos Produtos",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
