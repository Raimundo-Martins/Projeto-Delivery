import 'package:delivery/src/pages/cadastroPage.dart';
import 'package:flutter/material.dart';

import '../pages/telaInicial.dart';
import '../pages/carrinhoPage.dart';
import '../pages/categoriasPage.dart';
import '../pages/produtosPage.dart';
import '../pages/loginPage.dart';

class Tabs extends StatefulWidget {
  var _id, _nome, _cpf;

  Tabs(id, nome, cpf) {
    this._id = id;
    this._nome = nome;
    this._cpf = cpf;
  }

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  var idUser, nomeUser, cpfUser;

  int abaAtual = 0;
  TelaInicial telaInicial;
  CarrinhoPage carrinho;
  ProdutosPage produtos;
  CategoriasPage categorias;

  List<Widget> pages;
  Widget pageAtual;

  @override
  void initState() {
    telaInicial = TelaInicial(widget._cpf);
    carrinho = CarrinhoPage();
    produtos = ProdutosPage("", "");
    categorias = CategoriasPage();

    pages = [telaInicial, carrinho, produtos, categorias];
    pageAtual = telaInicial;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    idUser = widget._id;
    nomeUser = widget._nome;
    cpfUser = widget._cpf;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            abaAtual == 0
                ? "Delivery - RM"
                : abaAtual == 1
                    ? "Carrinho"
                    : abaAtual == 2 ? "Produtos" : "Categorias",
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
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CadastroPage(idUser),
                    ),
                  );
                },
                leading: Icon(Icons.people),
                title: Text(
                  "Usuários",
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
        resizeToAvoidBottomPadding: false,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: abaAtual,
          onTap: (index) {
            setState(() {
              abaAtual = index;
              pageAtual = pages[index];
            });
          },
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), title: Text("Carrinho")),
            BottomNavigationBarItem(
                icon: Icon(Icons.photo_library), title: Text("Produtos")),
            BottomNavigationBarItem(
                icon: Icon(Icons.list), title: Text("Categorias")),
          ],
        ),
        body: pageAtual,
      ),
    );
  }
}
