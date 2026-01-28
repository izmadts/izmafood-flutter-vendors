import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/pages/auth/hurray_page.dart';
import 'package:izma_foods_vendor/pages/widget/izma_app_bar.dart';
import 'package:izma_foods_vendor/pages/widget/izma_primary_button.dart';
import 'package:izma_foods_vendor/pages/widget/izma_radial_gradient_container.dart';
import 'package:izma_foods_vendor/pages/widget/izma_text_field.dart';

import '../widget/izma_file_input.dart';

class RegisterPageTwo extends StatelessWidget {
  const RegisterPageTwo({super.key});

  Future<bool?> _askHasNtnDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('NTN Number'),
        content: const Text('Do you have the NTN number?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: kcSecondaryColor),
            child: const Text(
              'Yes',
              style: TextStyle(color: kcPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _uploadNtnImageDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.all(kdPadding),
        title: const Text('Upload NTN Image'),
        content: const IzmaFileInput(title: 'Upload NTN Image'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: kcSecondaryColor),
            child: const Text(
              'Continue',
              style: TextStyle(color: kcPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _askHasBusinessRegistrationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Business Registration'),
        content: const Text('Do you have the Business Registration?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: kcSecondaryColor),
            child: const Text(
              'Yes',
              style: TextStyle(color: kcPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _uploadBusinessRegistrationImageDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.all(kdPadding),
        title: const Text('Upload Business Registration Image'),
        content: const IzmaFileInput(title: 'Upload Business Registration Image'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: kcSecondaryColor),
            child: const Text(
              'Continue',
              style: TextStyle(color: kcPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSubmit(BuildContext context) async {
    // NTN Dialog Flow
    final hasNtn = await _askHasNtnDialog(context);
    if (hasNtn == null) return;

    if (hasNtn) {
      final uploaded = await _uploadNtnImageDialog(context);
      if (uploaded != true) return;
    }

    // Business Registration Dialog Flow
    final hasBusinessRegistration = await _askHasBusinessRegistrationDialog(context);
    if (hasBusinessRegistration == null) return;

    if (hasBusinessRegistration) {
      final uploaded = await _uploadBusinessRegistrationImageDialog(context);
      if (uploaded != true) return;
    }

    Get.to(() => const HurrayPage());
  }

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
                      padding: const EdgeInsets.only(
                          left: kdPadding, bottom: kdPadding),
                      child: Text(
                        "Please fill in your Business Information",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                    IzmaTextField(
                        prefixIcon: Icons.home_outlined, hintText: "Shop Name"),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kdPadding),
                      child: Row(
                        children: [
                          Expanded(
                            child: IzmaTextField(
                              prefixIcon: Icons.account_circle_outlined,
                              hintText: "Type",
                              suffixIcon: Icon(Icons.keyboard_arrow_down),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: IzmaTextField(
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
                    // IzmaFileInput(
                    //   title: "Business License",
                    // ),
                    IzmaFileInput(
                      title: "Upload CNIC Front",
                    ),
                    IzmaFileInput(
                      title: "Upload CNIC Back",
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
                      onTap: () => _handleSubmit(context),
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
}
