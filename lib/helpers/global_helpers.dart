import 'package:flutter/material.dart';
import 'package:izma_foods_vendor/config/constants.dart';
import 'package:izma_foods_vendor/config/theme.dart';

getLoading() {
  return Center(
    child: CircularProgressIndicator(
      color: kcSecondaryColor,
    ),
  );
}



profileImageUrl(String url) {
  return kBaseImageUrl + url;
}
