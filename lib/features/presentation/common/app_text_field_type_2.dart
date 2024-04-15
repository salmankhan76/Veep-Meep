import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_dimensions.dart';

class AppTextFieldType2 extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? icon;
  Widget? action;
  final String? hint;
  final Color? hintColor;
  final double? fontSize;
  final String? errorMessage;
  final Function(String)? onTextChanged;
  final TextInputType? inputType;
  final bool? isEnable;
  final int? maxLength;
  final String? guideTitle;
  final bool? obscureText;
  final bool? shouldRedirectToNextField;
  final String? regex;
  final int? maxLines;
  final bool? isCurrency;
  final FocusNode? focusNode;
  final Function(String)? onSubmit;
  final TextAlign? textAlign;

  AppTextFieldType2(
      {this.controller,
      this.textAlign,
      this.icon,
      this.action,
      this.hint,
      this.hintColor,
      this.fontSize,
      this.guideTitle,
      this.errorMessage,
      this.maxLength = 50,
      this.maxLines = 1,
      this.onTextChanged,
      this.inputType,
      this.regex,
      this.focusNode,
      this.onSubmit,
      this.isEnable = true,
      this.obscureText = false,
      this.isCurrency = false,
      this.shouldRedirectToNextField = true});

  @override
  State<AppTextFieldType2> createState() => _AppTextFieldType2State();
}

class _AppTextFieldType2State extends State<AppTextFieldType2> {
  double borderRadius = 30;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          textAlign: widget.textAlign ?? TextAlign.center,
          onChanged: (text) {
            setState(() {
              if (widget.regex != null && text.isEmpty) {
                widget.action = null;
              } else {
                if (widget.regex != null && widget.regex!.isNotEmpty) {
                  if (RegExp(widget.regex!).hasMatch(text)) {
                    widget.action = const Icon(
                      CupertinoIcons.checkmark_circle_fill,
                      color: AppColors.colorSuccess,
                    );
                  } else {
                    widget.action = const Icon(
                      CupertinoIcons.multiply_circle_fill,
                      color: AppColors.colorFailed,
                    );
                  }
                }
              }
            });

            if (widget.onTextChanged != null) {
              widget.onTextChanged!(text);
            }
          },
          onSubmitted: (value) {
            if (widget.onSubmit != null) widget.onSubmit!(value);
          },
          focusNode: widget.focusNode,
          controller: widget.controller,
          obscureText: widget.obscureText!,
          textInputAction: widget.shouldRedirectToNextField!
              ? TextInputAction.next
              : TextInputAction.done,
          enabled: widget.isEnable,
          maxLines: widget.maxLines,
          textCapitalization: TextCapitalization.sentences,
          maxLength: widget.maxLength,
          inputFormatters: [
            if (widget.isCurrency!) CurrencyTextInputFormatter(symbol: ''),
            LengthLimitingTextInputFormatter(widget.maxLength),
          ],
          style: TextStyle(
            fontSize: widget.fontSize ?? AppDimensions.kFontSize17,
            fontWeight: FontWeight.w400,
            color: AppConstants.kIsBizAccount
                ? AppColors.colorGreen
                : AppColors.colorBlue,
          ),
          keyboardType: widget.inputType ?? TextInputType.text,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            isDense: true,
            errorText: widget.errorMessage,
            counterText: "",
            hintText: '${widget.hint}${widget.isCurrency! ? ' (Rs)' : ''}',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: AppConstants.kIsBizAccount
                      ? AppColors.colorGreen
                      : AppColors.colorGray500,
                  width: 1.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: AppConstants.kIsBizAccount
                      ? AppColors.colorGreen
                      : AppColors.colorGray500,
                  width: 1.0),
            ),
            prefixIcon: widget.icon,
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
            ),
            suffixIcon: widget.action,
            filled: true,
            hintStyle: TextStyle(
                fontSize: AppDimensions.kFontSize14,
                color: AppConstants.kIsBizAccount
                    ? AppColors.colorGreen
                    : AppColors.colorBorder),
            fillColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
