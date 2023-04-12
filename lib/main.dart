import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dependency_injection.dart';
import 'navbar.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark),
  );

  runApp(MyApp()); DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seversoft Tech',
      theme: ThemeData(),
      home: NavBarHome(),
    );
  }
}

