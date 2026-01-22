import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/pages/auth/login_page.dart';
import 'package:izma_foods_vendor/pages/auth/register_page_one.dart';

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
  final duration = 800;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: duration), (timer) {
      setState(() {
        if (opacity == MINIMUM) {
          opacity = MAXIMUM;
        } else {
          opacity = MINIMUM;
        }
      });
    });
    init();
  }

  init() async {
    await Future.delayed(Duration(seconds: kDebugMode ? 0 : 5));
    Get.offAll(() => LoginPage());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IzmaRadialGradientContainer(
        child: AnimatedOpacity(
          duration: Duration(milliseconds: duration),
          opacity: opacity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/app_logo.png',
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              SizedBox(height: 10.h),
              Text("Deliver all your Food Needs", style: Theme.of(context).textTheme.displayLarge),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
