import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/controllers/auth_controller.dart';
import 'package:izma_foods_vendor/models/main_model.dart';
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
        content:
            const IzmaFileInput(title: 'Upload Business Registration Image'),
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

  Future<void> _handleSubmit(
      BuildContext context, AuthController controller) async {
    // // NTN Dialog Flow
    // final hasNtn = await _askHasNtnDialog(context);
    // if (hasNtn == null) return;

    // if (hasNtn) {
    //   final uploaded = await _uploadNtnImageDialog(context);
    //   if (uploaded != true) return;
    // }

    // // Business Registration Dialog Flow
    // final hasBusinessRegistration =
    //     await _askHasBusinessRegistrationDialog(context);
    // if (hasBusinessRegistration == null) return;

    // if (hasBusinessRegistration) {
    //   final uploaded = await _uploadBusinessRegistrationImageDialog(context);
    //   if (uploaded != true) return;
    // }

    // Get.to(() => const HurrayPage());
    controller.registerPageTwo();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
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
                      controller: controller.shopNameController,
                      prefixIcon: Icons.home_outlined,
                      hintText: "Shop Name",
                    ),
                    shopTypeAndCategory(controller, context),
                    const SizedBox(height: kdPadding),
                    Obx(
                      () => _buildDocUploadContainer(
                        title: "Shop Logo",
                        file: controller.shopLogoFile.value,
                        onTap: () =>
                            controller.showShopImageSourceDialog('logo'),
                      ),
                    ),
                    Obx(
                      () => _buildDocUploadContainer(
                        title: "Shop Banner",
                        file: controller.shopBannerFile.value,
                        onTap: () =>
                            controller.showShopImageSourceDialog('banner'),
                      ),
                    ),
                    Obx(
                      () => _buildDocUploadContainer(
                        title: "Upload CNIC Front",
                        file: controller.cnicFrontFile.value,
                        onTap: () =>
                            controller.showShopImageSourceDialog('cnic_front'),
                      ),
                    ),
                    Obx(
                      () => _buildDocUploadContainer(
                        title: "Upload CNIC Back",
                        file: controller.cnicBackFile.value,
                        onTap: () =>
                            controller.showShopImageSourceDialog('cnic_back'),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kdPadding),
                      child: Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 60,
                          decoration: BoxDecoration(
                            color: kcSecondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Obx(
                            () => DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: controller.selectedBank.value.isEmpty
                                    ? null
                                    : controller.selectedBank.value,
                                dropdownColor:
                                    kcSecondaryColor.withOpacity(0.9),
                                iconEnabledColor: Colors.white,
                                hint: Text(
                                  'Bank',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.white70),
                                ),
                                items: controller.banks
                                    .map(
                                      (type) => DropdownMenuItem(
                                        value: type,
                                        child: Text(
                                          type,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    controller.selectedBank.value = value;
                                  }
                                },
                                icon: const Icon(Icons.keyboard_arrow_down),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    IzmaTextField(
                      controller: controller.accountTitleController,
                      prefixIcon: Icons.home_outlined,
                      hintText: "Account Title",
                    ),
                    IzmaTextField(
                      controller: controller.accountNumberController,
                      prefixIcon: Icons.home_outlined,
                      hintText: "Account Number",
                    ),
                    // SizedBox(height: kdPadding),
                    IzmaPrimaryButton(
                      title: "Submit",
                      onTap: () => _handleSubmit(context, controller),
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

  Padding shopTypeAndCategory(AuthController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kdPadding),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              // width: 150,
              height: 60,
              decoration: BoxDecoration(
                color: kcSecondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(
                () => DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: controller.selectedShopType.value.isEmpty
                        ? null
                        : controller.selectedShopType.value,
                    // lighter kcSecondaryColor for dropdown menu
                    dropdownColor: kcSecondaryColor.withOpacity(0.9),
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      'Type',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white70),
                    ),
                    items: controller.shopTypes
                        .map(
                          (type) => DropdownMenuItem(
                            value: type,
                            child: Text(
                              type,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedShopType.value = value;
                      }
                    },
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              // width: 150,
              height: 60,
              decoration: BoxDecoration(
                color: kcSecondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(
                () => DropdownButtonHideUnderline(
                  child: DropdownButton<Category>(
                    value: controller.selectedShopCategory.value,
                    dropdownColor: kcSecondaryColor.withOpacity(0.9),
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      'Category',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white70),
                    ),
                    items: controller.shopCategoriesModel.value?.mainCategory
                        ?.map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(
                                type.title ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.white),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedShopCategory.value = value;
                      }
                    },
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocUploadContainer({
    required String title,
    required File? file,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kdPadding,
        vertical: 5,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: kcGreyColor,
            borderRadius: BorderRadius.circular(kdBorderRadius),
            border: Border.all(
              color: file != null ? kcSecondaryColor : Colors.transparent,
              width: file != null ? 2 : 0,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Icon(
                Icons.insert_photo_outlined,
                color: kcTextGreyColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  file != null ? file.path.split('/').last : title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 50,
                width: 70,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: kcSecondaryColor,
                  borderRadius: BorderRadius.circular(kdBorderRadius),
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: kcPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
