import 'package:flutter/material.dart';
import 'package:tp5_password_generator/helper.dart';

class PreferenceSliderWidget extends StatefulWidget {
  @override
  const PreferenceSliderWidget({super.key, required this.initalValue});

  final int initalValue;

  @override
  State<PreferenceSliderWidget> createState() => _PreferenceSliderWidgetState();
}

class _PreferenceSliderWidgetState extends State<PreferenceSliderWidget> {
  late double valueSlider;

  @override
  void initState() {
    valueSlider = widget.initalValue.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: Slider(
            value: valueSlider,
            min: 8.0,
            max: 30.0,
            label: "${valueSlider.toInt()}",
            onChanged: (value) => onChangeSlider(value),
            onChangeEnd: (value) => onEndSlider(value),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Text("${valueSlider.toInt()}"),
        )
      ],
    );
  }

  void onChangeSlider(double value) {
    setState(() {
      valueSlider = value;
    });
  }

  Future<void> onEndSlider(double value) async {
    // Update the preference
    await Util.updatePreference(PreferenceType.prefPasswordSize, value.toInt());
  }
}
