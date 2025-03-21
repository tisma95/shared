import 'package:flutter/material.dart';

class SpinnerWidget extends StatelessWidget {
  @override
  const SpinnerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
