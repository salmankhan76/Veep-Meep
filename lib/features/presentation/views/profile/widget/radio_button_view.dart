import 'package:flutter/material.dart';
import 'package:veep_meep/utils/app_constants.dart';

import '../../../../../utils/app_colors.dart';

class RadioButton extends StatefulWidget {
  List<String> radioButtonTexts;
  Function(int) onRadioSelected; // callback function to give the selected radio value out

  RadioButton({required this.radioButtonTexts , required this.onRadioSelected});

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  int selectedRadio = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.radioButtonTexts.length; i++)
          RadioListTile(
            value: i,
            activeColor: AppConstants.kIsBizAccount
                ? AppColors.colorGreen
                : AppColors.colorBlue,
            title: Text(widget.radioButtonTexts[i]),
            groupValue: selectedRadio,
            onChanged: (value) {
              setState(() {
                selectedRadio = (value as int);
              });
              widget.onRadioSelected(selectedRadio); // call the callback function to give the selected radio value out
            },
          ),
      ],
    );
  }
}
