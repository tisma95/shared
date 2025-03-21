import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp5_password_generator/helper.dart';
import 'package:http/http.dart' as http;
import 'package:tp5_password_generator/widgets/spinner_widget.dart';

class Generator1View extends StatefulWidget {
  @override
  const Generator1View({super.key});

  @override
  State<Generator1View> createState() => _Generator1ViewState();
}

class _Generator1ViewState extends State<Generator1View> {
  bool isPasswordShouldHaveNumber = true;
  bool isPasswordShouldHaveLowerLetter = true;
  bool isPasswordShouldHaveUpperLetter = true;
  bool isPasswordShouldHaveSpecialLetter = true;
  int passwordSize = 8;
  bool isQueryProcess = true;
  List<String> passwords = [];
  int currentPasswordIndex = 0;

  @override
  void initState() {
    // Init the preference again
    SharedPreferences.getInstance()
        .then((preferences) => {
              isPasswordShouldHaveNumber =
                  preferences.getBool(Constant.prefPasswordShouldHaveNumber)!,
              isPasswordShouldHaveLowerLetter = preferences
                  .getBool(Constant.prefPasswordShouldHaveLowerLetter)!,
              isPasswordShouldHaveUpperLetter = preferences
                  .getBool(Constant.prefPasswordShouldHaveUpperLetter)!,
              isPasswordShouldHaveSpecialLetter = preferences
                  .getBool(Constant.prefPasswordShouldHaveSpecialLetter)!,
              passwordSize = preferences.getInt(Constant.prefPasswordSize)!,
              fetchPassword(),
            })
        .catchError((err) => {
              isQueryProcess = false,
            });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isQueryProcess) {
      return SpinnerWidget();
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Mot de passe",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(border: Border.all()),
                      child: Text(
                          overflow: TextOverflow.ellipsis,
                          passwords.isNotEmpty
                              ? passwords[currentPasswordIndex]
                              : "Aucun mot de passe"))),
              IconButton(
                  onPressed: onClickOnRefresh,
                  icon: Icon(
                    Icons.autorenew,
                    color: Colors.deepOrange,
                    size: 48,
                  ))
            ],
          )
        ],
      ),
    );
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
