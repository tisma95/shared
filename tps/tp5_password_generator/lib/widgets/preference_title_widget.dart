import 'package:flutter/material.dart';

class PreferenceTitleWidget extends StatelessWidget {
  @override
  const PreferenceTitleWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ));
  }
}
