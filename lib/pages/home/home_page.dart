import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/controllers/dash_board_controller.dart';
import 'package:izma_foods_vendor/controllers/splash_controller.dart';
import 'package:izma_foods_vendor/pages/widget/izma_app_bar.dart';
import 'package:izma_foods_vendor/pages/widget/izma_radial_gradient_container.dart';

class HomePage extends GetView<DashBoardController> {
  HomePage({super.key});
  final controller = Get.find<DashBoardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IzmaRadialGradientContainer(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/icons/app-logo-text.png',
                    width: 100.w,
                    height: 50.h,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/cart.png', height: 40),
                    SizedBox(width: kdPadding),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text("${controller.shopName.value} Store",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                        ),
                        Text("Gulgasht Branch Multan",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: kdPadding),
              Text(
                "Dashboard",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: kcSecondaryColor),
              ),
              Obx(
                () => _buildDashboardCard(
                    title: "Revenue",
                    icon: Icons.attach_money_outlined,
                    comment: "Shipping fees are not included",
                    value:
                        "Rs ${controller.dashBoardModel.value?.data?.revenue ?? 0}",
                    context: context),
              ),
              SizedBox(height: kdPadding),
              Obx(
                () => _buildDashboardCard(
                    title: "Orders",
                    icon: Icons.shopping_cart_rounded,
                    comment: "Shipping fees are not included",
                    value:
                        "Rs ${controller.dashBoardModel.value?.data?.totalOrders ?? 0}",
                    context: context),
              ),
              SizedBox(height: kdPadding),
              Obx(
                () => _buildDashboardCard(
                    title: "Products",
                    icon: Icons.list,
                    comment: "Shipping fees are not included",
                    value:
                        "Rs ${controller.dashBoardModel.value?.data?.totalProducts ?? 0}",
                    context: context),
              ),
              SizedBox(height: kdPadding),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kdPadding),
                child: Row(
                  children: [
                    _buildDashboardButton(
                        title: "Add Product",
                        icon: Icons.add_rounded,
                        context: context),
                    SizedBox(width: kdPadding),
                    _buildDashboardButton(
                        title: "Live Orders",
                        icon: Icons.shopping_basket_outlined,
                        context: context),
                  ],
                ),
              ),
              SizedBox(height: kdPadding),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kdPadding),
                child: Row(
                  children: [
                    _buildDashboardButton(
                        title: "Finance",
                        icon: Icons.pie_chart,
                        context: context),
                    SizedBox(width: kdPadding),
                    _buildDashboardButton(
                        title: "Ratings",
                        icon: Icons.star_rounded,
                        context: context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildDashboardButton(
      {required String title,
      required IconData icon,
      required BuildContext context}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: kcSecondaryColor,
            borderRadius: BorderRadius.circular(kdBorderRadius)),
        child: Row(
          children: [
            Icon(icon, color: kcPrimaryColor, size: 28),
            SizedBox(width: 5),
            Expanded(
                child: Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: kcPrimaryColor))),
          ],
        ),
      ),
    );
  }

  Padding _buildDashboardCard(
      {required String title,
      required IconData icon,
      required String value,
      required String comment,
      required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kdPadding),
      child: Container(
        height: 110,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kcSecondaryColor,
          borderRadius: BorderRadius.circular(kdBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 5,
              left: 10,
              child: Text(title,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w600)),
            ),
            Positioned(
              bottom: 5,
              left: 5,
              child: Icon(
                icon,
                size: 60,
                color: Colors.white.withOpacity(0.4),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(value,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 5),
                child: Text(comment,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
