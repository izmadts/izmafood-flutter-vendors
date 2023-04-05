import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme.dart';

class IzmaNearestShopView extends StatelessWidget {
  const IzmaNearestShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Nearest Shops",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: kcSecondaryColor, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        Container(
          height: 120.h,
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(color: kcLightGreenColor),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: kdPadding),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                height: double.infinity,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/temp/store-bg.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                  ),
                  borderRadius: BorderRadius.circular(kdBorderRadius),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Positioned(
                      left: 10,
                      top: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/icons/cart.png',
                              width: 30,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Zaibi Grocery Store",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Column(
                        children: [
                          _buildShopInfoItem(context: context, icon: Icons.schedule_rounded, info: "35min"),
                          _buildShopInfoItem(context: context, icon: Icons.location_pin, info: "2.5km"),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 10,
            ),
            itemCount: 10,
          ),
        ),
      ],
    );
  }

  Row _buildShopInfoItem({required BuildContext context, required IconData icon, required String info}) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.yellow,
          size: 16,
        ),
        SizedBox(width: 5),
        Text(info, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w500))
      ],
    );
  }
}
