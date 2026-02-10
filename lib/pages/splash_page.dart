import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:izma_foods_vendor/config/local_storage.dart';
import 'package:izma_foods_vendor/pages/auth/login_page.dart';
import 'package:izma_foods_vendor/pages/main_page.dart';
import 'package:lottie/lottie.dart';

import 'widget/izma_radial_gradient_container.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Timer _timer;
  double opacity = 0.1;

  final MINIMUM = 0.8;
  final MAXIMUM = 1.0;
  final duration = 8;
  final getStorage = GetStorage();

  @override
  void initState() {
    super.initState();
    // _timer = Timer.periodic(Duration(seconds: duration), (timer) {
    //   setState(() {
    //     if (opacity == MINIMUM) {
    //       opacity = MAXIMUM;
    //     } else {
    //       opacity = MINIMUM;
    //     }
    //   });
    // });

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => init(),
    );
    // init();
  }

  init() async {
    await Future.delayed(Duration(seconds: duration), () async {
      var token = await LocalStorageHelper.getAuthInfoFromStorage();
      print('token: ${token?['token']}');
      if (token?['token'] == null || token?['token']?.isEmpty) {
        Get.offAll(() => LoginPage());
        return;
      }

      Get.offAll(() => MainPage());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        body: IzmaRadialGradientContainer(
      child: Lottie.asset(
        'assets/splash/animation.json',
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
        repeat: true,
        onLoaded: (composition) {
          // Animation loaded successfully
          debugPrint('Lottie animation loaded successfully');
        },
      ),
    ));
  }
}
