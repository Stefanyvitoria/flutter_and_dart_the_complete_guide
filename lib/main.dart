import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/App.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal expenses - App 04',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: _myTheme(),
    );
  }
}

ThemeData _myTheme() {
  return ThemeData(
    primaryColor: Colors.purple,
    errorColor: Colors.red,
    primarySwatch: Colors.purple,
    accentColor: Colors.yellow[700],
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        color: Colors.grey,
        fontSize: 15,
      ),
    ),
  );
}
