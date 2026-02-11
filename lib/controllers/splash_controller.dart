import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:izma_foods_vendor/config/local_storage.dart';
import 'package:izma_foods_vendor/helpers/api_helper.dart';
import 'package:izma_foods_vendor/models/user_info_model.dart';
import 'package:izma_foods_vendor/pages/auth/login_page.dart';
import 'package:izma_foods_vendor/pages/main_page.dart';

class SplashController extends GetxController {
  final userInfoModel = Rxn<UserInfoModel>();

  late Timer timer;
  double opacity = 0.1;

  final MINIMUM = 0.8;
  final MAXIMUM = 1.0;
  final duration = 8;
  final getStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
    // callAuthenticateAPI();
  }

  checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 8), () async {
      var token = await LocalStorageHelper.getAuthInfoFromStorage();
      await callAuthenticateAPI(token?['token']);

      print('token: ${token?['token']}');
      if (token?['token'] == null || token?['token']?.isEmpty) {
        Get.offAll(() => LoginPage());
        return;
      }

      Get.offAll(() => MainPage());
    });
  }

  callAuthenticateAPI(token) async {
    final response = await APIHelper().request(
      url: 'seller/info',
      method: Method.GET,
      token: token,
    );
    print('response authenticate: ${response.data}');
    userInfoModel.value = UserInfoModel.fromJson(response.data);
    if (userInfoModel.value?.status == true) {
      print('userInfoModel: ${userInfoModel.value?.data?.name}');
      // Get.offAll(() => MainPage());
    } else {
      GetStorage().erase();
      Get.offAll(() => LoginPage());
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
