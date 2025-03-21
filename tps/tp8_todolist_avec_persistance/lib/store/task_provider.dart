import 'package:flutter/material.dart';
import 'package:mon_gestionnaire_de_tache/models/task.dart';
import 'package:mon_gestionnaire_de_tache/services/task_client.dart';

class TaskProvider with ChangeNotifier {
  List<Task> allTasks = [];

  void resetTaskProvider() {
    allTasks = [];
    notifyListeners();
  }

  Future<void> fetchAllTasks() async {
    allTasks = await TaskClient().fetchAllTasks();
    notifyListeners();
  }

  Future<void> createTask({required String name}) async {
    await TaskClient().insertTask(name);
    await fetchAllTasks();
  }

  Future<void> updateTask(int taskId) async {
    // If task is ended set it not ended else set it not ended
    int findIndex = allTasks.indexWhere((task) => task.id == taskId);
    // Update the object
    Task updatedTask = allTasks[findIndex];
    updatedTask.isEnded = !updatedTask.isEnded;
    // Update in database
    await TaskClient().updateTask(updatedTask);
    // Update the state
    notifyListeners();
  }

  Future<void> deleteTask(int taskId) async {
    int findIndex = allTasks.indexWhere((task) => task.id == taskId);
    // Remove in database
    await TaskClient().deleteTaskById(taskId);
    // Remove in state
    allTasks.removeAt(findIndex);
    notifyListeners();
  }
}
