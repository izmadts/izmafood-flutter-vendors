import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/theme.dart';
import '../widget/izma_app_bar.dart';
import '../widget/izma_radial_gradient_container.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IzmaRadialGradientContainer(
        child: SafeArea(
          child: Column(
            children: [
              IzmaAppBar(
                title: "Notifications",
              ),
              Expanded(
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kdPadding),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 100.h,
                          decoration: BoxDecoration(
                            color: index == 0 ? kcLightGreenColor : null,
                            borderRadius: BorderRadius.circular(kdBorderRadius),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),
                                    Text("Order #345", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16)),
                                    Expanded(
                                      child: Text(
                                        "Your order is Confirmed Please check everything is okay.",
                                        style: TextStyle(fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("3:57 PM", style: Theme.of(context).textTheme.bodySmall),
                                  CircleAvatar(
                                    backgroundColor: index == 0 ? Colors.orange : kcSecondaryColor,
                                    child: Icon(
                                      index == 0 ? Icons.sort : Icons.phone_outlined,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                          height: kdPadding.h,
                          thickness: 1.5,
                          indent: kdPadding,
                          endIndent: kdPadding,
                        ),
                    itemCount: 10),
              )
            ],
          ),
        ),
      ),
    );
  }
}
