import 'package:flutter/material.dart';
import 'package:baby_one/View/LoginView/login.dart';

void main(){runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My Baby',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(36, 141, 248, 1),
      ),
      home: Login(),
    );
  }
}
