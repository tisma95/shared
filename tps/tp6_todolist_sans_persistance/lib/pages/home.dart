import 'package:flutter/material.dart';
import 'package:mon_gestionnaire_de_tache/widgets/add_task_widget.dart';
import 'package:mon_gestionnaire_de_tache/widgets/body_widget.dart';
import 'package:mon_gestionnaire_de_tache/widgets/empty_widget.dart';
import 'package:mon_gestionnaire_de_tache/models/task.dart';
import 'package:mon_gestionnaire_de_tache/widgets/header_widget.dart';

class HomePage extends StatefulWidget {
  @override
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  final List<Task> _taskList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Gestionnaire de tâches"),
      ),
      body: SafeArea(
          child: _taskList.isEmpty
              ? EmptyWidget()
              : Column(
                  children: [
                    HeaderWidget(
                      countEnded: _taskList
                          .where((task) => task.isEnded)
                          .toList()
                          .length,
                      countTotal: _taskList.length,
                    ),
                    Expanded(
                        child: BodyWidget(
                      taskList: _taskList,
                      onToogleTask: onToogleTask,
                      onDeleteTask: onDeleteTask,
                    ))
                  ],
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddTask,
        tooltip: 'Add task',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onToogleTask(int taskId) {
    // If task is ended set it not ended else set it not ended
    int findIndex = _taskList.indexWhere((task) => task.id == taskId);
    if (findIndex != -1) {
      setState(() {
        _taskList[findIndex].isEnded = !_taskList[findIndex].isEnded;
      });
    }
  }

  void onDeleteTask(int taskId) {
    int findIndex = _taskList.indexWhere((task) => task.id == taskId);
    if (findIndex != -1) {
      setState(() {
        _taskList.removeAt(findIndex);
      });
    }
  }

  void onAddTask() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AddTaskWidget(onCreateTask: onCreateTask);
        });
  }

  void onCreateTask(String name) {
    setState(() {
      // Add on the top
      _taskList.insert(0, Task(name: name));
    });
  }
}
