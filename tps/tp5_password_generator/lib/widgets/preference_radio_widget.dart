import 'package:flutter/material.dart';
import 'package:tp5_password_generator/helper.dart';

class PreferenceRadioWidget extends StatefulWidget {
  @override
  const PreferenceRadioWidget(
      {super.key, required this.preferenceType, required this.initialValue});

  final PreferenceType preferenceType;
  final bool initialValue;

  @override
  State<PreferenceRadioWidget> createState() => _PreferenceRadioWidgetState();
}

class _PreferenceRadioWidgetState extends State<PreferenceRadioWidget> {
  late bool prefSelection;

  @override
  void initState() {
    prefSelection = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => onChangeRadio(true),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // On peut utiliser https://api.flutter.dev/flutter/material/RadioListTile-class.html
              Radio(
                value: true,
                groupValue: prefSelection,
                activeColor: Colors.deepOrange,
                onChanged: (value) => onChangeRadio(value ?? true),
              ),
              Text("Oui")
            ],
          ),
        ),
        GestureDetector(
          onTap: () => onChangeRadio(false),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // On peut utiliser https://api.flutter.dev/flutter/material/RadioListTile-class.html
              Radio(
                value: false,
                groupValue: prefSelection,
                activeColor: Colors.deepOrange,
                onChanged: (value) => onChangeRadio(value ?? false),
              ),
              Text("Non")
            ],
          ),
        ),
      ],
    );
  }

  Future<void> onChangeRadio(bool value) async {
    setState(() {
      prefSelection = value;
    });
    // Update the preference
    await Util.updatePreference(widget.preferenceType, value);
  }
}
