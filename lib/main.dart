import 'package:flutter/material.dart';
import 'package:uyishi_47_30_05/views/screens/homePage.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, 
      home: HomePage()
      );
  }
}
