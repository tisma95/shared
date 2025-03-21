import 'package:flutter/material.dart';
import 'package:mon_gestionnaire_de_tache/store/task_provider.dart';
import 'package:mon_gestionnaire_de_tache/widgets/add_task_widget.dart';
import 'package:mon_gestionnaire_de_tache/widgets/body_widget.dart';
import 'package:mon_gestionnaire_de_tache/widgets/empty_widget.dart';
import 'package:mon_gestionnaire_de_tache/widgets/header_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Gestionnaire de tâches V2"),
      ),
      body: Consumer<TaskProvider>(
        builder: (_, taskStore, child) {
          return SafeArea(
              child: taskStore.allTasks.isEmpty
                  ? EmptyWidget()
                  : Column(
                      children: [HeaderWidget(), Expanded(child: BodyWidget())],
                    ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onAddTask(context),
        tooltip: 'Add task',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onAddTask(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AddTaskWidget();
        });
  }
}
