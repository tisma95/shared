import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp5_password_generator/helper.dart';
import 'package:tp5_password_generator/widgets/preference_choice_container.dart';

class Preference2View extends StatefulWidget {
  @override
  const Preference2View(
      {super.key, required this.preferences, required this.onPreferenceChange});

  final SharedPreferences preferences;
  final Function onPreferenceChange;

  @override
  State<Preference2View> createState() => _Preference2ViewState();
}

class _Preference2ViewState extends State<Preference2View> {
  late SharedPreferences preferences;

  // Init the preference again
  late bool isPasswordShouldHaveNumber;
  late bool isPasswordShouldHaveLowerLetter;
  late bool isPasswordShouldHaveUpperLetter;
  late bool isPasswordShouldHaveSpecialLetter;
  late int passwordSize;

  @override
  void initState() {
    preferences = widget.preferences;
    isPasswordShouldHaveNumber = preferences
            .getBool(Util.getPreferenceKeyByType(PreferenceType.prefNumber)) ??
        true;
    isPasswordShouldHaveLowerLetter = preferences.getBool(
            Util.getPreferenceKeyByType(PreferenceType.prefLowerLetter)) ??
        true;
    isPasswordShouldHaveUpperLetter = preferences.getBool(
            Util.getPreferenceKeyByType(PreferenceType.prefUpperLetter)) ??
        true;
    isPasswordShouldHaveSpecialLetter = preferences.getBool(
            Util.getPreferenceKeyByType(PreferenceType.prefSpecialLetter)) ??
        true;
    passwordSize = preferences.getInt(
            Util.getPreferenceKeyByType(PreferenceType.prefPasswordSize)) ??
        8;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 10, top: 10),
                child: Text(
                  "Préférences",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                )),
            PreferenceChoiceContainer(
                onPreferenceChange: onUpdatePreference,
                onValueChange: onChangeState,
                preferenceValue: isPasswordShouldHaveNumber,
                preferenceType: PreferenceType.prefNumber),
            PreferenceChoiceContainer(
                onPreferenceChange: onUpdatePreference,
                onValueChange: onChangeState,
                preferenceValue: isPasswordShouldHaveLowerLetter,
                preferenceType: PreferenceType.prefLowerLetter),
            PreferenceChoiceContainer(
                onPreferenceChange: onUpdatePreference,
                onValueChange: onChangeState,
                preferenceValue: isPasswordShouldHaveUpperLetter,
                preferenceType: PreferenceType.prefUpperLetter),
            PreferenceChoiceContainer(
                onPreferenceChange: onUpdatePreference,
                onValueChange: onChangeState,
                preferenceValue: isPasswordShouldHaveSpecialLetter,
                preferenceType: PreferenceType.prefSpecialLetter),
            PreferenceChoiceContainer(
                onPreferenceChange: onUpdatePreference,
                onValueChange: onChangeState,
                preferenceValue: passwordSize.toDouble(),
                preferenceType: PreferenceType.prefPasswordSize)
          ],
        ),
      ),
    );
  }

  void onUpdatePreference(PreferenceType preferenceType, dynamic value) {
    if (preferenceType == PreferenceType.prefPasswordSize) {
      preferences.setInt(Util.getPreferenceKeyByType(preferenceType), value);
    } else {
      preferences.setBool(Util.getPreferenceKeyByType(preferenceType), value);
    }
    widget.onPreferenceChange();
  }

  // pour raison de performance on va mettre à jour les preferences à la fin du slider pas à chaque changement
  void onChangeState(PreferenceType preferenceType, dynamic value) {
    // Update the state
    switch (preferenceType) {
      case PreferenceType.prefNumber:
        setState(() {
          isPasswordShouldHaveNumber = value;
        });
      case PreferenceType.prefLowerLetter:
        setState(() {
          isPasswordShouldHaveLowerLetter = value;
        });
      case PreferenceType.prefUpperLetter:
        setState(() {
          isPasswordShouldHaveUpperLetter = value;
        });
      case PreferenceType.prefSpecialLetter:
        setState(() {
          isPasswordShouldHaveSpecialLetter = value;
        });
      case PreferenceType.prefPasswordSize:
        setState(() {
          passwordSize = value;
        });
    }
  }

  dynamic getPreferenceInitialValue(PreferenceType preferenceType) {
    if (preferenceType == PreferenceType.prefPasswordSize) {
      return preferences.getInt(Util.getPreferenceKeyByType(preferenceType)) ??
          8;
    }
    return preferences.getBool(Util.getPreferenceKeyByType(preferenceType)) ??
        true;
  }
}
