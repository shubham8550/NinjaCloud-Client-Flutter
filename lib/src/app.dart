import 'package:flutter/material.dart';
import 'package:ninjacloud/src/login.dart';


class app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.alphaBlend(Colors.indigo, Colors.white),
        resizeToAvoidBottomPadding: false,
        body: Login(),
      ),
    );
  }
}
