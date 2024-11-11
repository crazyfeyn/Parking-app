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
  const TextWidget({
    super.key,
    this.validator,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.obscureText,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          validator: validator,
          obscureText: obscureText ?? false,
          controller: controller,
          decoration: InputDecoration(
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
