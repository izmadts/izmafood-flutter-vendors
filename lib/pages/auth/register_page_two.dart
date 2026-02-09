import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/controllers/auth_controller.dart';
import 'package:izma_foods_vendor/helpers/global_helpers.dart';
import 'package:izma_foods_vendor/models/main_model.dart';
import 'package:izma_foods_vendor/pages/widget/izma_app_bar.dart';
import 'package:izma_foods_vendor/pages/widget/izma_primary_button.dart';
import 'package:izma_foods_vendor/pages/widget/izma_radial_gradient_container.dart';
import 'package:izma_foods_vendor/pages/widget/izma_text_field.dart';

class RegisterPageTwo extends StatelessWidget {
  const RegisterPageTwo({super.key});

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
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kdPadding),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 60,
                        decoration: BoxDecoration(
                          color: kcGreyColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Obx(
                          () => DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: controller.selectedBank.value.isEmpty
                                  ? null
                                  : controller.selectedBank.value,
                              dropdownColor: kcGreyColor,
                              iconEnabledColor: Colors.black,
                              hint: Text(
                                'Bank',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.black),
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
                                              color: Colors.black,
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
                              icon: const Icon(Icons.keyboard_arrow_down,
                                  color: kcSecondaryColor),
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
                    Obx(
                      () => controller.isRegisterPageTwo.value == true
                          ? Center(child: CircularProgressIndicator())
                          : IzmaPrimaryButton(
                              title: "Submit",
                              onTap: () {
                                if (controller
                                        .shopNameController.text.isEmpty ||
                                    controller.shopNameController.text == '') {
                                  showSnackBar('Please enter your shop name');
                                  return;
                                } else if (controller
                                        .selectedBank.value.isEmpty ||
                                    controller.selectedBank.value == '') {
                                  showSnackBar('Please select your bank');
                                  return;
                                } else if (controller
                                        .accountTitleController.text.isEmpty ||
                                    controller.accountTitleController.text ==
                                        '') {
                                  showSnackBar(
                                      'Please enter your account title');
                                  return;
                                } else if (controller
                                        .accountNumberController.text.isEmpty ||
                                    controller.accountNumberController.text ==
                                        '') {
                                  showSnackBar(
                                      'Please enter your account number');
                                  return;
                                } else {
                                  controller.registerPageTwo();
                                }
                              },
                            ),
                    ),
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
                color: kcGreyColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(
                () => DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: controller.selectedShopType.value.isEmpty
                        ? null
                        : controller.selectedShopType.value,
                    // lighter kcSecondaryColor for dropdown menu
                    dropdownColor: kcGreyColor,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      'Type',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black),
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
                                    color: Colors.black,
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
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: kcSecondaryColor),
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
                color: kcGreyColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(
                () => DropdownButtonHideUnderline(
                  child: DropdownButton<Category>(
                    value: controller.selectedShopCategory.value,
                    dropdownColor: kcGreyColor,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      'Category',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black),
                    ),
                    items: controller.shopCategoriesModel.value?.mainCategory
                        ?.map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(
                                type.title ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.black),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedShopCategory.value = value;
                      }
                    },
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: kcSecondaryColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
