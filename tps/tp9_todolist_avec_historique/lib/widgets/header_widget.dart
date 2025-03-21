import 'package:flutter/material.dart';
import 'package:mon_gestionnaire_de_tache/util.dart';

class HeaderWidget extends StatelessWidget {
  @override
  const HeaderWidget(
      {super.key, required this.pageType, required this.countDisplay});

  final PageType pageType;
  final int countDisplay;

  @override
  Widget build(BuildContext context) {
    final String countString = countDisplay > 1 ? "tâches" : "tâche";
    final String countHeader = pageType == PageType.todo
        ? "Mes tâches à faire"
        : "Mes tâches terminée(s)";
    return Padding(
        padding: EdgeInsets.only(bottom: 10, top: 10),
        child: Column(
          children: [
            Text(
              countHeader,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "$countDisplay $countString",
              style: TextStyle(fontSize: 18),
            )
          ],
        ));
  }
}
