import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/pages/main_page.dart';
import 'package:izma_foods_vendor/pages/orders/orders_page.dart';
import 'package:izma_foods_vendor/pages/widget/izma_app_bar.dart';
import 'package:izma_foods_vendor/pages/widget/izma_phone_field.dart';
import 'package:izma_foods_vendor/pages/widget/izma_primary_button.dart';
import 'package:izma_foods_vendor/pages/widget/izma_radial_gradient_container.dart';
import 'package:izma_foods_vendor/pages/widget/izma_text_field.dart';

import '../widget/izma_file_input.dart';

class RegisterPageTwo extends StatelessWidget {
  const RegisterPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IzmaRadialGradientContainer(
        child: SafeArea(
          child: Column(
            children: [
              IzmaAppBar(title: "IZMA Foodsss", showCustomActions: false),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: kdPadding * 3),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: kdPadding, bottom: kdPadding),
                      child: Text(
                        "Please fill in your Business Information",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                    IzmaTextField(prefixIcon: Icons.home_outlined, hintText: "Shop Name"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kdPadding),
                      child: Row(
                        children: [
                          Expanded(
                            child: IzmaTextField(
                              disablePadding: true,
                              prefixIcon: Icons.account_circle_outlined,
                              hintText: "Type",
                              suffixIcon: Icon(Icons.keyboard_arrow_down),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: IzmaTextField(
                              disablePadding: true,
                              prefixIcon: Icons.account_circle_outlined,
                              hintText: "Category",
                              suffixIcon: Icon(Icons.keyboard_arrow_down),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IzmaFileInput(
                      title: "Shop Logo",
                    ),
                    IzmaFileInput(
                      title: "Shop Banner",
                    ),
                    IzmaFileInput(
                      title: "Business License",
                    ),
                    IzmaTextField(
                      prefixIcon: Icons.today,
                      hintText: "Select Bank",
                      suffixIcon: Icon(Icons.keyboard_arrow_down),
                    ),
                    IzmaTextField(
                      prefixIcon: Icons.home_outlined,
                      hintText: "Account Title",
                    ),
                    IzmaTextField(
                      prefixIcon: Icons.home_outlined,
                      hintText: "Account Number",
                    ),
                    SizedBox(height: kdPadding),
                    IzmaPrimaryButton(
                      title: "Submit",
                      onTap: () => Get.to(() => MainPage()),
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
