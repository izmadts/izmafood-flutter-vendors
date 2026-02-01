import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/controllers/auth_controller.dart';
import 'package:izma_foods_vendor/pages/widget/izma_app_bar.dart';
import 'package:izma_foods_vendor/pages/widget/izma_primary_button.dart';
import 'package:izma_foods_vendor/pages/widget/izma_radial_gradient_container.dart';

class RegisterPageThree extends StatelessWidget {
  const RegisterPageThree({super.key});

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
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: kdPadding * 3),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: kdPadding, bottom: kdPadding),
                      child: Text(
                        "Upload documents",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                    // Required section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kdPadding, vertical: 4),
                      child: Text(
                        "Required",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: kcSecondaryColor,
                            ),
                      ),
                    ),
                    Obx(
                      () => _buildDocUploadContainer(
                        title: "Logo",
                        file: controller.shopLogoFile.value,
                        onTap: () =>
                            controller.showShopImageSourceDialog('logo'),
                      ),
                    ),
                    Obx(
                      () => _buildDocUploadContainer(
                        title: "CNIC (Front)",
                        file: controller.cnicFrontFile.value,
                        onTap: () => controller
                            .showShopImageSourceDialog('fcnic'),
                      ),
                    ),
                    Obx(
                      () => _buildDocUploadContainer(
                        title: "CNIC (Back)",
                        file: controller.cnicBackFile.value,
                        onTap: () =>
                            controller.showShopImageSourceDialog('bcnic'),
                      ),
                    ),
                    const SizedBox(height: kdPadding),
                    // Optional section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kdPadding, vertical: 4),
                      child: Text(
                        "Optional",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: kcTextGreyColor,
                            ),
                      ),
                    ),
                    Obx(
                      () => _buildDocUploadContainer(
                        title: "Banner",
                        file: controller.shopBannerFile.value,
                        onTap: () =>
                            controller.showShopImageSourceDialog('banner'),
                      ),
                    ),
                    Obx(
                      () => _buildDocUploadContainer(
                        title: "Food Certificate",
                        file: controller.foodCertificateFile.value,
                        onTap: () => controller
                            .showShopImageSourceDialog('licence_photo'),
                      ),
                    ),
                    Obx(
                      () => _buildDocUploadContainer(
                        title: "NTN Number",
                        file: controller.ntnFile.value,
                        onTap: () =>
                            controller.showShopImageSourceDialog('ntn_photo'),
                      ),
                    ),
                    const SizedBox(height: kdPadding),
                    Obx(
                      () {
                        final hasAllRequired = controller.shopLogoFile.value != null &&
                            controller.cnicFrontFile.value != null &&
                            controller.cnicBackFile.value != null;
                        if (!hasAllRequired) return const SizedBox.shrink();
                        return IzmaPrimaryButton(
                          title: "Continue",
                          onTap: () => controller.registerPageThree(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
