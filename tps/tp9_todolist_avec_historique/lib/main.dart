import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mon_gestionnaire_de_tache/pages/complete_task.dart';
import 'package:mon_gestionnaire_de_tache/pages/todo_task.dart';
import 'package:mon_gestionnaire_de_tache/store/provider_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [...ProviderStore().provider], child: const MyApp()));
}

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      name: 'todo',
      builder: (BuildContext context, GoRouterState state) {
        return const TodoTaskPage();
      }),
  GoRoute(
      path: '/complete',
      name: 'complete',
      builder: (BuildContext context, GoRouterState state) {
        return const CompleteTaskPage();
      })
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mon gestionnaire de tâches V3',
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
    );
  }
}
