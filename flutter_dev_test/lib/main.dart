import 'package:flutter/material.dart';
import 'package:flutter_dev_test/homepage.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
          // brightness: Brightness.dark, // This is the theme of your application.
          ),
      home: HomePage(),
    );
  }
}
