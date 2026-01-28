import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/controllers/auth_controller.dart';
import 'package:izma_foods_vendor/helpers/global_helpers.dart';
import 'package:izma_foods_vendor/pages/auth/register_page.dart';

import '../../config/theme.dart';
import '../widget/izma_primary_button.dart';
import '../widget/izma_radial_gradient_container.dart';
import '../widget/izma_text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IzmaRadialGradientContainer(
        child: SafeArea(
          child: Form(
            key: _authController.form,
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                Image.asset('assets/images/phone_mockup.png', height: 300.h),
                SizedBox(height: 20.h),
                doNotHaveAnAccount(context),
                SizedBox(height: 30.h),
                IzmaTextField(
                  prefixIcon: Icons.account_circle_outlined,
                  hintText: "Email or Phone Number",
                  controller: _authController.userEditingController,
                  focusNode: _authController.userFocus,
                  nextFocusNode: _authController.passwordFocus,
                  validator: (value) => value == null || value.length == 0
                      ? "Please enter your phone number."
                      : null,
                ),
                Obx(
                  () => IzmaTextField(
                    hintText: "Password",
                    controller: _authController.passwordEditingController,
                    focusNode: _authController.passwordFocus,
                    validator: (value) => value == null || value.length == 0
                        ? 'Please enter your password.'
                        : null,
                    prefixIcon: Icons.lock_outline_rounded,
                    suffixIcon: GestureDetector(
                      onTap: () => _authController.shouldShowPassword(
                          !_authController.shouldShowPassword.value),
                      child: Icon(
                          _authController.shouldShowPassword.value
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off_outlined,
                          size: 20),
                    ),
                    obscureText: _authController.shouldShowPassword.value,
                  ),
                ),
                Obx(
                  () {
                    return _authController.isLoading.value
                        ? getLoading()
                        : IzmaPrimaryButton(
                            title: "Login",
                            onTap: () {
                              if (_authController.form.currentState!
                                  .validate()) {
                                _authController.login(
                                  emailOrPhoneNumber: _authController
                                      .userEditingController.text,
                                  password: _authController
                                      .passwordEditingController.text,
                                );
                              }
                            },
                          );
                  },
                ),
              ],
            ),
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
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.normal, fontSize: 12),
              ),
              GestureDetector(
                onTap: () => Get.to(() => RegisterPage()),
                child: Text(
                  ' Signup',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
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
