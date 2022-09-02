import 'package:delivery/src/pages/produtosPage.dart';
import 'package:flutter/material.dart';

class Buscar extends StatelessWidget {
  var dados;
  var txtbuscar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
        controller: txtbuscar,
        style: TextStyle(color: Colors.black, fontSize: 16),
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            suffixIcon: Material(
              child: IconButton(
                icon: Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProdutosPage(txtbuscar.text, ""),
                    ),
                  );
                },
              ),
            ),
            helperText: "Buscar Produtos"),
      ),
    );
  }
}
