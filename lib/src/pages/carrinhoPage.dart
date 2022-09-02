import 'package:delivery/src/pages/loginPage.dart';
import 'package:flutter/material.dart';

import '../componentes/cardCarrinho.dart';

class CarrinhoPage extends StatefulWidget {
  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          CardCarrinho(),
          CardCarrinho(),
          CardCarrinho(),
        ],
      ),
      bottomNavigationBar: _totalContainer(context),
    );
  }
}

Widget _totalContainer(BuildContext context) {
  return Container(
    height: 200,
    padding: EdgeInsets.only(left: 10, right: 10),
    margin: EdgeInsets.only(top: 30),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              "SubTotal",
              style: TextStyle(
                color: Color(0xFF9BA7C6),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "23,00",
              style: TextStyle(
                color: Color(0xFF6C6D6D),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              "Taxa de Entrega",
              style: TextStyle(
                color: Color(0xFF9BA7C6),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "2,00",
              style: TextStyle(
                color: Color(0xFF6C6D6D),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Divider(height: 2),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              "Total",
              style: TextStyle(
                color: Color(0xFF9BA7C6),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "25,00",
              style: TextStyle(
                color: Color(0xFF6C6D6D),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "Finalizar Pagamento",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
