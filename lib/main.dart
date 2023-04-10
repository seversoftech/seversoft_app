import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'navbar.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seversoft Tech',
      theme: ThemeData(),
      home: NavBarHome(),
    );
  }
}
