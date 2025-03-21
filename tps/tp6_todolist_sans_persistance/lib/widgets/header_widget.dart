import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  @override
  const HeaderWidget(
      {super.key, required this.countEnded, required this.countTotal});

  final int countEnded;
  final int countTotal;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                "Mes tâches",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                  countEnded > 1
                      ? "$countEnded tâches / $countTotal terminées"
                      : "$countEnded tâche / $countTotal terminée",
                  style: TextStyle(fontSize: 14)),
            ]));
  }
}
