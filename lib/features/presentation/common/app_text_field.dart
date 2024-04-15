import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veep_meep/utils/app_constants.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_dimensions.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? icon;
  Widget? action;
  final String? hint;
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
  final Color? borderColor;
  final Function(String)? onSubmit;
  final TextAlign textAlign;
  final Color? hintColor;
  final double? hintFontSize;
  final double? borderRadius;
  final FontWeight? hintFontWeight;
  final String? labelText;

  AppTextField({
    this.controller,
    this.icon,
    this.action,
    this.hint,
    this.labelText,
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
    this.textAlign = TextAlign.center,
    this.borderColor = AppColors.colorGray700,
    this.shouldRedirectToNextField = true,
    this.hintColor,
    this.hintFontSize,
    this.hintFontWeight,
    this.borderRadius,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (widget.labelText != null)
            ? Text('${widget.labelText}')
            : const Text(''),
        const SizedBox(
          height: 06,
        ),
        TextField(
          textAlign: widget.textAlign,
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
              fontSize: AppDimensions.kFontSize14,
              fontWeight: FontWeight.w400,
              color: AppColors.colorGray700),
          keyboardType: widget.inputType ?? TextInputType.text,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(14),
              isDense: true,
              errorText: widget.errorMessage,
              counterText: "",
              hintText: '${widget.hint}${widget.isCurrency! ? ' (Rs)' : ''}',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor!, width: 1.0),
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 30),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.colorGray500,
                    width: 2.0),
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 30),
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.borderColor ?? AppColors.colorGray500,
                    width: .0),
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius ?? 30),
                ),
              ),
              prefixIcon: widget.icon,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 55,
              ),
              suffixIcon: widget.action,
              filled: true,
              hintStyle: TextStyle(
                  color: widget.hintColor ?? AppColors.colorGray700,
                  fontSize: widget.hintFontSize ?? AppDimensions.kFontSize14,
                  fontWeight: widget.hintFontWeight),
              fillColor: AppConstants.kIsBizAccount
                  ? AppColors.colorYellow
                  : AppColors.fontColorWhite),
        ),
      ],
    );
  }
}
