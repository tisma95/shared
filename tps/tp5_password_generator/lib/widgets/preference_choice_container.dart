import 'package:flutter/material.dart';
import 'package:tp5_password_generator/helper.dart';

class PreferenceChoiceContainer extends StatelessWidget {
  @override
  const PreferenceChoiceContainer(
      {super.key,
      required this.onPreferenceChange,
      required this.preferenceValue,
      required this.onValueChange,
      required this.preferenceType});
  final PreferenceType preferenceType;
  final Function onPreferenceChange;
  final Function onValueChange;
  final dynamic preferenceValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              getPreferenceTitle(preferenceType),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            )),
        //TODO:: Add other preferences object for radio
        preferenceType == PreferenceType.prefPasswordSize
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Slider(
                      value: preferenceValue,
                      min: 8.0,
                      max: 30.0,
                      label: "${preferenceValue.toInt()}",
                      onChanged: (value) =>
                          onValueChange(preferenceType, value.toInt()),
                      onChangeEnd: (value) =>
                          onPreferenceChange(preferenceType, value.toInt()),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text("${preferenceValue.toInt()}"),
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => onRadioValueChange(true),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // On peut utiliser https://api.flutter.dev/flutter/material/RadioListTile-class.html
                        Radio(
                          value: true,
                          groupValue: preferenceValue,
                          activeColor: Colors.deepOrange,
                          onChanged: (value) =>
                              onRadioValueChange(value ?? true),
                        ),
                        Text("Oui")
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onRadioValueChange(false),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // On peut utiliser https://api.flutter.dev/flutter/material/RadioListTile-class.html
                        Radio(
                          value: false,
                          groupValue: preferenceValue,
                          activeColor: Colors.deepOrange,
                          onChanged: (value) =>
                              onRadioValueChange(value ?? false),
                        ),
                        Text("Non")
                      ],
                    ),
                  ),
                ],
              )
      ],
    );
  }

  String getPreferenceTitle(PreferenceType preferenceType) {
    switch (preferenceType) {
      case PreferenceType.prefNumber:
        return "Doit contenir des chiffres ?";
      case PreferenceType.prefLowerLetter:
        return "Doit contenir des lettres minuscules ?";
      case PreferenceType.prefUpperLetter:
        return "Doit contenir des lettres majuscules ?";
      case PreferenceType.prefSpecialLetter:
        return "Doit contenir des caractères spéciaux ?";
      case PreferenceType.prefPasswordSize:
        return "Longueur du mot de passe";
    }
  }

  void onRadioValueChange(dynamic value) {
    onValueChange(preferenceType, value);
    onPreferenceChange(preferenceType, value);
  }
}
