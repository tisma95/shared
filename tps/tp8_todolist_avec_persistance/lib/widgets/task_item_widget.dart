import 'package:flutter/material.dart';
import 'package:mon_gestionnaire_de_tache/models/task.dart';
import 'package:mon_gestionnaire_de_tache/store/task_provider.dart';
import 'package:provider/provider.dart';

class TaskItemWidget extends StatelessWidget {
  @override
  const TaskItemWidget({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.grey,
        child: ListTile(
          leading: IconButton(
            icon: Icon(
                task.isEnded ? Icons.task_alt_outlined : Icons.circle_outlined),
            iconSize: 32,
            color: Colors.blueGrey,
            onPressed: () => context.read<TaskProvider>().updateTask(task.id),
            // onPressed: null,
          ),
          title: Text(
            task.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                decoration: task.isEnded
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                fontStyle: task.isEnded ? FontStyle.italic : FontStyle.normal),
          ),
          shape: BeveledRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 0.5),
          ),
          // onTap: () => onToogleTask(task.id),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            iconSize: 32,
            color: Colors.red,
            onPressed: () => context.read<TaskProvider>().deleteTask(task.id),
            // onPressed: null,
          ),
        ));
  }
}
