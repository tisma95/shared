import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tp3_magic_number/helper.dart';
import 'package:tp3_magic_number/home.dart';

class PlayingPage extends StatefulWidget {
  @override
  State<PlayingPage> createState() => _PlayingPageState();

  @override
  const PlayingPage({super.key, required this.playingMode});

  final GameMode playingMode;
}

class _PlayingPageState extends State<PlayingPage> {
  late final GameMode playingMode;
  late final int magicNumber;
  int _countTries = 0;
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    playingMode = widget.playingMode;
    magicNumber = getMagicNumber();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Niveau ${getModeString(playingMode)}"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 25),
        backgroundColor: Colors.redAccent,
      ),
      body: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: Icon(
                  Icons.question_mark,
                  color: Colors.red,
                  size: 100,
                ),
              ),
              Text(
                "$_countTries tentative(s)",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Devinez le nombre magique ?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                    controller: controller,
                    maxLength: 5,
                    autofocus: true,
                    readOnly: false,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                    textInputAction: TextInputAction.done,
                    focusNode: focusNode,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 30),
                        hintText: "Entrer un nombre"),
                    onChanged: (value) => onChangeNumber(value),
                    onTapOutside: (e) => focusNode.unfocus(),
                    onSubmitted: (String? value) =>
                        onChangeNumber(value ?? '')),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: WidgetStatePropertyAll(
                          Size(MediaQuery.of(context).size.width - 70, 50)),
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.greenAccent)),
                  onPressed: onSubmit,
                  child: Text(
                    "Soumettre",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: WidgetStatePropertyAll(
                          Size(MediaQuery.of(context).size.width - 70, 50)),
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.redAccent)),
                  onPressed: onEndGame,
                  child: Text(
                    "Terminer la partie",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ))
            ],
          ),
        )),
      ),
    );
  }

  String getModeString(GameMode mode) {
    switch (mode) {
      case GameMode.hard:
        return "difficile";
      case GameMode.medium:
        return "moyen";
      default:
        return "facile";
    }
  }

  // Function to call when the number change
  void onChangeNumber(String value) {
    controller.value = TextEditingValue(text: value);
  }

  // Function to move to home page
  void moveToHomePage() {
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => HomePage()));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()),
        (route) => false);
  }

  // Function to add on action to submit the response
  void onSubmit() {
    final String userProposition = controller.text;
    try {
      int userNumber = int.parse(userProposition);
      if (userNumber > magicNumber) {
        showDialog(
            context: context,
            builder: (BuildContext context) => _ResultModalDelegate(
                  modalTitle: "Nombre trog grand 👆!",
                  modalBody:
                      "Le nombre $userNumber est plus grand que le nombre magique.",
                ));
        // Increase the count of tries
        setState(() {
          _countTries++;
        });
      } else if (userNumber < magicNumber) {
        showDialog(
            context: context,
            builder: (BuildContext context) => _ResultModalDelegate(
                  modalTitle: "Nombre trog petit 👇!",
                  modalBody:
                      "Le nombre $userNumber est plus petit que le nombre magique.",
                ));
        // Increase the count of tries
        setState(() {
          _countTries++;
        });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) => _ResultModalDelegate(
                  modalTitle: "Bingo 👏!",
                  modalBody:
                      "Le nombre magique était $magicNumber. Vous l'avez trouvé en $_countTries tentatives.",
                  callback: moveToHomePage,
                ));
      }
    } catch (err) {
      showDialog(
          context: context,
          builder: (BuildContext context) => _ResultModalDelegate(
                modalTitle: "Saisie incorrecte 😒",
                modalBody: "Vous devez saisir une nombre svp !",
              ));
      return;
    }
  }

  // Function to call for end the partie
  void onEndGame() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Terminer la partie ?"),
            content: Text("Voulez vous terminer la partie en cours ?",
                style: TextStyle(fontSize: 16)),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Non", style: TextStyle(fontSize: 16))),
              TextButton(
                  onPressed: () => moveToHomePage(),
                  child: const Text("Oui", style: TextStyle(fontSize: 16)))
            ],
          );
        });
  }

  // Function to generate the magic number
  int getMagicNumber() {
    // Define the max and min number base on mode selection
    final int minValue = GameParameter().MIN_VALUE;
    int maxValue = GameParameter().MAX_EASY;
    if (playingMode == GameMode.medium) {
      maxValue = GameParameter().MAX_MEDIUM;
    } else if (playingMode == GameMode.hard) {
      maxValue = GameParameter().MAX_HARD;
    }
    return Random().nextInt(maxValue - minValue) + minValue;
  }
}

class _ResultModalDelegate extends StatelessWidget {
  @override
  const _ResultModalDelegate(
      {required this.modalTitle, required this.modalBody, this.callback});

  final String modalTitle;
  final String modalBody;
  final Function? callback;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(modalTitle),
      content: Text(modalBody, style: TextStyle(fontSize: 16)),
      actions: [
        TextButton(
            onPressed: () => {
                  Navigator.of(context).pop(),
                  if (callback != null) {callback!()}
                },
            child: const Text("OK", style: TextStyle(fontSize: 16)))
      ],
    );
  }
}
