import 'package:flutter/material.dart';
import 'package:tp2_compteur_manuel/button_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Compteur manuel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Compteur manuel'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = 0;
  }

  void _increment() {
    setState(() {
      _counter += 1;
    });
  }

  void _decrement() {
    setState(() {
      _counter -= 1;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Mon Compteur",
                style: TextStyle(
                    fontSize: 30, letterSpacing: 2.0, wordSpacing: 2.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "$_counter",
                  style: TextStyle(
                      fontSize: 48,
                      letterSpacing: 2.0,
                      wordSpacing: 2.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ButtonWidget(
                      onPress: _decrement,
                      buttonColor: Theme.of(context).colorScheme.secondary,
                      widthPercent: 0.30,
                      buttonText: "-1"),
                  ButtonWidget(
                      onPress: _increment,
                      widthPercent: 0.30,
                      buttonColor: Theme.of(context).colorScheme.primary,
                      buttonText: "+1")
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: ButtonWidget(
                    onPress: _reset,
                    buttonColor: Colors.redAccent,
                    widthPercent: 0.80,
                    buttonText: "Réinitialiser"),
              ),
            ],
          ),
        ));
  }
}
