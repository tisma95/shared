import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp5_password_generator/helper.dart';
import 'package:tp5_password_generator/views/generator2_view.dart';
import 'package:tp5_password_generator/views/preference2_view.dart';
import 'package:tp5_password_generator/widgets/spinner_widget.dart';

class HomeV2 extends StatefulWidget {
  @override
  const HomeV2({super.key});

  @override
  State<HomeV2> createState() => _HomeV2State();
}

class _HomeV2State extends State<HomeV2> {
  late Future<void> _futureBuilder;
  bool isPreferenceChange = false;
  late SharedPreferences preferences;
  bool isQueryProcess = false;
  List<String> passwords = [];
  int currentPasswordIndex = 0;

  @override
  void initState() {
    _futureBuilder = initPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Générateur de mot de passe V2",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepOrange,
        ),
        body: FutureBuilder(
            future: _futureBuilder,
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Generator2View(
                        currentPassword: passwords.isNotEmpty
                            ? passwords[currentPasswordIndex]
                            : "Aucun mot de passe",
                        isQueryProcess: isQueryProcess,
                        onClickOnRefresh: onClickOnRefresh,
                      ),
                      Divider(
                        thickness: 4.0,
                      ),
                      Preference2View(
                        preferences: preferences,
                        onPreferenceChange: fetchPassword,
                      )
                    ],
                  ),
                );
              }
              return SpinnerWidget();
            }));
  }

  Future<void> initPreferences() async {
    preferences = await SharedPreferences.getInstance();
    List<dynamic> prefValues = [
      preferences.getBool(Constant.prefPasswordShouldHaveNumber),
      preferences.getBool(Constant.prefPasswordShouldHaveLowerLetter),
      preferences.getBool(Constant.prefPasswordShouldHaveUpperLetter),
      preferences.getBool(Constant.prefPasswordShouldHaveSpecialLetter),
      preferences.getInt(Constant.prefPasswordSize)
    ];
    // Init the share preferences if neccessary
    if (prefValues.contains(null)) {
      // Init the preferences
      preferences.setBool(Constant.prefPasswordShouldHaveNumber, true);
      preferences.setBool(Constant.prefPasswordShouldHaveLowerLetter, true);
      preferences.setBool(Constant.prefPasswordShouldHaveUpperLetter, true);
      preferences.setBool(Constant.prefPasswordShouldHaveSpecialLetter, true);
      preferences.setInt(Constant.prefPasswordSize, 8);
    }
    await fetchPassword();
  }

  void onClickOnRefresh() {
    if (currentPasswordIndex < Constant.maxFetchPassword - 1) {
      setState(() {
        currentPasswordIndex = currentPasswordIndex + 1;
      });
    } else {
      fetchPassword();
    }
  }

  Future<void> fetchPassword() async {
    // Init the preference again
    final bool isPasswordShouldHaveNumber =
        preferences.getBool(Constant.prefPasswordShouldHaveNumber) ?? true;
    final bool isPasswordShouldHaveLowerLetter =
        preferences.getBool(Constant.prefPasswordShouldHaveLowerLetter) ?? true;
    final bool isPasswordShouldHaveUpperLetter =
        preferences.getBool(Constant.prefPasswordShouldHaveUpperLetter) ?? true;
    final bool isPasswordShouldHaveSpecialLetter =
        preferences.getBool(Constant.prefPasswordShouldHaveSpecialLetter) ??
            true;
    final int passwordSize = preferences.getInt(Constant.prefPasswordSize) ?? 8;
    setState(() {
      isQueryProcess = true;
    });
    String url = "api.motdepasse.xyz";
    //https://www.motdepasse.xyz/api/
    // https://api.motdepasse.xyz/create/?include_digits&include_lowercase&include_uppercase&include_special_characters&password_length=32&quantity=30
    // Add fixed parameter
    Map<String, String> urlQuery = {
      "password_length": "$passwordSize",
      "quantity": "${Constant.maxFetchPassword}"
    };

    if (isPasswordShouldHaveNumber) {
      urlQuery["include_digits"] = "";
    }
    if (isPasswordShouldHaveLowerLetter) {
      urlQuery["include_lowercase"] = "";
    }
    if (isPasswordShouldHaveUpperLetter) {
      urlQuery["include_uppercase"] = "";
    }
    if (isPasswordShouldHaveSpecialLetter) {
      urlQuery["include_special_characters"] = "";
    }

    // Complete the url
    final apiUrl = Uri.https(url, "create", urlQuery);
    var response = await http.get(apiUrl);
    final responseMapping = jsonDecode(utf8.decode(response.bodyBytes)) as Map;

    setState(() {
      isQueryProcess = false;
      passwords = [...responseMapping["passwords"]];
      currentPasswordIndex = 0;
    });
  }
}
