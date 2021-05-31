import 'package:comies/components/buttons/main-button.dart';
import 'package:comies/components/menu.comp.dart';
import 'package:comies/main.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  Home createState() => Home();
}

class Home extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MainButton(label: 'Ver produtos', onTap: () => Navigator.pushNamed(context, '/products'))
      ),
    );
  }
}
