import 'package:flutter/material.dart';
import 'package:mon_gestionnaire_de_tache/store/task_provider.dart';
import 'package:mon_gestionnaire_de_tache/widgets/task_item_widget.dart';
import 'package:provider/provider.dart';

class BodyWidget extends StatelessWidget {
  @override
  const BodyWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (_, taskStore, child) {
      return ListView.builder(
          itemCount: taskStore.allTasks.length,
          itemBuilder: (BuildContext context, int index) {
            return TaskItemWidget(task: taskStore.allTasks[index]);
          });
    });
  }
}
