import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:tp5_password_generator/home_v1.dart';
import 'package:tp5_password_generator/home_v2.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: HomeV2(),
    );
  }
}
