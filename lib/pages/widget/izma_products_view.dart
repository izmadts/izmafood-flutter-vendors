import 'package:flutter/material.dart';

import '../../config/theme.dart';
import 'izma_product_item.dart';

class IzmaProductsView extends StatelessWidget {
  const IzmaProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(kdPadding),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 20, childAspectRatio: 2 / 3.3),
      itemCount: 10,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return IzmaProductItem();
      },
    );
  }
}
