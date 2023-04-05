import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key, this.text = 'No data to display.', this.imagePath = 'assets/images/empty-bg.png'});
  final String text;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.h,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 330.w,
            height: 350.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kdPadding),
            child: Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
