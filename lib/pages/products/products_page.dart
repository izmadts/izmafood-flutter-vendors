import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/controllers/edit_product_controller.dart';
import 'package:izma_foods_vendor/controllers/product_list_controller.dart';
import 'package:izma_foods_vendor/helpers/global_helpers.dart';
import 'package:izma_foods_vendor/pages/products/add_new_product.dart';
import 'package:izma_foods_vendor/pages/products/edit_product.dart';
import 'package:izma_foods_vendor/pages/products/my_product_page.dart';
import 'package:izma_foods_vendor/pages/widget/izma_app_bar.dart';
import 'package:izma_foods_vendor/pages/widget/izma_radial_gradient_container.dart';

class ProductsPage extends GetView<ProductListController> {
  ProductsPage({super.key});
  final controller = Get.put(ProductListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IzmaRadialGradientContainer(
          child: SafeArea(
        child: Column(
          children: [
            IzmaAppBar(
              title: "Producta to Add",
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: GestureDetector(
                    onTap: () => Get.to(() => MyProductPage()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: kcSecondaryColor,
                          borderRadius: BorderRadius.circular(kdBorderRadius)),
                      child: Text(
                        "My Products",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: kcPrimaryColor,
                            ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: GestureDetector(
                    onTap: () => Get.to(() => AddNewProductPage()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: kcSecondaryColor,
                          borderRadius: BorderRadius.circular(kdBorderRadius)),
                      child: Text(
                        "Add New",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: kcPrimaryColor,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () => controller.selectedCategoryLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      height: 40,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: kdPadding),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              controller.selectedCategoryLoading.value = true;

                              controller.selectedCategory.value = controller
                                  .categoriesModel.value?.subCategory?[index];

                              // Calling the api to get the product list
                              await controller.getProductList(
                                controller.categoriesModel.value
                                    ?.subCategory?[index].id,
                              );
                              controller.selectedCategoryLoading.value = false;
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: controller.selectedCategory.value?.id ==
                                        controller.categoriesModel.value
                                            ?.subCategory?[index].id
                                    ? kcTextGreyColor
                                    : null,
                                borderRadius:
                                    BorderRadius.circular(kdBorderRadius),
                                border: Border.all(color: kcTextGreyColor),
                              ),
                              child: Text(
                                controller.categoriesModel.value
                                        ?.subCategory?[index].title ??
                                    '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: controller
                                                  .selectedCategory.value?.id ==
                                              controller.categoriesModel.value
                                                  ?.subCategory?[index].id
                                          ? Colors.yellow
                                          : null,
                                    ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 10),
                        itemCount: controller
                                .categoriesModel.value?.subCategory?.length ??
                            0,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
            ),

            SizedBox(height: kdPadding),
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kdPadding),
              child: TextField(
                controller: controller.searchController,
                onChanged: (value) async {
                  if (value.trim().isNotEmpty) {
                    controller.searchProduct(value.trim(),
                        controller.selectedCategory.value?.id ?? 0);
                  } else {
                    await controller.getProductList(
                        controller.selectedCategory.value?.id ?? 0);
                  }
                },
                decoration: InputDecoration(
                  focusColor: kcSecondaryColor,
                  hoverColor: kcSecondaryColor,
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[200]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: kcSecondaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[200]!),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  prefixIcon: Icon(
                    Icons.search_outlined,
                  ),
                  label: Text("Search",
                      style: TextStyle(
                          color: kcSecondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),

            // SizedBox(height: kdPadding),
            Obx(
              () => controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.all(kdPadding),
                        itemBuilder: (context, index) => Container(
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(kdBorderRadius),
                                  border: Border.all(color: kcSecondaryColor),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Image.network(
                                  productImageUrl(controller.productListModel
                                          .value?.data?.data?[index].photo ??
                                      ''),
                                ),
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Container(
                                  // height: 40,
                                  padding: EdgeInsets.all(5),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(kdBorderRadius),
                                    border: Border.all(color: kcSecondaryColor),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Text(
                                    controller.productListModel.value?.data
                                            ?.data?[index].title ??
                                        '',
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              SizedBox(width: 4),
                              Container(
                                height: 40,
                                width: 80,
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(kdBorderRadius),
                                  border: Border.all(color: kcSecondaryColor),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: TextFormField(
                                  controller: controller
                                      .listOfTextEditingControllers[index],
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid price';
                                    }
                                    if (double.parse(value) < 0) {
                                      return 'Price cannot be negative';
                                    }
                                    if (double.parse(value) > 1000000) {
                                      return 'Price cannot be greater than 1000000';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText:
                                        "Rs ${controller.productListModel.value?.data?.data?[index].rprice ?? 0}",
                                  ),
                                ),
                              ),
                              SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  if (controller.productListModel.value?.data
                                          ?.data?[index].isAdded ==
                                      '0') {
                                    controller.addProduct(
                                        index,
                                        controller
                                            .listOfTextEditingControllers[index]
                                            .text,
                                        controller.productListModel.value?.data
                                            ?.data?[index].id);
                                  } else {
                                    Get.to(() => EditProductPage(), arguments: {
                                      'productId': controller.productListModel
                                          .value?.data?.data?[index].id,
                                    });
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  padding: EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(kdBorderRadius),
                                    color: controller.productListModel.value
                                                ?.data?.data?[index].isAdded ==
                                            '0'
                                        ? kcYellowColor
                                        : kcSecondaryColor,
                                    // border: Border.all(color: kcSecondaryColor),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: controller.productListModel.value?.data
                                              ?.data?[index].isAdded ==
                                          '0'
                                      ? Icon(
                                          Icons.add_rounded,
                                          color: kcPrimaryColor,
                                        )
                                      : Icon(
                                          Icons.edit_rounded,
                                          color: kcPrimaryColor,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemCount: controller
                                .productListModel.value?.data?.data?.length ??
                            0,
                      ),
                    ),
            ),
          ],
        ),
      )),
    );
  }
}
