import 'package:flutter/material.dart';

import '../../config/theme.dart';

class IzmaTextField extends StatelessWidget {
  const IzmaTextField({
    super.key,
    this.borderRadius = 16.0,
    this.controller,
    required this.prefixIcon,
    required this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.label,
    this.onTap,
    this.enabled = true,
    this.maxLines,
    this.validator,
    this.focusNode,
    this.nextFocusNode,
    this.textInputType,
    this.prefix,
  });

  final double borderRadius;
  final TextEditingController? controller;
  final IconData prefixIcon;
  final String hintText;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? label;
  final void Function()? onTap;
  final bool enabled;
  final int? maxLines;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputType? textInputType;
  final String? prefix;

  @override
  Widget build(BuildContext context) {
    final iconSize = 20.0;
    final iconWidth = 45.0;
    return Container(
      height: maxLines == null ? 80 : null,
      padding: EdgeInsets.symmetric(horizontal: kdPadding),
      child: GestureDetector(
        onTap: onTap,
        child: TextFormField(
          enabled: enabled,
          validator: validator,
          controller: controller,
          obscureText: obscureText,
          maxLines: maxLines ?? 1,
          keyboardType: textInputType,
          focusNode: focusNode,
          onEditingComplete: () {
            if (focusNode != null) {
              focusNode!.unfocus();
            }
            if (nextFocusNode != null) {
              nextFocusNode!.requestFocus();
            }
          },
          decoration: InputDecoration(
            prefixText: prefix?.padRight(03),
            prefixStyle: TextStyle(),
            errorStyle: TextStyle(height: 0.7, fontWeight: FontWeight.w400),
            fillColor: kcGreyColor,
            filled: true,
            focusColor: Colors.white,
            prefixIcon: Icon(prefixIcon, size: iconSize),
            prefixIconConstraints: BoxConstraints(minWidth: iconWidth),
            prefixIconColor: Colors.black,
            suffixIcon: suffixIcon,
            suffixIconConstraints: BoxConstraints(minWidth: iconWidth),
            suffixIconColor: Colors.black,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            label: label == null ? null : Text(label!),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kdBorderRadius),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kdBorderRadius),
              borderSide: BorderSide(color: kcSecondaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kdBorderRadius),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
