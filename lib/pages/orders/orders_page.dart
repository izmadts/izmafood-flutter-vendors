import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/controllers/orders_controller.dart';
import 'package:izma_foods_vendor/models/live_order_tracking_model.dart';
import 'package:izma_foods_vendor/pages/orders/order_details_page.dart';
import 'package:izma_foods_vendor/pages/widget/izma_app_bar.dart';
import 'package:izma_foods_vendor/pages/widget/izma_radial_gradient_container.dart';

class OrdersPage extends GetView<OrdersController> {
  OrdersPage({super.key});
  final controller = Get.put(OrdersController());

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
              SizedBox(height: 8.h),
              _buildStatusTabs(context),
              SizedBox(height: 12.h),
              Expanded(
                child: Obx(
                  () {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final orders = controller.currentOrders;
                    return RefreshIndicator(
                      onRefresh: controller.getOrders,
                      child: orders.isEmpty
                          ? ListView(
                              padding:
                                  EdgeInsets.symmetric(horizontal: kdPadding),
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: [
                                SizedBox(height: 100.h),
                                Center(
                                  child: Text(
                                    'No ${controller.selectedOrderStatus.value} orders',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: kcTextGreyColor,
                                        ),
                                  ),
                                ),
                              ],
                            )
                          : ListView.separated(
                              itemCount: orders.length,
                              padding:
                                  EdgeInsets.symmetric(horizontal: kdPadding),
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return _buildOrderItem(orders[index], context);
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: kdPadding),
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusTabs(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: kdPadding),
      child: Obx(
        () => Row(
          children: OrdersController.orderStatuses.map((status) {
            final isSelected = controller.selectedOrderStatus.value == status;
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: GestureDetector(
                onTap: () => controller.selectedOrderStatus.value = status,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected ? kcSecondaryColor : kcPrimaryColor,
                    borderRadius: BorderRadius.circular(kdBorderRadius),
                    border: Border.all(
                      color: isSelected ? kcSecondaryColor : kcGreyColor,
                    ),
                  ),
                  child: Text(
                    status,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isSelected ? kcPrimaryColor : Colors.black,
                          fontWeight: isSelected ? FontWeight.w600 : null,
                        ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildOrderItem(Cancelled order, BuildContext context) {
    return InkWell(
      onTap: () {
        controller.orderId.value = order.id?.toString() ?? '';
        Get.to(() => OrderDetailsPage());
        controller.orderDetails();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: kcPrimaryColor,
          borderRadius: BorderRadius.circular(kdBorderRadius),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              color: Colors.black.withOpacity(0.4),
              blurRadius: 3,
            ),
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
                    "Order #${order.id ?? '--'}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: kcSecondaryColor,
                        ),
                  ),
                  Text(
                    order.client ?? 'Customer',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  if (order.shopName != null && order.shopName!.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(
                      order.shopName!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: kcTextGreyColor,
                          ),
                    ),
                  ],
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Rs ${order.price ?? '--'}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (order.orderStatus != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    order.orderStatus!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: kcTextGreyColor,
                        ),
                  ),
                ],
                SizedBox(height: 8.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: kcSecondaryColor,
                    borderRadius: BorderRadius.circular(kdBorderRadius),
                  ),
                  child: Text(
                    "View Details",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: kcPrimaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
