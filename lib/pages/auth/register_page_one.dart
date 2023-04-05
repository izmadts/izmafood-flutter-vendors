import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/pages/auth/register_page_two.dart';
import 'package:izma_foods_vendor/pages/widget/izma_app_bar.dart';
import 'package:izma_foods_vendor/pages/widget/izma_phone_field.dart';
import 'package:izma_foods_vendor/pages/widget/izma_primary_button.dart';
import 'package:izma_foods_vendor/pages/widget/izma_radial_gradient_container.dart';
import 'package:izma_foods_vendor/pages/widget/izma_text_field.dart';

import '../widget/izma_file_input.dart';

class RegisterPageOne extends StatelessWidget {
  const RegisterPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IzmaRadialGradientContainer(
        child: SafeArea(
          child: Column(
            children: [
              IzmaAppBar(title: "IZMA Food", showCustomActions: false),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: kdPadding * 3),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: kdPadding, bottom: kdPadding),
                      child: Text(
                        "Please fill in your personal information",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                    IzmaPhoneField(),
                    IzmaTextField(prefixIcon: Icons.account_circle_outlined, hintText: "Full Name"),
                    IzmaTextField(
                      prefixIcon: Icons.account_circle_outlined,
                      hintText: "Date Of Birth",
                      suffixIcon: Icon(Icons.keyboard_arrow_down),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kdPadding),
                      child: Row(
                        children: [
                          _buildGenderOption("Male", false),
                          SizedBox(width: kdPadding),
                          _buildGenderOption("Female", true),
                        ],
                      ),
                    ),
                    SizedBox(height: kdPadding + 8),
                    IzmaTextField(prefixIcon: Icons.location_on_outlined, hintText: "Address"),
                    Center(child: Text("Upload your Photo By Holding CNIC Card")),
                    SizedBox(height: kdPadding),
                    IzmaFileInput(
                      title: "Upload Your Selfie",
                    ),
                    IzmaFileInput(
                      title: "Upload CNIC Front",
                    ),
                    IzmaFileInput(
                      title: "Upload CNIC Back",
                    ),
                    SizedBox(height: kdPadding),
                    IzmaPrimaryButton(
                      title: "Next",
                      onTap: () => Get.to(() => RegisterPageTwo()),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildGenderOption(String title, bool value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: kcGreyColor,
          borderRadius: BorderRadius.circular(kdBorderRadius),
        ),
        child: Row(
          children: [
            Icon(
              value ? Icons.check_circle : Icons.circle_outlined,
              color: value ? kcSecondaryColor : null,
            ),
            SizedBox(
              width: 10,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}
