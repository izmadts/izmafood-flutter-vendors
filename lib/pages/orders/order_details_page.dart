import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/pages/widget/izma_app_bar.dart';
import 'package:izma_foods_vendor/pages/widget/izma_primary_button.dart';
import 'package:izma_foods_vendor/pages/widget/izma_radial_gradient_container.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IzmaRadialGradientContainer(
        child: SafeArea(
          child: Column(
            children: [
              IzmaAppBar(title: "Order details"),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(bottom: kdPadding * 4),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    for (int i = 0; i < 3; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kdPadding, vertical: kdPadding / 2),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/temp/product.png',
                                    width: 80.w,
                                    height: 80.w,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text("Nestle Nido Full Cream Milk Powder Instant", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                                  ),
                                  SizedBox(width: 10),
                                  Text("Rs 290")
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    deliveryLocation(context),
                    SizedBox(height: kdPadding),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kdPadding),
                      child: Column(
                        children: [
                          _buildDeliveryChargesInfo("Sub Total", "Rs 362"),
                          _buildDeliveryChargesInfo("Commission", "Rs 362"),
                          _buildDeliveryChargesInfo("Total Payable", "Rs 362", true),
                        ],
                      ),
                    ),
                    SizedBox(height: kdPadding),
                    _buildPaymentMethodSection(context),
                    SizedBox(height: kdPadding),
                    _buildDeliveryManInfo(context),
                    SizedBox(height: kdPadding * 3),
                    IzmaPrimaryButton(title: "Accept")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildDeliveryManInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kdPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Delivery Man",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://picsum.photos/300/300?random=1',
              ),
              radius: 30,
            ),
            title: Text("Monir Hassan"),
            subtitle: Text("(207) 55 - 118"),
            trailing: CircleAvatar(
              backgroundColor: kcSecondaryColor,
              radius: 30,
              child: Icon(
                Icons.phone_outlined,
                color: kcPrimaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Column _buildPaymentMethodSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kdPadding, vertical: 10),
          child: Text("Payment Method", style: Theme.of(context).textTheme.bodyLarge),
        ),
        _buildPaymentMethodOption(
          context: context,
          title: "Pay Via Credit Card / Debit Card",
        ),
        SizedBox(height: kdPadding),
        _buildPaymentMethodOption(
          context: context,
          title: "Pay Via Mobile Payment",
        ),
        SizedBox(height: kdPadding),
        _buildPaymentMethodOption(
          context: context,
          title: "Cash On Delivery",
          isSelected: true,
        ),
      ],
    );
  }

  Container _buildPaymentMethodOption({required BuildContext context, required String title, bool isSelected = false}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kdPadding),
      decoration: BoxDecoration(color: Colors.grey[350], borderRadius: BorderRadius.circular(kdBorderRadius)),
      child: ListTile(
        leading: Icon(
          isSelected ? Icons.check_circle : Icons.circle_outlined,
          color: isSelected ? kcSecondaryColor : null,
        ),
        minLeadingWidth: 10,
        title: Text(title, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500, color: isSelected ? kcSecondaryColor : Colors.black)),
      ),
    );
  }

  _buildDeliveryChargesInfo(String title, String value, [isTotal = false]) {
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

  Column deliveryLocation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kdPadding),
          child: Text("Delivery Location", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
        ),
        SizedBox(height: kdPadding),
        ListTile(
          leading: CircleAvatar(
            child: Icon(
              Icons.location_on_outlined,
              color: Colors.black,
            ),
          ),
          title: Text("Floor 4, Wakli Tower, to 131 Gulshan Faiz Link Road", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black, fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }
}
