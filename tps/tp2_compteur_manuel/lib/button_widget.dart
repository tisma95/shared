import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  @override
  const ButtonWidget(
      {super.key,
      required this.onPress,
      required this.buttonColor,
      required this.widthPercent,
      required this.buttonText});

  final Function onPress;
  final String buttonText;
  final Color buttonColor;
  final double widthPercent;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => onPress(),
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(buttonColor),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * widthPercent,
          child: Text(buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  letterSpacing: 2.0,
                  wordSpacing: 2.0,
                  fontWeight: FontWeight.bold)),
        ));
  }
}
