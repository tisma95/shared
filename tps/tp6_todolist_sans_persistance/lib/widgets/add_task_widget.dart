import 'package:flutter/material.dart';

class AddTaskWidget extends StatefulWidget {
  @override
  const AddTaskWidget({super.key, required this.onCreateTask});
  final Function onCreateTask;

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  late TextEditingController controller;

  String errorText = "";

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Nouvelle tâche"),
      content: SingleChildScrollView(
        child: TextFormField(
            controller: controller,
            autofocus: true,
            onChanged: (value) {
              controller.value = TextEditingValue(text: value);
              setState(() {
                errorText = '';
              });
            },
            decoration: InputDecoration(
                errorText: errorText.isEmpty ? null : errorText,
                hintText: "Entrer le nom de tâche",
                labelText: "Nom")),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Annuler")),
        TextButton(onPressed: onCreateTask, child: Text("Ajouter"))
      ],
    );
  }

  void onCreateTask() {
    String name = controller.text;
    if (name.isEmpty) {
      setState(() {
        errorText = "Le nom de la tâche est obligatoire.";
      });
      return;
    }
    // Call parent function
    widget.onCreateTask(name);
    Navigator.of(context).pop();
  }
}
