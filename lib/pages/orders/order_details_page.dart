import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/controllers/orders_controller.dart';
import 'package:izma_foods_vendor/helpers/global_helpers.dart';
import 'package:izma_foods_vendor/models/order_detail_model.dart';
import 'package:izma_foods_vendor/pages/widget/izma_app_bar.dart';
import 'package:izma_foods_vendor/pages/widget/izma_primary_button.dart';
import 'package:izma_foods_vendor/pages/widget/izma_radial_gradient_container.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsPage extends GetView<OrdersController> {
  OrderDetailsPage({super.key});
  final controller = Get.find<OrdersController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IzmaRadialGradientContainer(
        child: SafeArea(
          child: Column(
            children: [
              IzmaAppBar(title: "Order details"),
              Expanded(
                child: Obx(
                  () {
                    if (controller.isOrderDetailsLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final data = controller.orderDetailsModel.value?.data;
                    if (data == null) {
                      return Center(
                        child: Text(
                          'No order details',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: kcTextGreyColor,
                              ),
                        ),
                      );
                    }
                    return _buildOrderContent(context, data);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderContent(BuildContext context, Data data) {
    final products = data.products ?? [];
    final price = data.orderPrice ?? '0';
    final deliveryPrice = data.deliveryPrice ?? '0';
    final total = data.totaluserwillpay?.toString() ??
        (int.tryParse(price) != null && int.tryParse(deliveryPrice) != null
            ? (int.tryParse(price)! + int.tryParse(deliveryPrice)!).toString()
            : price);

    return ListView(
      padding: EdgeInsets.only(bottom: kdPadding * 4),
      physics: const BouncingScrollPhysics(),
      children: [
        for (final product in products)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kdPadding, vertical: kdPadding / 2),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(kdBorderRadius),
                      child: product.photo != null && product.photo!.isNotEmpty
                          ? Image.network(
                              productImageUrl(product.photo!),
                              width: 80.w,
                              height: 80.w,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _buildProductPlaceholder(context),
                            )
                          : _buildProductPlaceholder(context),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title ?? '',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          if (product.pivot?.qty != null)
                            Text(
                              'Qty: ${product.pivot?.qty}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: kcTextGreyColor,
                                  ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Rs ${product.pivot?.variantPrice ?? product.rprice ?? product.sprice ?? '--'}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
        _buildDeliveryLocation(context, data.address),
        SizedBox(height: kdPadding),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kdPadding),
          child: Column(
            children: [
              _buildDeliveryChargesInfo("Sub Total", "Rs $price"),
              _buildDeliveryChargesInfo("Delivery", "Rs $deliveryPrice"),
              _buildDeliveryChargesInfo("Total Payable", "Rs $total", true),
            ],
          ),
        ),
        SizedBox(height: kdPadding),
        _buildDeliveryManInfo(context, data),
        SizedBox(height: kdPadding * 3),
        if (data.orderStatus?.toLowerCase() == 'pending') ...[
          IzmaPrimaryButton(
            title: "Accept",
            onTap: () => controller.acceptOrder(),
          ),
          SizedBox(height: kdPadding),
          IzmaPrimaryButton(
            bgColor: Colors.red,
            title: "Reject",
            onTap: () => controller.rejectOrder(),
            hideSuffixIcon: true,
          ),
        ],
      ],
    );
  }

  Widget _buildProductPlaceholder(BuildContext context) {
    return Container(
      width: 80.w,
      height: 80.w,
      color: kcGreyColor,
      child: const Icon(Icons.image_not_supported),
    );
  }

  void _launchPhone(String? phone) {
    if (phone == null || phone.isEmpty) return;
    final uri = Uri.parse('tel:$phone');
    launchUrl(uri);
  }

  Padding _buildDeliveryManInfo(BuildContext context, Data data) {
    String? riderName;
    String? riderPhone;
    String? riderPhoto;
    if (data.rider is Map<String, dynamic>) {
      final rider = data.rider as Map<String, dynamic>;
      riderName = rider['name'] ?? rider['mobile']?.toString();
      riderPhone = rider['mobile']?.toString() ?? rider['phone']?.toString();
      riderPhoto = rider['photo']?.toString();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kdPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Delivery Man",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          if (riderName != null || riderPhone != null)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: riderPhoto != null && riderPhoto.isNotEmpty
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(profileImageUrl(riderPhoto)),
                      radius: 30,
                    )
                  : CircleAvatar(
                      backgroundColor: kcGreyColor,
                      radius: 30,
                      child: const Icon(Icons.person),
                    ),
              title: Text(riderName ?? 'Rider'),
              subtitle: riderPhone != null ? Text(riderPhone) : null,
              trailing: riderPhone != null
                  ? GestureDetector(
                      onTap: () => _launchPhone(riderPhone),
                      child: CircleAvatar(
                        backgroundColor: kcSecondaryColor,
                        radius: 30,
                        child: const Icon(
                          Icons.phone_outlined,
                          color: kcPrimaryColor,
                        ),
                      ),
                    )
                  : null,
            )
          else
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                'No rider assigned',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: kcTextGreyColor,
                    ),
              ),
            ),
        ],
      ),
    );
  }

  _buildDeliveryChargesInfo(String title, String value, [bool isTotal = false]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontWeight: isTotal ? FontWeight.w700 : null),
            ),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: isTotal ? FontWeight.w700 : null),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryLocation(BuildContext context, Address? address) {
    String? addressText = address?.address;
    if (addressText == null && address != null) {
      final parts = [
        if (address.apartment != null && address.apartment!.isNotEmpty) address.apartment!,
        if (address.floor != null && address.floor!.isNotEmpty) address.floor!,
      ];
      if (parts.isNotEmpty) addressText = parts.join(', ');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kdPadding),
          child: Text("Delivery Location",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500)),
        ),
        SizedBox(height: kdPadding),
        ListTile(
          leading: CircleAvatar(
            child: Icon(
              Icons.location_on_outlined,
              color: Colors.black,
            ),
          ),
          title: Text(
            addressText ?? 'No address',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
