import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme.dart';

class IzmaHorizontalProductItem extends StatelessWidget {
  const IzmaHorizontalProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kdPadding, vertical: 5),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/temp/product.png',
            width: 100.w,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nestle Nido Full Cream Milk Powder Instant",
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                ),
                SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rs 342",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                ),
                          ),
                          Text(
                            "Rs 342",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.orange[600]),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: kdPadding, vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: kcSecondaryColor,
                        borderRadius: BorderRadius.circular(kdBorderRadius),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 13,
                            color: kcPrimaryColor,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Add",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: kcPrimaryColor, fontWeight: FontWeight.w400, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
