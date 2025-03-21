import 'package:flutter/material.dart';

class Generator2View extends StatelessWidget {
  @override
  const Generator2View(
      {super.key,
      required this.currentPassword,
      required this.isQueryProcess,
      required this.onClickOnRefresh});

  final String currentPassword;
  final bool isQueryProcess;
  final Function onClickOnRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Mot de passe",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
                          isQueryProcess
                              ? "Chargement..."
                              : currentPassword.isNotEmpty
                                  ? currentPassword
                                  : "Aucun mot de passe"))),
              IconButton(
                  onPressed: () => onClickOnRefresh(),
                  icon: Icon(
                    Icons.autorenew,
                    color: Colors.deepOrange,
                    size: 48,
                  ))
            ],
          )
        ]);
  }
}
