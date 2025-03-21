import 'package:flutter/material.dart';
import 'package:tp3_magic_number/helper.dart';
import 'package:tp3_magic_number/playing.dart';

class HomePage extends StatefulWidget {
  @override
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Mode selection
  GameMode _modeSelection = GameMode.easy;
  final GameParameter _gameParameter = GameParameter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nombre Magique"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 25),
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset("assets/cover.jpg"),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Bienvenue sur le Jeu du Nombre Magique",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Choisissez un niveau de difficulté",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 25,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),
              _RadioButtonDelegate(
                modeSelection: _modeSelection,
                value: GameMode.easy,
                title:
                    "Facile (entre ${_gameParameter.MIN_VALUE} et ${_gameParameter.MAX_EASY})",
                onModeChange: onModeChange,
              ),
              _RadioButtonDelegate(
                modeSelection: _modeSelection,
                value: GameMode.medium,
                title:
                    "Moyen (entre ${_gameParameter.MIN_VALUE} et ${_gameParameter.MAX_MEDIUM})",
                onModeChange: onModeChange,
              ),
              _RadioButtonDelegate(
                modeSelection: _modeSelection,
                value: GameMode.hard,
                title:
                    "Difficile (entre ${_gameParameter.MIN_VALUE} et ${_gameParameter.MAX_HARD})",
                onModeChange: onModeChange,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: WidgetStatePropertyAll(
                          Size(MediaQuery.of(context).size.width - 70, 50)),
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.redAccent)),
                  onPressed: () => {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlayingPage(
                                      playingMode: _modeSelection,
                                    )))
                      },
                  child: Text(
                    "Démarrer",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  onModeChange(GameMode value) {
    setState(() {
      _modeSelection = value;
    });
  }
}

class _RadioButtonDelegate extends StatelessWidget {
  @override
  const _RadioButtonDelegate(
      {required this.modeSelection,
      required this.value,
      required this.title,
      required this.onModeChange});
  final GameMode modeSelection;
  final GameMode value;
  final Function onModeChange;
  final String title;
  @override
  Widget build(BuildContext context) {
    // Can use the RadioListTile https://api.flutter.dev/flutter/material/RadioListTile-class.html
    return RadioListTile(
        value: value,
        groupValue: modeSelection,
        materialTapTargetSize: MaterialTapTargetSize.padded,
        activeColor: Colors.red,
        title: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        fillColor: WidgetStatePropertyAll(Colors.red),
        onChanged: (GameMode? value) => onModeChange(value));
  }
}
