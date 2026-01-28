import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../config/theme.dart';

class IzmaPhoneField extends StatelessWidget {
  const IzmaPhoneField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 75,
      padding: EdgeInsets.symmetric(horizontal: kdPadding),
      child: IntlPhoneField(
        controller: controller,
        disableLengthCheck: true,
        flagsButtonMargin: EdgeInsets.symmetric(horizontal: 10),
        showDropdownIcon: false,
        dropdownTextStyle: TextStyle(fontSize: 12),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 10),
          hintText: 'Phone Number',
          hintStyle: TextStyle(fontSize: 12),
          alignLabelWithHint: true,
          fillColor: Color(0xfff0f1f2),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kdBorderRadius),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kdBorderRadius),
            borderSide: BorderSide(color: kcSecondaryColor),
          ),
        ),
        initialCountryCode: 'PK',
        onChanged: (phone) {
          print(phone.completeNumber);
        },
      ),
    );
  }
}
