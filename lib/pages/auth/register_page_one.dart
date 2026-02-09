// ignore: unused_import
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/controllers/auth_controller.dart';
import 'package:izma_foods_vendor/helpers/global_helpers.dart';
import 'package:izma_foods_vendor/pages/widget/izma_app_bar.dart';
import 'package:izma_foods_vendor/pages/widget/izma_primary_button.dart';
import 'package:izma_foods_vendor/pages/widget/izma_radial_gradient_container.dart';
import 'package:izma_foods_vendor/pages/widget/izma_text_field.dart';

class RegisterPageOne extends StatelessWidget {
  const RegisterPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

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
                      padding: const EdgeInsets.only(
                          left: kdPadding, bottom: kdPadding),
                      child: Text(
                        "Please fill in your personal information",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: () async => await controller.selectDateOfBirth(),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: kdPadding),
                          margin: EdgeInsets.symmetric(horizontal: kdPadding),
                          decoration: BoxDecoration(
                            color: kcGreyColor,
                            borderRadius: BorderRadius.circular(kdBorderRadius),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_month_outlined),
                              SizedBox(width: 10),
                              (controller.dateOfBirth.value.isEmpty ||
                                          controller.dateOfBirth.value == '') ==
                                      true
                                  ? Text("Date Of Birth")
                                  : Text(controller.dateOfBirth.value),
                              Spacer(),
                              Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: kdPadding),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kdPadding),
                      child: Row(
                        children: [
                          Obx(() => _buildGenderOption(
                              "Male",
                              controller.selectedGender.value == "Male",
                              controller)),
                          SizedBox(width: kdPadding),
                          Obx(() => _buildGenderOption(
                              "Female",
                              controller.selectedGender.value == "Female",
                              controller)),
                        ],
                      ),
                    ),
                    SizedBox(height: kdPadding + 8),
                    IzmaTextField(
                      controller: controller.addressController,
                      prefixIcon: Icons.location_on_outlined,
                      hintText: "Address",
                    ),
                    Center(
                        child: Text("Upload your Photo By Holding CNIC Card")),
                    SizedBox(height: kdPadding),
                    Obx(() => _buildImageUploadContainer(controller)),
                    SizedBox(height: kdPadding),
                    IzmaPrimaryButton(
                      title: "Next",
                      onTap: () {
                        if (controller.selectedImage.value == null) {
                          showSnackBar('Please upload your photo');
                          return;
                        } else if (controller.dateOfBirth.value.isEmpty ||
                            controller.dateOfBirth.value == '') {
                          showSnackBar('Please select your date of birth');
                          return;
                        } else if (controller.addressController.text.isEmpty ||
                            controller.addressController.text == '') {
                          showSnackBar('Please enter your address');
                          return;
                        } else {
                          controller.registerPageOne();
                        }
                      },
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

  // Future<void> _selectDate(
  //     BuildContext context, RegisterPageOneController controller) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: controller.selectedDateOfBirth.value ?? DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //     builder: (context, child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: ColorScheme.light(
  //             primary: kcSecondaryColor,
  //             onPrimary: kcPrimaryColor,
  //             onSurface: Colors.black,
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );

  //   if (picked != null) {
  //     controller.setDateOfBirth(picked);
  //     controller.dateOfBirthController.text =
  //         DateFormat('yyyy-MM-dd').format(picked);
  //   }
  // }

  Widget _buildGenderOption(
      String title, bool isSelected, AuthController controller) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setGender(title),
        child: Container(
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: isSelected ? kcLightGreenColor : kcGreyColor,
            borderRadius: BorderRadius.circular(kdBorderRadius),
            border: Border.all(
              color: isSelected ? kcSecondaryColor : Colors.transparent,
              width: isSelected ? 2 : 0,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                color: isSelected ? kcSecondaryColor : null,
              ),
              SizedBox(
                width: 10,
              ),
              Text(title)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageUploadContainer(AuthController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kdPadding),
      child: GestureDetector(
        onTap: () => controller.showImageSourceDialog(),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: kcGreyColor,
            borderRadius: BorderRadius.circular(kdBorderRadius),
            border: Border.all(
              color: controller.selectedImage.value != null
                  ? kcSecondaryColor
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: controller.selectedImage.value != null
              ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(kdBorderRadius),
                      child: Image.file(
                        controller.selectedImage.value!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => controller.clearImage(),
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            color: kcPrimaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      size: 48,
                      color: kcTextGreyColor,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Upload Your Selfie",
                      style:
                          Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                                color: kcTextGreyColor,
                              ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Tap to select from Camera or Gallery",
                      style:
                          Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
                                color: kcTextGreyColor,
                              ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
