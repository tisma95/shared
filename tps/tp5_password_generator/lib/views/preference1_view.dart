import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp5_password_generator/helper.dart';
import 'package:tp5_password_generator/widgets/preference_radio_widget.dart';
import 'package:tp5_password_generator/widgets/preference_slider_widget.dart';
import 'package:tp5_password_generator/widgets/preference_title_widget.dart';
import 'package:tp5_password_generator/widgets/spinner_widget.dart';

class Preference1View extends StatefulWidget {
  @override
  const Preference1View({super.key});

  @override
  State<Preference1View> createState() => _Preference1ViewState();
}

class _Preference1ViewState extends State<Preference1View> {
  late SharedPreferences preferences;
  late Future<void> _futureLoadPreferences;

  @override
  void initState() {
    _futureLoadPreferences = SharedPreferences.getInstance().then((prefs) {
      preferences = prefs;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureLoadPreferences,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
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
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        )),
                    PreferenceTitleWidget(
                        title: getPreferenceTitle(PreferenceType.prefNumber)),
                    PreferenceRadioWidget(
                      preferenceType: PreferenceType.prefNumber,
                      initialValue:
                          getPreferenceInitialValue(PreferenceType.prefNumber),
                    ),
                    PreferenceTitleWidget(
                        title:
                            getPreferenceTitle(PreferenceType.prefLowerLetter)),
                    PreferenceRadioWidget(
                      preferenceType: PreferenceType.prefLowerLetter,
                      initialValue: getPreferenceInitialValue(
                          PreferenceType.prefLowerLetter),
                    ),
                    PreferenceTitleWidget(
                        title:
                            getPreferenceTitle(PreferenceType.prefUpperLetter)),
                    PreferenceRadioWidget(
                      preferenceType: PreferenceType.prefUpperLetter,
                      initialValue: getPreferenceInitialValue(
                          PreferenceType.prefUpperLetter),
                    ),
                    PreferenceTitleWidget(
                        title: getPreferenceTitle(
                            PreferenceType.prefSpecialLetter)),
                    PreferenceRadioWidget(
                      preferenceType: PreferenceType.prefSpecialLetter,
                      initialValue: getPreferenceInitialValue(
                          PreferenceType.prefSpecialLetter),
                    ),
                    PreferenceTitleWidget(
                        title: getPreferenceTitle(
                            PreferenceType.prefPasswordSize)),
                    PreferenceSliderWidget(
                        initalValue: getPreferenceInitialValue(
                            PreferenceType.prefPasswordSize))
                  ],
                ),
              ),
            );
          }
          return SpinnerWidget();
        });
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

  dynamic getPreferenceInitialValue(PreferenceType preferenceType) {
    if (preferenceType == PreferenceType.prefPasswordSize) {
      return preferences.getInt(Util.getPreferenceKeyByType(preferenceType)) ??
          8;
    }
    return preferences.getBool(Util.getPreferenceKeyByType(preferenceType)) ??
        true;
  }
}
