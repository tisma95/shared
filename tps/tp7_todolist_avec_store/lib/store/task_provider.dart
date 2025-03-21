import 'package:flutter/material.dart';
import 'package:mon_gestionnaire_de_tache/models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> allTasks = [];

  void resetTaskProvider() {
    allTasks = [];
    notifyListeners();
  }

  void createTask({required String name}) {
    allTasks.add(Task(name: name));
    notifyListeners();
  }

  void updateTask(int taskId) {
    // If task is ended set it not ended else set it not ended
    int findIndex = allTasks.indexWhere((task) => task.id == taskId);
    // Update the state
    allTasks[findIndex].isEnded = !allTasks[findIndex].isEnded;
    notifyListeners();
  }

  void deleteTask(int taskId) {
    int findIndex = allTasks.indexWhere((task) => task.id == taskId);
    allTasks.removeAt(findIndex);
    notifyListeners();
  }
}
