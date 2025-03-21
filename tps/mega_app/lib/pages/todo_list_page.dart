import 'package:flutter/material.dart';
import 'package:mega_app/helper.dart';
import 'package:mega_app/widgets/drawer_menu_widget.dart';

class TodoListPage extends StatefulWidget {
  @override
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fun Cat"),
      ),
      drawer: DrawerMenuWidget(
        pageType: PageType.todolist,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Text('Hello World Fun Cat Page!'),
        ),
      )),
    );
  }
}
