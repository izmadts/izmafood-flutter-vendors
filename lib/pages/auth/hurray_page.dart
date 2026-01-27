import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/pages/widget/izma_app_bar.dart';
import 'package:izma_foods_vendor/pages/widget/izma_primary_button.dart';
import 'package:izma_foods_vendor/pages/widget/izma_radial_gradient_container.dart';

import '../main_page.dart';

class HurrayPage extends StatelessWidget {
  const HurrayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IzmaRadialGradientContainer(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top app bar with title and support/notification icons
              const IzmaAppBar(
                title: 'IZMA Food',
                showCustomActions: false,
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Placeholder image – replace with your thumb image later
                        SvgPicture.asset('assets/images/thumbs_up.svg'),
                        SizedBox(height: 40.h),
                        Text(
                          'Hurrrrrray!',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 36.sp,
                                    fontWeight: FontWeight.w700,
                                    color: kcSecondaryColor,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          'Your data has been received after reviewing & verification '
                          'Process your Shop will be approve by the IZMAFood.com',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: kcTextGreyColor,
                                    height: 1.5,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24.h),
                        IzmaPrimaryButton(
                          title: "Done",
                          onTap: () => Get.to(() => MainPage()),
                        ),
                      ],
                    ),
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
