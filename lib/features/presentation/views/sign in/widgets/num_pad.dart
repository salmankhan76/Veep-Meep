import 'package:flutter/material.dart';
import 'package:veep_meep/utils/app_colors.dart';

// KeyPad widget
// This widget is reusable and its buttons are customizable (color, size)
class NumPad extends StatelessWidget {
  final double buttonSize;
  final Color buttonColor;
  final Color iconColor;
  final TextEditingController controller;
  final Function delete;
  final Function onSubmit;

  const NumPad({
    Key? key,
    this.buttonSize = 70,
    this.buttonColor = AppColors.colorGray900,
    this.iconColor = AppColors.colorGray900,
    required this.delete,
    required this.onSubmit,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      decoration: BoxDecoration(
          color: AppColors.colorGray50,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.colorGray900, width: 1)),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // implement the number keys (from 0 to 9) with the NumberButton widget
            // the NumberButton widget is defined in the bottom of this file
            children: [
              NumberButton(
                number: 1,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 2,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 3,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberButton(
                number: 4,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 5,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 6,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberButton(
                number: 7,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 8,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              NumberButton(
                number: 9,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // this button is used to delete the last number
              /*IconButton(
                onPressed: () => onSubmit(),
                icon: Icon(
                  Icons.star_rate_rounded,
                  color: AppColors.colorGray700,
                ),
                iconSize: 26,
              ),*/
              SymbolButton(
                  symbol: '*',
                  size: buttonSize,
                  color: buttonColor,
                  controller: controller),
              NumberButton(
                number: 0,
                size: buttonSize,
                color: buttonColor,
                controller: controller,
              ),
              // this button is used to submit the entered value
              SymbolButton(
                  symbol: '#',
                  size: buttonSize,
                  color: buttonColor,
                  controller: controller),
            ],
          ),
        ],
      ),
    );
  }
}

// define NumberButton widget
// its shape is round
class NumberButton extends StatelessWidget {
  final int? number;
  final double size;
  final Color color;
  final TextEditingController controller;

  const NumberButton({
    Key? key,
    this.number,
    required this.size,
    required this.color,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          elevation: 0,
          foregroundColor: AppColors.colorGray50,
          backgroundColor: AppColors.colorGray50,
          shadowColor: AppColors.colorGray50,
          surfaceTintColor: AppColors.colorGray50,
          shape: CircleBorder(),
        ),
        onPressed: () {
          controller.text += number.toString();
        },
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.colorGray700,
                fontSize: 30),
          ),
        ),
      ),
    );
  }
}

class SymbolButton extends StatelessWidget {
  final String? symbol;
  final double size;
  final Color color;
  final TextEditingController controller;

  const SymbolButton({
    Key? key,
    this.symbol,
    required this.size,
    required this.color,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          elevation: 0,
          foregroundColor: AppColors.colorGray50,
          backgroundColor: AppColors.colorGray50,
          shadowColor: AppColors.colorGray50,
          surfaceTintColor: AppColors.colorGray50,
          shape: CircleBorder(),
        ),
        onPressed: () {
          controller.text += symbol.toString();
        },
        child: Center(
          child: Text(
            symbol.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.colorGray700,
                fontSize: 30),
          ),
        ),
      ),
    );
  }
}
