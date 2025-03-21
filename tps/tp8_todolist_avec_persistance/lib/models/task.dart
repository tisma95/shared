class Task {
  Task({required this.id, required this.name, required this.isEnded});

  final int id;
  final String name;
  bool isEnded;

  @override
  String toString() {
    return "$id: $name";
  }

  Map<String, dynamic> toMap() {
    return {
      "createdDate": getTodayISOString(),
      'id': id,
      'name': name,
      'isEnded': isEnded == true ? 1 : 0
    };
  }

  // Get today in iso string
  String getTodayISOString() {
    return DateTime.now().toIso8601String();
  }
}
