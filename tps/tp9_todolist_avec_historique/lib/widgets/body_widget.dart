import 'package:flutter/material.dart';
import 'package:mon_gestionnaire_de_tache/models/task.dart';
import 'package:mon_gestionnaire_de_tache/store/task_provider.dart';
import 'package:mon_gestionnaire_de_tache/util.dart';
import 'package:mon_gestionnaire_de_tache/widgets/empty_widget.dart';
import 'package:mon_gestionnaire_de_tache/widgets/header_widget.dart';
import 'package:mon_gestionnaire_de_tache/widgets/task_item_widget.dart';
import 'package:provider/provider.dart';

class BodyWidget extends StatefulWidget {
  @override
  const BodyWidget(
      {super.key, required this.displayTasks, required this.pageType});

  final List<Task> displayTasks;
  final PageType pageType;

  @override
  State<StatefulWidget> createState() {
    return _BodyWidgetState();
  }
}

class _BodyWidgetState extends State<BodyWidget> {
  late List<Task> displayTasks;

  @override
  void initState() {
    displayTasks = widget.displayTasks;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (displayTasks.isEmpty) {
      return EmptyWidget(
        message: widget.pageType == PageType.completed
            ? "Votre liste de tâches terminées est vide vous pouvez terminer votre première tâche dans la liste des tâches à faire."
            : "Votre liste de tâches à faire est vide vous pouvez créer votre première tâche en appuyant sur le bouton plus.",
      );
    }
    return Column(
      children: [
        HeaderWidget(
          pageType: widget.pageType,
          countDisplay: displayTasks.length,
        ),
        Expanded(
            child: ListView.builder(
                itemCount: displayTasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return TaskItemWidget(
                    task: displayTasks[index],
                    index: index,
                    onUpdateTask: onUpdateTask,
                  );
                }))
      ],
    );
  }

  void onUpdateTask(int index) async {
    // Set the delayed before acknowledge the task to help user to see the change before acknowledge
    setState(() {
      displayTasks[index].isEnded = !displayTasks[index].isEnded;
    });
    // Not call the context inside the async gap
    await Future.delayed(
        Duration(milliseconds: 250), () => updateTaskState(index));
  }

  updateTaskState(int index) {
    context.read<TaskProvider>().updateTask(displayTasks[index]);
    setState(() {
      displayTasks.removeAt(index);
    });
  }
}
