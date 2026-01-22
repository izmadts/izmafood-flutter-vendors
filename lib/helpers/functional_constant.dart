import 'dart:io' as platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class FunctionalConstants {
  Future<Map<String, dynamic>> getDeviceInfo() async {
    Map<String, dynamic> deviceData = {
      "browser": "",
      "appVersion": "",
      "deviceID": "",
      "deviceName": "",
      "deviceIPAddress": "",
      "deviceOS": "",
      "deviceOSVersion": "",
    };

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // Set app version from package info
    deviceData["appVersion"] = packageInfo.version;

    try {
      if (platform.Platform.isAndroid) {
        // Android platform
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

        deviceData["deviceID"] = androidInfo.id;
        deviceData["deviceName"] = androidInfo.model;
        deviceData["deviceOS"] = "Android";
        deviceData["deviceOSVersion"] = androidInfo.version.release;
      } else if (platform.Platform.isIOS) {
        // iOS platform
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

        deviceData["deviceID"] = iosInfo.identifierForVendor ?? "";
        deviceData["deviceName"] = iosInfo.name;
        deviceData["deviceOS"] = "iOS";
        deviceData["deviceOSVersion"] = iosInfo.systemVersion;
      }
    } catch (e) {
      debugPrint("Error getting device info: $e");
    }

    return deviceData;
  }
}
