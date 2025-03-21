import 'package:flutter/material.dart';
import 'package:mon_gestionnaire_de_tache/pages/home.dart';
import 'package:mon_gestionnaire_de_tache/store/provider_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [...ProviderStore().provider], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon gestionnaire de tâches V3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
