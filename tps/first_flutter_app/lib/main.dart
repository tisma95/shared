// Squelette d'un widget Stateless
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  @override
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello Worldbfgfgf!'),
        ),
      ),
    );
  }
}
