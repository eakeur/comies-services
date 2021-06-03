import 'dart:math';

import 'package:comies/components/buttons/main-button.dart';
import 'package:comies/core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  Home createState() => Home();
}

class Home extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Início', style: getPageTitle())),
      body: ListView(
        children: [
          Card(child: Container(width: 200, height: 200, child: Text(Random().nextDouble().toString()),)),
        ]
      )
      
      
    );
  }
}
