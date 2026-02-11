import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/controllers/splash_controller.dart';
import 'widget/izma_radial_gradient_container.dart';

class SplashPage extends GetView<SplashController> {
  SplashPage({super.key});
  final controller = Get.put(SplashController());
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
