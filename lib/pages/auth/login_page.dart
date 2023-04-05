import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../config/theme.dart';
import 'location_picker_page.dart';
import '../widget/izma_radial_gradient_container.dart';

import '../widget/izma_phone_field.dart';
import '../widget/izma_primary_button.dart';
import '../widget/izma_text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final RxBool shouldShowPassword = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IzmaRadialGradientContainer(
        child: SafeArea(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Image.asset('assets/images/phone_mockup.png', height: 300.h),
              SizedBox(height: 20.h),
              doNotHaveAnAccount(context),
              SizedBox(height: 30.h),
              IzmaPhoneField(),
              Obx(
                () => IzmaTextField(
                  prefixIcon: Icons.lock_outline_rounded,
                  hintText: "Password",
                  suffixIcon: GestureDetector(
                    onTap: () => shouldShowPassword(!shouldShowPassword.value),
                    child: Icon(shouldShowPassword.value ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined, size: 20),
                  ),
                  obscureText: shouldShowPassword.value,
                ),
              ),
              // SizedBox(height: 100.h),
              IzmaPrimaryButton(
                title: "Login",
                // onTap: () => Get.offAll(() => MainPage()),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget doNotHaveAnAccount(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kdPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Login", style: Theme.of(context).textTheme.bodyLarge),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            children: [
              Text(
                "Don't Have Account?",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.normal, fontSize: 12),
              ),
              GestureDetector(
                onTap: () => Get.to(() => LocationPickerPage()),
                child: Text(
                  ' Click Here',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 12,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
