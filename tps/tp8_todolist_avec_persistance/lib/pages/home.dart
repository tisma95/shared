import 'package:flutter/material.dart';
import 'package:mon_gestionnaire_de_tache/store/task_provider.dart';
import 'package:mon_gestionnaire_de_tache/widgets/add_task_widget.dart';
import 'package:mon_gestionnaire_de_tache/widgets/body_widget.dart';
import 'package:mon_gestionnaire_de_tache/widgets/empty_widget.dart';
import 'package:mon_gestionnaire_de_tache/widgets/header_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<void> _futureLoadTask;

  @override
  void initState() {
    _futureLoadTask = context.read<TaskProvider>().fetchAllTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Gestionnaire de tâches V3"),
      ),
      body: FutureBuilder(
          future: _futureLoadTask,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Consumer<TaskProvider>(
                builder: (_, taskStore, child) {
                  return SafeArea(
                      child: taskStore.allTasks.isEmpty
                          ? EmptyWidget()
                          : Column(
                              children: [
                                HeaderWidget(),
                                Expanded(child: BodyWidget())
                              ],
                            ));
                },
              );
            }
            return _SpinnerDelegate();
          }),
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

class _SpinnerDelegate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
