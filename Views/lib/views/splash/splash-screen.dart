import 'package:comies/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(milliseconds: 600)).then((result) {
      Provider.of<ComiesProvider>(context, listen: false).loadNewSession(context);
    });

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: Text('COMIES'),
            ),
            Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
