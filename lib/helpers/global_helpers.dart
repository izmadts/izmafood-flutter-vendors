import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:izma_foods_vendor/config/constants.dart';
import 'package:izma_foods_vendor/config/theme.dart';
import 'package:izma_foods_vendor/helpers/api_exception.dart';




Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}


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
