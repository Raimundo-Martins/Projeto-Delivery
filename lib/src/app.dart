import 'package:flutter/material.dart';

import '../src/tabs/tabs.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Delivery - RM",
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: Tabs('', '', ''),
    );
  }
}
