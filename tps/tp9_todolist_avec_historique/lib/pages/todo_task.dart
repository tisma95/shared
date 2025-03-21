import 'package:flutter/material.dart';
import 'package:mon_gestionnaire_de_tache/models/task.dart';
import 'package:mon_gestionnaire_de_tache/store/task_provider.dart';
import 'package:mon_gestionnaire_de_tache/util.dart';
import 'package:mon_gestionnaire_de_tache/widgets/add_task_widget.dart';
import 'package:mon_gestionnaire_de_tache/widgets/body_widget.dart';
import 'package:mon_gestionnaire_de_tache/widgets/drawer_menu_widget.dart';
import 'package:mon_gestionnaire_de_tache/widgets/spiner_widget.dart';
import 'package:provider/provider.dart';

class TodoTaskPage extends StatefulWidget {
  const TodoTaskPage({super.key});

  @override
  State<TodoTaskPage> createState() => _TodoTaskPageState();
}

class _TodoTaskPageState extends State<TodoTaskPage> {
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
          title: const Text("À faire"),
        ),
        drawer: DrawerMenuWidget(pageType: PageType.todo),
        body: FutureBuilder(
            future: _futureLoadTask,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer<TaskProvider>(
                  builder: (_, taskStore, child) {
                    final List<Task> targetTasks = taskStore.allTasks
                        .where((task) => !task.isEnded)
                        .toList();
                    return SafeArea(
                        child: BodyWidget(
                            displayTasks: targetTasks,
                            pageType: PageType.todo));
                  },
                );
              }
              return SpinnerWidget();
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => onAddTask(context),
          tooltip: 'Add task',
          child: const Icon(Icons.add),
        )); // This trailing comma makes auto-formatting nicer for build methods.
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
