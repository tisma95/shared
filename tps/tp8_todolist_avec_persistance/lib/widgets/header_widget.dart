import 'package:flutter/material.dart';
import 'package:mon_gestionnaire_de_tache/store/task_provider.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatelessWidget {
  @override
  const HeaderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "Mes tâches",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Consumer<TaskProvider>(builder: (_, taskStore, child) {
                final int countEnd = taskStore.allTasks
                    .where((task) => task.isEnded)
                    .toList()
                    .length;
                final int countTotal = taskStore.allTasks.length;
                return Text(
                    countEnd > 1
                        ? "$countEnd tâches / $countTotal terminées"
                        : "$countEnd tâche / $countTotal terminée",
                    style: TextStyle(fontSize: 14));
              })
            ]));
  }
}
