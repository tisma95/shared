import 'dart:math';

class Task {
  Task({required this.name}) {
    id = DateTime.now().millisecondsSinceEpoch + Random().nextInt(1000);
  }

  late final int id;
  final String name;
  bool isEnded = false;

  @override
  String toString() {
    return "$id: $name";
  }
}
