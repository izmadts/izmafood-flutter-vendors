import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/pages/widget/izma_app_bar.dart';
import 'package:izma_foods_vendor/pages/widget/izma_radial_gradient_container.dart';

class AddNewProductPage extends StatelessWidget {
  const AddNewProductPage({super.key});

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
                          Expanded(
                            child: _DropdownField(
                              title: 'Select Brand',
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: _DropdownField(
                              title: 'Select Category',
                              hasErrorIcon: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Expanded(
                            child: _RadioChip(
                              label: 'Stock\nAvailable',
                              isSelected: true,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: _RadioChip(
                              label: 'Not Availabile',
                              isSelected: false,
                            ),
                          ),
                        ],
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
                      _SubmitButton(),
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

class _DropdownField extends StatelessWidget {
  const _DropdownField({
    required this.title,
    this.hasErrorIcon = false,
  });

  final String title;
  final bool hasErrorIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: kcPrimaryColor,
        borderRadius: BorderRadius.circular(kdBorderRadius),
        border: Border.all(color: kcSecondaryColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: kcTextGreyColor,
                  ),
            ),
          ),
          Icon(
            hasErrorIcon
                ? Icons.keyboard_arrow_down_rounded
                : Icons.keyboard_arrow_down_rounded,
            color: kcTextGreyColor,
          ),
        ],
      ),
    );
  }
}

class _RadioChip extends StatelessWidget {
  const _RadioChip({
    required this.label,
    required this.isSelected,
  });

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
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

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
