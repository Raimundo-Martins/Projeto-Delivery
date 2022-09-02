import 'dart:convert';

import 'package:delivery/src/config/config.dart';
import 'package:delivery/src/tabs/tabs.dart';
import 'package:flutter/material.dart';

import '../componentes/botao.dart';
import 'loginPage.dart';

import 'package:http/http.dart' as http;

class CadastroPage extends StatefulWidget {
  var _id;

  CadastroPage(id) {
    this._id = id;
  }

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  bool _toggleVisibility = true;

  String _email;
  String _senha;

  var nometxt, cpftxt, telefonetxt, emailtxt, senhatxt;

  var dados;
  var nome, cpf, telefone, email, senha;
  var caminhoImg = "assets/imagens/cadastro.png";
  var textBtn = "Inserir";

  GlobalKey<FormState> _formKey = GlobalKey();

  var config = Configuracoes.url;
  var configSite = Configuracoes.url_site;

  Widget _nometxt() {
    return TextFormField(
      controller: nometxt,
      decoration: InputDecoration(
        hintText: "Nome",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      onSaved: (String nome) {},
      validator: (String username) {
        String errorMessage;
        if (username.isEmpty) {
          errorMessage = "O nome é requerido";
        }
        // if(username.length > 8 ){
        //   errorMessage = "Your username is too short";
        // }
        return errorMessage;
      },
    );
  }

  Widget _cpftxt() {
    return TextFormField(
      controller: cpftxt,
      decoration: InputDecoration(
        hintText: "CPF",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      onSaved: (String cpf) {},
      validator: (String userCpf) {
        String errorMessage;
        if (userCpf.isEmpty) {
          errorMessage = "O cpf é requerido";
        }
        // if(username.length > 8 ){
        //   errorMessage = "Your username is too short";
        // }
        return errorMessage;
      },
    );
  }

  Widget _telefonetxt() {
    return TextFormField(
      controller: telefonetxt,
      decoration: InputDecoration(
        hintText: "Telefone",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      onSaved: (String telefone) {},
      validator: (String userTelefone) {
        String errorMessage;
        if (userTelefone.isEmpty) {
          errorMessage = "O cpf é requerido";
        }
        // if(username.length > 8 ){
        //   errorMessage = "Your username is too short";
        // }
        return errorMessage;
      },
    );
  }

  Widget _emailtxt() {
    return TextFormField(
      controller: emailtxt,
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      onSaved: (String email) {
        _email = email;
      },
      validator: (String email) {
        String errorMessage;
        if (!email.contains("@")) {
          errorMessage = "Seu email está incorreto";
        }
        if (email.isEmpty) {
          errorMessage = "O campo email é requerido";
        }

        return errorMessage;
      },
    );
  }

  Widget _senhatxt() {
    return TextFormField(
      controller: senhatxt,
      decoration: InputDecoration(
        hintText: "Senha",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _toggleVisibility = !_toggleVisibility;
            });
          },
          icon: _toggleVisibility
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
        ),
      ),
      obscureText: _toggleVisibility,
      onSaved: (String password) {
        _senha = password;
      },
      validator: (String password) {
        String errorMessage;

        if (password.isEmpty) {
          errorMessage = "O campo senha é requerido";
        }
        return errorMessage;
      },
    );
  }

  void _inserir() async {
    var url = config + "usuarios/inserir.php";
    var response = await http.post(url, body: {
      "id": widget._id,
      "nome": nometxt.text,
      "cpf": cpftxt.text,
      "telefone": telefonetxt.text,
      "email": emailtxt.text,
      "senha": senhatxt.text
    });

    final map = json.decode(response.body);
    final res = map['message'];
    mensagem(res);
  }

  mensagem(res) {
    var alert = new AlertDialog(
      title: new Text('Inserir Dados'),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[new Text(res)],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: new Text('OK'),
        )
      ],
    );
    showDialog(context: context, child: alert);

    if (res == "Inserido com Sucesso") {
      nometxt.text = "";
      cpftxt.text = "";
      telefonetxt.text = "";
      emailtxt.text = "";
      senhatxt.text = "";
    }
  }

  mensagemExclur() {
    var alert = new AlertDialog(
      title: new Text('Excluir Usuário'),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            new Text("Deseja realmente excluir esse usuário?")
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            excluirUsuario(widget._id);
            Navigator.of(context).pop();
          },
          child: new Text('SIM'),
        ),
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: new Text('NÃO'),
        )
      ],
    );
    showDialog(context: context, child: alert);
  }

  @override
  void initState() {
    super.initState();
    if (widget._id != '') {
      caminhoImg = "assets/imagens/cadastro.png";
      recuperarDado();
      textBtn = "Editar";
    }

    nometxt = new TextEditingController(text: nome);
    cpftxt = new TextEditingController(text: cpf);
    telefonetxt = new TextEditingController(text: telefone);
    emailtxt = new TextEditingController(text: email);
    senhatxt = new TextEditingController(text: senha);
  }

  recuperarDado() async {
    var response = await http.get(
        Uri.encodeFull(config + "usuarios/recuperarDados.php?id=${widget._id}"),
        headers: {"Accept": "application/json"});

    final map = jsonDecode(response.body);
    final itens = map["result"];

    setState(() {
      this.dados = itens;
      nome = dados[0]['nome'];
      cpf = dados[0]['cpf'];
      telefone = dados[0]['telefone'];
      email = dados[0]['email'];
      senha = dados[0]['senha'];

      nometxt = new TextEditingController(text: nome);
      cpftxt = new TextEditingController(text: cpf);
      telefonetxt = new TextEditingController(text: telefone);
      emailtxt = new TextEditingController(text: email);
      senhatxt = new TextEditingController(text: senha);
    });
  }

  excluirUsuario(id) {
    http.get(Uri.encodeFull(config + "usuarios/excluir.php?id=$id"),
        headers: {"Accept": "application/json"});

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => Tabs("", "", "")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.grey.shade100,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Image(
                    image: AssetImage(caminhoImg),
                    height: 120.0,
                    width: 120.0,
                  ),
                  onTap: () => mensagemExclur(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        _nometxt(),
                        SizedBox(
                          height: 15.0,
                        ),
                        _cpftxt(),
                        SizedBox(
                          height: 15.0,
                        ),
                        _telefonetxt(),
                        SizedBox(
                          height: 15.0,
                        ),
                        _emailtxt(),
                        SizedBox(
                          height: 15.0,
                        ),
                        _senhatxt(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  child: Button(btnText: textBtn),
                  onTap: () => _inserir(),
                ),
                Divider(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Já possui Cadastro?",
                      style: TextStyle(
                          color: Color(0xFFBDC2CB),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage()));
                      },
                      child: Text(
                        "Entrar".toUpperCase(),
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit(Function authenticate) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      print("Seu Email: $_email, sua senha: $_senha");
      authenticate(_email, _senha);
    }
  }
}
