import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme.dart';

class IzmaCartItem extends StatelessWidget {
  const IzmaCartItem({super.key});

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
                Text(
                  "Rs 342",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Rs 342",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.orange[600]),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Colors.red[400],
                        borderRadius: BorderRadius.circular(kdBorderRadius),
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    Container(
                      width: 40,
                      alignment: Alignment.center,
                      child: Text(
                        '1',
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: kcSecondaryColor,
                        borderRadius: BorderRadius.circular(kdBorderRadius),
                      ),
                      child: Icon(
                        Icons.add_rounded,
                        size: 16,
                        color: Colors.white,
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
