import 'package:flutter/material.dart';
import 'package:mon_gestionnaire_de_tache/models/task.dart';
import 'package:mon_gestionnaire_de_tache/widgets/task_item_widget.dart';

class BodyWidget extends StatelessWidget {
  @override
  const BodyWidget(
      {super.key,
      required this.taskList,
      required this.onToogleTask,
      required this.onDeleteTask});

  final List<Task> taskList;
  final Function onToogleTask;
  final Function onDeleteTask;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (BuildContext context, int index) {
          return TaskItemWidget(
            task: taskList[index],
            onToogleTask: onToogleTask,
            onDeleteTask: onDeleteTask,
          );
        });
  }
}
