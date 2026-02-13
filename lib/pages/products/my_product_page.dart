import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/controllers/product_list_controller.dart';
import 'package:izma_foods_vendor/helpers/global_helpers.dart';
import 'package:izma_foods_vendor/pages/widget/izma_app_bar.dart';
import 'package:izma_foods_vendor/pages/widget/izma_radial_gradient_container.dart';

class MyProductPage extends GetView<ProductListController> {
  MyProductPage({super.key});
  final controller = Get.put(ProductListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IzmaRadialGradientContainer(
          child: SafeArea(
        child: Column(
          children: [
            IzmaAppBar(
              title: "My Products",
            ),
            Obx(
              () => controller.myProductsLoading.value
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
                                  productImageUrl(controller.myProductsModel
                                          .value?.data?[index].photo ??
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
                                    controller.myProductsModel.value
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
                                          .listOfMyProductsTextEditingControllers[
                                      index],
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
                                        "Rs ${controller.myProductsModel.value?.data?[index].rprice ?? 0}",
                                  ),
                                ),
                              ),
                              SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  // if (controller.myProductsModel.value?.data
                                  //         ?[index].isAdded ==
                                  //     '0') {
                                  //   controller.addProduct(
                                  //       index,
                                  //       controller
                                  //           .listOfTextEditingControllers[index]
                                  //           .text,
                                  //       controller.myProductsModel.value?.data
                                  //           ?.data?[index].id);
                                  // } else {
                                  //   Get.to(() => EditProductPage(), arguments: {
                                  //     'productId': controller.productListModel
                                  //         .value?.data?[index].id,
                                  //   });
                                  // }
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  padding: EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(kdBorderRadius),
                                    color: kcRedColor,
                                    // border: Border.all(color: kcSecondaryColor),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Icon(
                                    Icons.hourglass_empty_rounded,
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
                        itemCount:
                            controller.myProductsModel.value?.data?.length ?? 0,
                      ),
                    ),
            ),
          ],
        ),
      )),
    );
  }
}
