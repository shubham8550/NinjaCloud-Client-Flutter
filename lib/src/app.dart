import 'package:flutter/material.dart';
import 'package:ninjacloud/src/login.dart';


class app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.yellowAccent,
        resizeToAvoidBottomPadding: false,
        body: Login(),
      ),
    );
  }
}
