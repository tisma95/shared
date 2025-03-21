import 'package:shared_preferences/shared_preferences.dart';

class Constant {
  static const String prefPasswordShouldHaveNumber = "isContainsNumber";
  static const String prefPasswordShouldHaveLowerLetter =
      "isContainsLowerLetter";
  static const String prefPasswordShouldHaveUpperLetter =
      "isContainsUpperLetter";
  static const String prefPasswordShouldHaveSpecialLetter =
      "isContainsSpecialLetter";
  static const String prefPasswordSize = "passwordSize";
  static const int maxFetchPassword = 30;
}

// TODO: Integrate in preferences update elements
class Util {
  static Future<void> updatePreference(
      PreferenceType prefType, dynamic prefValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    switch (prefType) {
      case PreferenceType.prefLowerLetter:
        preferences.setBool(
            Constant.prefPasswordShouldHaveLowerLetter, prefValue);
        break;
      case PreferenceType.prefPasswordSize:
        preferences.setInt(Constant.prefPasswordSize, prefValue);
        break;
      case PreferenceType.prefUpperLetter:
        preferences.setBool(
            Constant.prefPasswordShouldHaveUpperLetter, prefValue);
        break;
      case PreferenceType.prefSpecialLetter:
        preferences.setBool(
            Constant.prefPasswordShouldHaveSpecialLetter, prefValue);
        break;
      case PreferenceType.prefNumber:
        preferences.setBool(Constant.prefPasswordShouldHaveNumber, prefValue);
        break;
    }
  }

  static String getPreferenceKeyByType(PreferenceType prefType) {
    switch (prefType) {
      case PreferenceType.prefLowerLetter:
        return Constant.prefPasswordShouldHaveLowerLetter;
      case PreferenceType.prefNumber:
        return Constant.prefPasswordShouldHaveNumber;
      case PreferenceType.prefUpperLetter:
        return Constant.prefPasswordShouldHaveUpperLetter;
      case PreferenceType.prefSpecialLetter:
        return Constant.prefPasswordShouldHaveSpecialLetter;
      case PreferenceType.prefPasswordSize:
        return Constant.prefPasswordSize;
    }
  }
}

// TODO: Should be integrate in radio of element preference
enum PreferenceType {
  prefNumber,
  prefLowerLetter,
  prefUpperLetter,
  prefSpecialLetter,
  prefPasswordSize
}
