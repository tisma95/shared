import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp5_password_generator/helper.dart';
import 'package:tp5_password_generator/views/generator1_view.dart';
import 'package:tp5_password_generator/views/preference1_view.dart';
import 'package:tp5_password_generator/widgets/spinner_widget.dart';

class HomeV1 extends StatefulWidget {
  @override
  const HomeV1({super.key});

  @override
  State<HomeV1> createState() => _HomeV1State();
}

class _HomeV1State extends State<HomeV1> {
  late Future<void> _futureBuilder;
  int _currentSelectedPageIndex = 0;

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
            "Générateur de mot de passe V1",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepOrange,
        ),
        bottomNavigationBar: NavigationBar(
            selectedIndex: _currentSelectedPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _currentSelectedPageIndex = index;
              });
            },
            destinations: [
              NavigationDestination(
                  icon: Icon(Icons.password_rounded), label: "Générateur"),
              NavigationDestination(
                  icon: Icon(Icons.settings), label: "Préférences")
            ]),
        body: FutureBuilder(
            future: _futureBuilder,
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return _currentSelectedPageIndex == 1
                    ? Preference1View()
                    : Generator1View();
              }
              return SpinnerWidget();
            }));
  }

  Future<void> initPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
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
  }
}
