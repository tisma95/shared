import 'package:flutter/material.dart';
import 'package:mon_gestionnaire_de_tache/models/task.dart';
import 'package:mon_gestionnaire_de_tache/store/task_provider.dart';
import 'package:mon_gestionnaire_de_tache/util.dart';
import 'package:mon_gestionnaire_de_tache/widgets/body_widget.dart';
import 'package:mon_gestionnaire_de_tache/widgets/drawer_menu_widget.dart';
import 'package:mon_gestionnaire_de_tache/widgets/spiner_widget.dart';
import 'package:provider/provider.dart';

class CompleteTaskPage extends StatefulWidget {
  const CompleteTaskPage({super.key});

  @override
  State<CompleteTaskPage> createState() => _CompleteTaskPageState();
}

class _CompleteTaskPageState extends State<CompleteTaskPage> {
  late Future<void> _futureBuilder;
  @override
  void initState() {
    _futureBuilder = context.read<TaskProvider>().fetchAllTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Terminée"),
      ),
      drawer: DrawerMenuWidget(pageType: PageType.completed),
      body: FutureBuilder(
          future: _futureBuilder,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Consumer<TaskProvider>(
                builder: (_, taskStore, child) {
                  final List<Task> targetTasks =
                      taskStore.allTasks.where((task) => task.isEnded).toList();
                  return SafeArea(
                      child: BodyWidget(
                          displayTasks: targetTasks,
                          pageType: PageType.completed));
                },
              );
            }
            return SpinnerWidget();
          }),
    );
  } // This trailing comma makes auto-formatting nicer for build methods.
}
