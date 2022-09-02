import 'package:delivery/src/config/config.dart';
import 'package:flutter/material.dart';

import '../componentes/botao.dart';
import 'cadastroPage.dart';
import '../tabs/tabs.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _toggleVisibility = true;

  var emailtxt = new TextEditingController();
  var senhatxt = new TextEditingController();

  var dados;
  var seguro = true;

  var config = Configuracoes.url;

  Widget _emailTextField() {
    return TextFormField(
      controller: emailtxt,
      decoration: InputDecoration(
        hintText: "Digite seu Email",
        hintStyle: TextStyle(color: Color(0xFFBDC2CB), fontSize: 18),
      ),
    );
  }

  Widget _senhaTextField() {
    return TextFormField(
      controller: senhatxt,
      decoration: InputDecoration(
        hintText: "Digite sua Senha",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18,
        ),
        suffixIcon: IconButton(
          icon: _toggleVisibility
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
          onPressed: () {
            setState(() {
              _toggleVisibility = !_toggleVisibility;
            });
          },
        ),
      ),
      obscureText: _toggleVisibility,
    );
  }

  void mensagemDadosIncorretos() {
    var alert = new AlertDialog(
      title: new Text('Dados Incorretos'),
      content: new Text('Usuário ou Senha Incorretos'),
    );
    showDialog(context: context, child: alert);
  }

  @override
  Widget build(BuildContext context) {
    Future<void> login(String usuario, String senha) async {
      var response = await http.get(
          Uri.encodeFull(
              config + "usuarios/login.php?usuario=$usuario&senha=$senha"),
          headers: {"Accept": "application/json"});

      var obj = json.decode(response.body);
      var msg = obj['message'];
      if (msg == 'Dados incorretos') {
        mensagemDadosIncorretos();
      } else {
        dados = obj['result'];
      }
    }

    verificarDados(String usuario, String senha) {
      if (dados[0]['usuario'] == usuario && dados[0]['senha'] == senha) {
        var route = new MaterialPageRoute(
          builder: (context) => new Tabs(
            dados[0]['id'],
            dados[0]['nome'],
            dados[0]['cpf'],
          ),
        );
        Navigator.of(context).push(route);
      } else {
        mensagemDadosIncorretos();
      }
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("assets/imagens/login.gif"),
              height: 140,
              width: 140,
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    _emailTextField(),
                    SizedBox(height: 20),
                    _senhaTextField()
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              child: Button(btnText: "Logar"),
              onTap: () {
                login(emailtxt.text, senhatxt.text);
                verificarDados(emailtxt.text, senhatxt.text);
              },
            ),
            Divider(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Não possui Cadastro?",
                  style: TextStyle(
                    color: Color(0xFFBDC2CB),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CadastroPage(""),
                    ));
                  },
                  child: Text(
                    "Cadastre-se".toUpperCase(),
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Recuperar Senha?",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
