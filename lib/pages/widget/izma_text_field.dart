import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
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
    this.disablePadding = false,
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
  final bool disablePadding;

  @override
  Widget build(BuildContext context) {
    final iconSize = 20.0;
    final iconWidth = 45.0;
    return Container(
      height: maxLines == null ? 75 : null,
      padding: EdgeInsets.symmetric(horizontal: disablePadding ? 0 : kdPadding),
      child: GestureDetector(
        onTap: onTap,
        child: TextFormField(
          enabled: enabled,
          controller: controller,
          obscureText: obscureText,
          maxLines: maxLines,
          decoration: InputDecoration(
            errorStyle: TextStyle(height: 0.5),
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
            hintStyle: TextStyle(fontSize: 13),
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
