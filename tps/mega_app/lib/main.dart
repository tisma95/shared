import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mega_app/pages/fun_cat_page.dart';
import 'package:mega_app/pages/password_generator_page.dart';
import 'package:mega_app/pages/todo_list_page.dart';

void main() {
  runApp(const MainApp());
}

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      name: 'funcat',
      builder: (BuildContext context, GoRouterState state) {
        return const FunCatPage();
      }),
  GoRoute(
      path: '/password',
      name: 'password',
      builder: (BuildContext context, GoRouterState state) {
        return const PasswordGeneratorPage();
      }),
  GoRoute(
      path: '/todo',
      name: 'todo',
      builder: (BuildContext context, GoRouterState state) {
        return const TodoListPage();
      })
]);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: "Mega App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          appBarTheme: AppBarTheme(
              backgroundColor: Theme.of(context).primaryColor,
              iconTheme: IconThemeData(color: Colors.white)),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent)),
    );
  }
}
