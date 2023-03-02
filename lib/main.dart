import 'package:flutter/material.dart';
import 'page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seversoft Tech',
      theme: ThemeData(
        
      ),
      home: const Homepage(),
      
    );
  }
}
