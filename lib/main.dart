import 'package:flutter/material.dart';
import 'package:dsmap/screens/home.dart';
import 'package:dsmap/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DISMAP',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Splash(),
    );
  }
}
