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
import 'package:izma_foods_vendor/pages/products/barcode_scanner_page.dart';

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
                  child: Obx(
                    () => controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              buildScanOrSearchField(context),
                              SizedBox(height: 10.h),
                              buildOutlinedTextField(
                                context: context,
                                controller: controller.barCodeController,
                                hintText: 'Barcode',
                              ),
                              SizedBox(height: 10.h),
                              buildOutlinedTextField(
                                context: context,
                                controller: controller.productTitleController,
                                hintText: 'Product Title',
                              ),
                              SizedBox(height: 10.h),
                              buildOutlinedTextField(
                                context: context,
                                controller:
                                    controller.productDescriptionController,
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
                                        isSelected:
                                            controller.stocksAvailable.value
                                                ? true
                                                : false,
                                        label: 'Stock\nAvailable',
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: buildRadioChip(
                                        context: context,
                                        isSelected:
                                            !controller.stocksAvailable.value
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
                                    child: buildOutlinedTextField(
                                      context: context,
                                      controller:
                                          controller.salePriceController,
                                      hintText: 'Sale Price',
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: buildOutlinedTextField(
                                      context: context,
                                      controller:
                                          controller.offerPriceController,
                                      hintText: 'Offer Price',
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: buildOutlinedTextField(
                                      context: context,
                                      controller:
                                          controller.wholeSaleController,
                                      hintText: 'Whole Sale',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              buildUploadImage(context),
                              SizedBox(height: 24.h),
                              buildSubmitButton(context),
                              SizedBox(height: 24.h),
                            ],
                          ),
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
        color: kcGreyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Obx(
        () => DropdownButtonHideUnderline(
          child: DropdownButton<attribute_model.Datum>(
            value: controller.selectedAttribute.value,
            isExpanded: true,
            dropdownColor: kcGreyColor,
            iconEnabledColor: Colors.white,
            hint: Text(
              'Attributes',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.black),
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
                          child: Text(
                            e.attributeTitle ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    )
                    .toList() ??
                [],
            onChanged: (value) {
              if (value != null) {
                controller.selectedAttribute.value = value;
                controller.selectedAttributeValue.value = value.id.toString();
                print(
                    'selectedAttributeValue: ${controller.selectedAttributeValue.value}');
                controller.attributeValue(value);
              }
            },
            isDense: true,
            icon:
                const Icon(Icons.keyboard_arrow_down, color: kcSecondaryColor),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: kcSecondaryColor,
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
              child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    controller.attributeValueListModel.value?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          // height: 40,
                          width: 100,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: kcGreyColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            controller.attributeValueListModel.value
                                    ?.data?[index].comment ??
                                '',
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: buildOutlinedTextField(
                            context: context,
                            controller: controller.listOfPrice[index],
                            hintText: 'Price',
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: buildOutlinedTextField(
                            context: context,
                            controller: controller.listOfStock[index],
                            hintText: 'Stock',
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 10),
              //   // width: ,
              //   height: 60,
              //   decoration: BoxDecoration(
              //     color: kcGreyColor,
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Obx(
              //     () => DropdownButtonHideUnderline(
              //       child: DropdownButton<attribute_value_model.Datum>(
              //         value: controller.selectedAttributeValueItem.value,
              //         isExpanded: true,
              //         dropdownColor: kcGreyColor,
              //         iconEnabledColor: Colors.white,
              //         hint: Text(
              //           'Attributes',
              //           style: Theme.of(context)
              //               .textTheme
              //               .bodySmall
              //               ?.copyWith(color: Colors.black),
              //         ),
              //         items: controller.attributeValueListModel.value?.data
              //                 ?.map(
              //                   (e) => DropdownMenuItem<
              //                       attribute_value_model.Datum>(
              //                     value: e,
              //                     child: Text(
              //                       e.comment ?? '',
              //                       style: Theme.of(context)
              //                           .textTheme
              //                           .bodySmall
              //                           ?.copyWith(color: Colors.black),
              //                     ),
              //                   ),
              //                 )
              //                 .toList() ??
              //             [],
              //         onChanged: (value) {
              //           if (value != null) {
              //             controller.selectedAttributeValueItem.value = value;
              //           }
              //         },
              //         isDense: true,
              //         icon: const Icon(Icons.keyboard_arrow_down,
              //             color: kcSecondaryColor),
              //         style: Theme.of(context).textTheme.bodySmall?.copyWith(
              //               color: kcSecondaryColor,
              //             ),
              //       ),
              //     ),
              //   ),
              // ),
            ),
    );
  }

  Expanded selectCategory(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        decoration: BoxDecoration(
          color: kcGreyColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Obx(
          () => DropdownButtonHideUnderline(
            child: DropdownButton<SubCategory>(
              value: controller.selectedCategory.value,
              // lighter kcSecondaryColor for dropdown menu
              isExpanded: true,
              dropdownColor: kcGreyColor,
              iconEnabledColor: Colors.white,
              hint: Text(
                'Select Category',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black),
              ),
              items: controller.categoryListModel.value?.subCategory
                  ?.map(
                    (brand) => DropdownMenuItem(
                      value: brand,
                      child: Text(
                        brand.title ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.selectedCategory.value = value;
                }
              },
              isDense: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: kcSecondaryColor,
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
          color: kcGreyColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Obx(
          () => DropdownButtonHideUnderline(
            child: DropdownButton<Datum>(
              value: controller.selectedBrand.value,
              isExpanded: true,
              dropdownColor: kcGreyColor,
              iconEnabledColor: Colors.white,
              hint: Text(
                'Select Brand',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black),
              ),
              items: controller.brandListModel.value?.data
                  ?.map(
                    (brand) => DropdownMenuItem(
                      value: brand,
                      child: Text(
                        brand.title ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.selectedBrand.value = value;
                }
              },
              isDense: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: kcSecondaryColor,
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
          border:
              Border.all(color: isSelected ? kcSecondaryColor : kcGreyColor),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: isSelected ? kcSecondaryColor : kcGreyColor,
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
        onPressed: () {
          controller.createProduct();
        },
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

  Widget buildOutlinedTextField({
    required BuildContext context,
    required String hintText,
    int maxLines = 1,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14,
            ),
        filled: true,
        fillColor: kcPrimaryColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kdBorderRadius),
          borderSide: const BorderSide(color: kcGreyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kdBorderRadius),
          borderSide: const BorderSide(color: kcSecondaryColor, width: 1.2),
        ),
      ),
    );
  }

  Widget buildUploadImage(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.showShopImageSourceDialog();
      },
      child: Container(
        height: 56.h,
        decoration: BoxDecoration(
          color: kcPrimaryColor,
          borderRadius: BorderRadius.circular(kdBorderRadius),
          border: Border.all(color: kcGreyColor),
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
      ),
    );
  }

  Widget buildScanOrSearchField(BuildContext context) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kdBorderRadius),
        border: Border.all(color: kcGreyColor),
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
          GestureDetector(
            onTap: () async {
              Get.to(() => BarcodeScannerPage());
              // BarcodeScannerPage();
            },
            child: Container(
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
          ),
        ],
      ),
    );
  }
}
