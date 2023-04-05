import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme.dart';
import 'izma_app_bar.dart';
import 'izma_primary_button.dart';

class IzmaNoShopsAvailable extends StatelessWidget {
  const IzmaNoShopsAvailable({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // padding: EdgeInsets.symmetric(horizontal: kdPadding),
      physics: const BouncingScrollPhysics(),
      children: [
        IzmaAppBar(
          title: "IZMA Food",
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.support_agent_rounded),
              visualDensity: VisualDensity.compact,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_outlined),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kdPadding),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: kcSecondaryColor, shape: BoxShape.circle),
              child: Icon(
                Icons.location_on_outlined,
                color: Colors.white,
              ),
            ),
            // minLeadingWidth: 10,

            title: Text(
              "Your Location",
              style: TextStyle(color: kcTextGreyColor, fontSize: 12),
            ),
            subtitle: Text(
              "32 Libianreis Close, Tanteg, CF28",
              style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded, size: 24),
            dense: true,
          ),
        ),
        SizedBox(height: 20.h),
        Image.asset(
          'assets/images/sorry-no-shop-available.png',
          height: 350.h,
        ),
        SizedBox(height: 20.h),
        IzmaPrimaryButton(
          title: "Create Account",
          suffixIcon: Icons.account_circle_outlined,
        ),
        SizedBox(height: 20.h),
        Text(
          "Share with someone else",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
        ),
        SizedBox(height: 5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialIcon('facebook.png'),
            SizedBox(width: 20.w),
            _buildSocialIcon('whatsapp.png'),
            SizedBox(width: 20.w),
            _buildSocialIcon('twitter.png'),
            SizedBox(width: 20.w),
            _buildSocialIcon('email.png'),
            SizedBox(width: 20.w),
            _buildSocialIcon('linked-in.png'),
          ],
        )
      ],
    );
  }

  Image _buildSocialIcon(String iconName) {
    return Image.asset(
      'assets/icons/' + iconName,
      width: 30,
      height: 30,
    );
  }
}
