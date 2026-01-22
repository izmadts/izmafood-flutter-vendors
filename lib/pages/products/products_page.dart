import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/pages/products/add_new_product.dart';
import 'package:izma_foods_vendor/pages/widget/izma_app_bar.dart';
import 'package:izma_foods_vendor/pages/widget/izma_radial_gradient_container.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IzmaRadialGradientContainer(
          child: SafeArea(
        child: Column(
          children: [
            IzmaAppBar(
              title: "Product Lists to Add",
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: GestureDetector(
                    onTap: () => Get.to(() => AddNewProductPage()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: kcSecondaryColor, borderRadius: BorderRadius.circular(kdBorderRadius)),
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
            Container(
              height: 40,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: kdPadding),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: index == 0 ? kcTextGreyColor : null,
                    borderRadius: BorderRadius.circular(kdBorderRadius),
                    border: Border.all(color: kcTextGreyColor),
                  ),
                  child: Text("Grocery", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: index == 0 ? Colors.yellow : null)),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 10),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: kdPadding),
            Expanded(
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
                          borderRadius: BorderRadius.circular(kdBorderRadius),
                          border: Border.all(color: kcSecondaryColor),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset('assets/temp/product.png'),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kdBorderRadius),
                            border: Border.all(color: kcSecondaryColor),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Text("Vital Teaa 458 g"),
                        ),
                      ),
                      SizedBox(width: 4),
                      Container(
                        height: 40,
                        width: 80,
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kdBorderRadius),
                          border: Border.all(color: kcSecondaryColor),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Text("Rs 52.00"),
                      ),
                      SizedBox(width: 4),
                      Container(
                        height: 40,
                        width: 40,
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kdBorderRadius),
                          color: kcSecondaryColor,
                          border: Border.all(color: kcSecondaryColor),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Icon(Icons.add_rounded, color: kcPrimaryColor),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
                itemCount: 60,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
