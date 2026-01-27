import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:izma_foods_vendor/config/constants.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/helpers/api_exception.dart';

void mPrint(String text) {
  print('\x1B[33m$text\x1B[0m');
}

showSnackBar(String msg) async {
  await Fluttertoast.showToast(msg: msg);
}

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

handleControllerExceptions(e) {
  if (kDebugMode) {
    if (e is DioException) {
      mPrint("API EXCEPTION :: ${e.response} :: ${e.message}");
    }
    if (e is APIException) {
      mPrint("API EXCEPTION :: ${e.message} :: ${e.statusCode}");
    }

    return showSnackBar(e.toString());
  }
  if (e is APIException) {
    showSnackBar(e.toString());
  } else {
    showSnackBar("Something went wrong.");
  }
}
