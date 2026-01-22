import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/pages/orders/order_details_page.dart';
import 'package:izma_foods_vendor/pages/widget/izma_app_bar.dart';
import 'package:izma_foods_vendor/pages/widget/izma_radial_gradient_container.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IzmaRadialGradientContainer(
        child: SafeArea(
          child: Column(
            children: [
              IzmaAppBar(
                title: "Orders",
                showCustomActions: false,
              ),
              Text(
                "New Order",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              // Text(
              //   "Slide left ot check order status",
              //   style: Theme.of(context).textTheme.bodySmall,
              // ),
              Expanded(
                child: ListView.separated(
                  itemCount: 20,
                  padding: EdgeInsets.symmetric(horizontal: kdPadding),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _buildOrderItem(index, context);
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: kdPadding),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItem(int index, BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => OrderDetailsPage()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: kcPrimaryColor,
          borderRadius: BorderRadius.circular(kdBorderRadius),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 2),
                color: Colors.black.withOpacity(0.4),
                blurRadius: 3),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order #123${index}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: kcSecondaryColor,
                        ),
                  ),
                  Text("Muneeb Ahmed",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  Text("H#22 Model Town, Multan"),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Rs 123${index}"),
                Text("Rider Dliawar"),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: kcSecondaryColor,
                    borderRadius: BorderRadius.circular(kdBorderRadius),
                  ),
                  child: Text("View Details",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: kcPrimaryColor)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
