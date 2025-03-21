import 'dart:async';

import 'package:mon_gestionnaire_de_tache/models/task.dart';
import 'package:mon_gestionnaire_de_tache/services/database.dart';
import 'package:mon_gestionnaire_de_tache/util.dart';
import 'package:sqflite/sqflite.dart';

class TaskClient {
  final DatabaseClient _database = DatabaseClient();

  TaskClient();

  // Define the function to insert the task
  Future<void> insertTask(String name) async {
    final db = await _database.getDatabase();

    // New task data
    Map<String, dynamic> taskData = {
      "createdDate": DateTime.now().toIso8601String(),
      'name': name,
      'isEnded': 0
    };
    // Insert by replacing if existing
    await db.insert(Constant.taskTableName, taskData,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Define the function to return the list of all tasks
  Future<List<Task>> fetchAllTasks() async {
    final db = await _database.getDatabase();
    // Query to get all tasks
    final List<Map<String, dynamic>> ressources =
        await db.query(Constant.taskTableName, orderBy: "createdDate desc");
    // Convert the response in list of task
    return _generateTaskList(ressources);
  }

  // Define the update in database the task operation consists on 2 actions: convert task in Map before saving it
  Future<void> updateTask(Task task) async {
    final db = await _database.getDatabase();
    await db.update(Constant.taskTableName, task.toMap(),
        where: 'id = ?', whereArgs: [task.id]);
  }

  // Define the delete action of task
  Future<void> deleteTaskById(int id) async {
    final db = await _database.getDatabase();
    await db.delete(Constant.taskTableName, where: 'id = ?', whereArgs: [id]);
  }

  List<Task> _generateTaskList(List<Map<String, dynamic>> taskResponse) {
    // Convert the response in list of task
    return List.generate(taskResponse.length, (index) {
      return Task(
        id: taskResponse[index]['id'],
        name: taskResponse[index]['name'],
        isEnded: taskResponse[index]["isEnded"] == 1 ? true : false,
      );
    });
  }
}
