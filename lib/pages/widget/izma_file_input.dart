import 'package:flutter/material.dart';

import '../../config/theme.dart';

class IzmaFileInput extends StatelessWidget {
  const IzmaFileInput({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kdPadding, right: kdPadding, bottom: kdPadding),
      child: Container(
        padding: const EdgeInsets.only(left: kdPadding),
        decoration: BoxDecoration(color: kcGreyColor, borderRadius: BorderRadius.circular(kdBorderRadius)),
        child: Row(
          children: [
            Expanded(child: Text(title)),
            Container(
              height: 50,
              width: 70,
              decoration: BoxDecoration(color: kcSecondaryColor, borderRadius: BorderRadius.circular(kdBorderRadius)),
              child: Icon(
                Icons.camera_alt_outlined,
                color: kcPrimaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
