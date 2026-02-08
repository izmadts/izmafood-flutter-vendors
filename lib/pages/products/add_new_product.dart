import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/controllers/add_product_controller.dart';
import 'package:izma_foods_vendor/models/brands_list_model.dart';
import 'package:izma_foods_vendor/models/category_model.dart';
import 'package:izma_foods_vendor/pages/widget/izma_app_bar.dart';
import 'package:izma_foods_vendor/pages/widget/izma_radial_gradient_container.dart';
import 'package:izma_foods_vendor/models/attribute_model.dart'
    as attribute_model;
import 'package:izma_foods_vendor/models/attribute_value_model.dart'
    as attribute_value_model;

class AddNewProductPage extends GetView<AddProductController> {
  AddNewProductPage({super.key});
  final controller = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IzmaRadialGradientContainer(
        child: SafeArea(
          child: Column(
            children: [
              const IzmaAppBar(
                title: 'Add New Product',
                actions: [
                  Icon(Icons.notifications_none_rounded),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: kdPadding, vertical: 8.h),
                  child: Column(
                    children: [
                      _ScanOrSearchField(),
                      SizedBox(height: 10.h),
                      _OutlinedTextField(
                        hintText: 'Barcode',
                      ),
                      SizedBox(height: 10.h),
                      _OutlinedTextField(
                        hintText: 'Product Title',
                      ),
                      SizedBox(height: 10.h),
                      _OutlinedTextField(
                        hintText: 'Product Description',
                        maxLines: 4,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          selectBrand(context),
                          SizedBox(width: 10),
                          selectCategory(context),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      attributes(context),
                      SizedBox(height: 10.h),
                      selectedAttributeValue(context),
                      SizedBox(height: 10.h),
                      Obx(
                        () => Row(
                          children: [
                            Expanded(
                              child: buildRadioChip(
                                context: context,
                                isSelected: controller.stocksAvailable.value
                                    ? true
                                    : false,
                                label: 'Stock\nAvailable',
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: buildRadioChip(
                                context: context,
                                isSelected: !controller.stocksAvailable.value
                                    ? true
                                    : false,
                                label: 'Not Availabile',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Expanded(
                            child: _OutlinedTextField(
                              hintText: 'Sale Price',
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: _OutlinedTextField(
                              hintText: 'Offer Price',
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: _OutlinedTextField(
                              hintText: 'Whole Sale',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      _UploadImageField(),
                      SizedBox(height: 24.h),
                      buildSubmitButton(context),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget attributes(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      // width: ,
      height: 60,
      decoration: BoxDecoration(
        color: kcSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Obx(
        () => DropdownButtonHideUnderline(
          child: DropdownButton<attribute_model.Datum>(
            value: controller.selectedAttribute.value,
            isExpanded: true,
            dropdownColor: kcSecondaryColor.withOpacity(0.9),
            iconEnabledColor: Colors.white,
            hint: Text(
              'Attributes',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.white70),
            ),
            items: controller.attributeListModel.value?.data
                    ?.map(
                      (e) => DropdownMenuItem<attribute_model.Datum>(
                        value: e,
                        child: GestureDetector(
                          onTap: () {
                            controller.selectedAttributeValue.value =
                                e.attributeTitle ?? '';
                          },
                          child: Text(e.attributeTitle ?? ''),
                        ),
                      ),
                    )
                    .toList() ??
                [],
            onChanged: (value) {
              if (value != null) {
                controller.selectedAttribute.value = value;
                controller.selectedAttributeValue.value = value.id.toString();
                controller.attributeValue(value);
              }
            },
            isDense: true,
            icon: const Icon(Icons.keyboard_arrow_down),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }

  Widget selectedAttributeValue(BuildContext context) {
    return Obx(
      () => controller.isAttributeSelected.value
          ? const Center(child: CircularProgressIndicator())
          : Visibility(
              visible: controller.selectedAttribute.value != null &&
                  controller.selectedAttributeValue.value != '',
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                // width: ,
                height: 60,
                decoration: BoxDecoration(
                  color: kcSecondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton<attribute_value_model.Datum>(
                      value: controller.selectedAttributeValueItem.value,
                      isExpanded: true,
                      dropdownColor: kcSecondaryColor.withOpacity(0.9),
                      iconEnabledColor: Colors.white,
                      hint: Text(
                        'Attributes',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white70),
                      ),
                      items: controller.attributeValueListModel.value?.data
                              ?.map(
                                (e) => DropdownMenuItem<
                                    attribute_value_model.Datum>(
                                  value: e,
                                  child: Text(e.comment ?? ''),
                                ),
                              )
                              .toList() ??
                          [],
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedAttributeValueItem.value = value;
                        }
                      },
                      isDense: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Expanded selectCategory(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        decoration: BoxDecoration(
          color: kcSecondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Obx(
          () => DropdownButtonHideUnderline(
            child: DropdownButton<SubCategory>(
              value: controller.selectedCategory.value,
              // lighter kcSecondaryColor for dropdown menu
              isExpanded: true,
              dropdownColor: kcSecondaryColor.withOpacity(0.9),
              iconEnabledColor: Colors.white,
              hint: Text(
                'Select Category',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.white70),
              ),
              items: controller.categoryListModel.value?.subCategory
                  ?.map(
                    (brand) => DropdownMenuItem(
                      value: brand,
                      child: Text(brand.title ?? ''),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.selectedCategory.value = value;
                }
              },
              isDense: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded selectBrand(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        // width: ,
        height: 60,
        decoration: BoxDecoration(
          color: kcSecondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Obx(
          () => DropdownButtonHideUnderline(
            child: DropdownButton<Datum>(
              value: controller.selectedBrand.value,
              isExpanded: true,
              dropdownColor: kcSecondaryColor.withOpacity(0.9),
              iconEnabledColor: Colors.white,
              hint: Text(
                'Select Brand',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.white70),
              ),
              items: controller.brandListModel.value?.data
                  ?.map(
                    (brand) => DropdownMenuItem(
                      value: brand,
                      child: Text(brand.title ?? ''),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.selectedBrand.value = value;
                }
              },
              isDense: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRadioChip({
    required BuildContext context,
    required bool isSelected,
    required String label,
  }) {
    return GestureDetector(
      onTap: () {
        if (label == 'Stock\nAvailable') {
          controller.stocksAvailable.value = true;
        } else {
          controller.stocksAvailable.value = false;
        }
      },
      child: Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          color: kcPrimaryColor,
          borderRadius: BorderRadius.circular(kdBorderRadius),
          border: Border.all(color: kcSecondaryColor),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: kcSecondaryColor,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSubmitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: kcSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kdBorderRadius),
          ),
        ),
        icon: const Icon(
          Icons.save_outlined,
          color: kcPrimaryColor,
        ),
        label: Text(
          'Submit',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: kcPrimaryColor,
              ),
        ),
      ),
    );
  }
}

class _ScanOrSearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kdBorderRadius),
        border: Border.all(color: kcSecondaryColor),
        color: kcPrimaryColor,
      ),
      child: Row(
        children: [
          SizedBox(width: 12.w),
          const Icon(Icons.search_rounded, color: kcTextGreyColor),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Scan or Search',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: kcTextGreyColor,
                  ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(6.w),
            width: 60.w,
            decoration: BoxDecoration(
              color: kcSecondaryColor,
              borderRadius: BorderRadius.circular(kdBorderRadius),
            ),
            child: const Icon(
              Icons.qr_code_scanner_rounded,
              color: kcPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _OutlinedTextField extends StatelessWidget {
  const _OutlinedTextField({
    required this.hintText,
    this.maxLines = 1,
  });

  final String hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              // color: kcTextGreyColor,
              fontSize: 14,
            ),
        filled: true,
        fillColor: kcPrimaryColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kdBorderRadius),
          borderSide: const BorderSide(color: kcSecondaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kdBorderRadius),
          borderSide: const BorderSide(color: kcSecondaryColor, width: 1.2),
        ),
      ),
    );
  }
}

class _UploadImageField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: kcPrimaryColor,
        borderRadius: BorderRadius.circular(kdBorderRadius),
        border: Border.all(color: kcSecondaryColor),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Upload Product Image',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: kcTextGreyColor,
                  ),
            ),
          ),
          Container(
            width: 46.w,
            decoration: BoxDecoration(
              color: kcSecondaryColor,
              borderRadius: BorderRadius.circular(kdBorderRadius),
            ),
            child: const Icon(
              Icons.image_outlined,
              color: kcPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
