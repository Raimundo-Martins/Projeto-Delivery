import 'package:delivery/src/config/config.dart';
import 'package:delivery/src/pages/produtosPage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'cardCategoria.dart';

class AreaCategoria extends StatefulWidget {
  @override
  State<AreaCategoria> createState() => _AreaCategoriaState();
}

class _AreaCategoriaState extends State<AreaCategoria> {
  var carregando = false;
  var dados;

  var config = Configuracoes.url;

  _listarDados() async {
    var url = config + "produtos/listar-categorias.php";
    final response = await http.get(Uri.parse(url));
    final map = jsonDecode(response.body);
    final itens = map["result"];

    setState(() {
      carregando = true;
      this.dados = itens;
    });
  }

  @override
  void initState() {
    super.initState();
    _listarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 80,
      child: !carregando
          ? LinearProgressIndicator()
          : ListView.builder(
              itemBuilder: (context, index) {
                final item = this.dados[index];
                return GestureDetector(
                  child: CardCategorias(
                    nome: item['nome'],
                    imagem: item['imagem'],
                    totalProdutos: item['produtos'],
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProdutosPage("", item["id"]),
                    ),
                  ),
                );
              },
              itemCount: this.dados != null ? this.dados.length : 0,
              scrollDirection: Axis.horizontal,
            ),
    );
  }
}
