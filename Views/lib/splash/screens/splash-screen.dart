import 'package:comies/core.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(milliseconds: 1200)).then((result) {
      getProvider(context).loadNewSession(context);
    });

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: Text('Comies', style: getPageTitle(size: 42)),
            )
          ],
        ),
      ),
    );
  }
}
