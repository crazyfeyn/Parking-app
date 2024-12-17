// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
class TextWidget extends StatelessWidget {
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? labelText;
  final bool? obscureText;
  final Color? borderColor;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? enabled;
  final int? maxLength;

  const TextWidget({
    super.key,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.obscureText,
    this.borderColor,
    this.validator,
    this.keyboardType,
    this.enabled,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          enabled: enabled ?? true,
          maxLength: maxLength,
          validator: validator,
          obscureText: obscureText ?? false,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            counterText: '', // Hide the character count
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? Colors.black),
            ),
            labelText: labelText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_10),
            ),
          ),
        ),
        16.hs(),
      ],
    );
  }
}