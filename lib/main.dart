import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:izma_foods_vendor/pages/splash_page.dart';

import 'config/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/images/phone_mockup.png'), context);
    precacheImage(AssetImage('assets/images/radial-background.png'), context);
    precacheImage(AssetImage('assets/images/app_logo.png'), context);

    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IZMA Food',
        theme: ThemeData(
          primaryColor: kcPrimaryColor,
          scaffoldBackgroundColor: Color(0xfffefeff),
          colorScheme: ColorScheme.light(secondary: kcSecondaryColor, primaryContainer: Colors.white),
          fontFamily: 'Poppins',
          textTheme: TextTheme(
            displayLarge: TextStyle(
              fontSize: 25,
            ),
            displaySmall: TextStyle(fontSize: 12),
            bodyLarge: TextStyle(
              fontSize: 16,
            ),
            bodyMedium: TextStyle(
              fontSize: 14,
            ),
            bodySmall: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
