import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/controllers/auth_controller.dart';
import 'package:izma_foods_vendor/helpers/global_helpers.dart';
import 'package:izma_foods_vendor/models/register_model.dart';

import '../../config/theme.dart';
import '../widget/izma_app_bar.dart';
import '../widget/izma_primary_button.dart';
import '../widget/izma_radial_gradient_container.dart';
import '../widget/izma_text_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final RxBool _shouldShowPassword = false.obs;
  final RxBool _shouldShowPasswordConfirmation = false.obs;
  final AuthController _authController = Get.put(AuthController());

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _mobileEditingController =
      TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _passwordConfirmationEditingController =
      TextEditingController();
  final RxString _selectedRole = 'Customer'.obs;


  final GlobalKey<FormState> _form = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: IzmaRadialGradientContainer(
        child: SafeArea(
          child: Form(
            key: _form,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                IzmaAppBar(title: "Your Information"),
                SizedBox(height: 20.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kdPadding),
                  child: Text(
                      "It looks like you don't have account in this number. Please let us know some information for a secure service"),
                ),
                SizedBox(height: 25.h),
                IzmaTextField(
                  hintText: "Full Name",
                  controller: _nameEditingController,
                  validator: (value) => value == null || value.length == 0
                      ? 'Please enter your full name.'
                      : null,
                  prefixIcon: Icons.account_circle_outlined,
                ),
                IzmaTextField(
                  hintText: "Phone Number",
                  prefix: "03",
                  controller: _mobileEditingController,
                  validator: (value) => value == null || value.length != 9
                      ? 'Please enter your valid phone number.'
                      : null,
                  prefixIcon: Icons.phone_outlined,
                ),
                IzmaTextField(
                  hintText: "Email Address",
                  controller: _emailEditingController,
                  validator: (value) => !GetUtils.isEmail(value ?? '')
                      ? 'Invalid email address.'
                      : null,
                  prefixIcon: Icons.email_outlined,
                ),
                Obx(
                  () => IzmaTextField(
                    hintText: "Password",
                    controller: _passwordEditingController,
                    validator: (value) => value == null || value.length < 8
                        ? 'Password must be at least 8 characters.'
                        : null,
                    prefixIcon: Icons.lock_outline_rounded,
                    suffixIcon: GestureDetector(
                      onTap: () => _shouldShowPasswordConfirmation(
                          !_shouldShowPasswordConfirmation.value),
                      child: Icon(
                          _shouldShowPasswordConfirmation.value
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off_outlined,
                          size: 20),
                    ),
                    obscureText: _shouldShowPasswordConfirmation.value,
                  ),
                ),
                Obx(
                  () => IzmaTextField(
                    hintText: "Confirm Password",
                    controller: _passwordConfirmationEditingController,
                    validator: (value) => value == null ||
                            value != _passwordEditingController.text
                        ? 'Passwords do not match.'
                        : null,
                    prefixIcon: Icons.lock_outline_rounded,
                    suffixIcon: GestureDetector(
                      onTap: () =>
                          _shouldShowPassword(!_shouldShowPassword.value),
                      child: Icon(
                          _shouldShowPassword.value
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off_outlined,
                          size: 20),
                    ),
                    obscureText: _shouldShowPassword.value,
                  ),
                ),
                // SizedBox(height: 10.h),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: kdPadding),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         "Select Role",
                //         style:
                //             Theme.of(context).textTheme.titleMedium?.copyWith(
                //                   fontWeight: FontWeight.w600,
                //                 ),
                //       ),
                //       SizedBox(height: 10.h),
                //       Container(
                //         decoration: BoxDecoration(
                //           color: kcGreyColor,
                //           borderRadius: BorderRadius.circular(kdBorderRadius),
                //         ),
                //         padding: EdgeInsets.symmetric(
                //             vertical: 8.h, horizontal: 4.w),
                //         child: Obx(
                //           () => Column(
                //             children: [
                //               RadioListTile<String>(
                //                 title: Text("Customer"),
                //                 value: 'customer',
                //                 groupValue: _selectedRole.value,
                //                 onChanged: (value) {
                //                   if (value != null) {
                //                     _selectedRole.value = value;
                //                   }
                //                 },
                //                 activeColor: kcSecondaryColor,
                //                 contentPadding:
                //                     EdgeInsets.symmetric(horizontal: 12.w),
                //               ),
                //               SizedBox(height: 8.h),

                //               RadioListTile<String>(
                //                 title: Text("Rider"),
                //                 value: 'rider',
                //                 groupValue: _selectedRole.value,
                //                 onChanged: (value) {
                //                   if (value != null) {
                //                     _selectedRole.value = value;
                //                   }
                //                 },
                //                 activeColor: kcSecondaryColor,
                //                 contentPadding:
                //                     EdgeInsets.symmetric(horizontal: 12.w),
                //               ),
                //               SizedBox(height: 8.h),
                //               RadioListTile<String>(
                //                 title: Text("Seller"),
                //                 value: 'seller',
                //                 groupValue: _selectedRole.value,
                //                 onChanged: (value) {
                //                   if (value != null) {
                //                     _selectedRole.value = value;
                //                   }
                //                 },
                //                 activeColor: kcSecondaryColor,
                //                 contentPadding:
                //                     EdgeInsets.symmetric(horizontal: 12.w),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                selectType('Customer', context),
                SizedBox(height: 10.h),
                selectType('Rider', context),
                SizedBox(height: 10.h),
                selectType('Seller', context),
                SizedBox(height: 15.h),
                Visibility(
                  visible: _authController.registerModel.value?.role
                              ?.toLowerCase() !=
                          null &&
                      _authController.registerModel.value?.role
                              ?.toLowerCase() !=
                          'customer',
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Note: You have successfully registered as a ${_authController.registerModel.value?.role?.toLowerCase()}. You can download the related app by clicking the button below.",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kdPadding),
                          child: IzmaPrimaryButton(
                            title: "Download App",
                            onTap: () {},
                            suffixIcon: Icons.download,
                            bgColor: kcSecondaryColor,
                            textColor: Colors.white,
                            disablePadding: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(() {
                  return _authController.isLoading.value
                      ? getLoading()
                      : IzmaPrimaryButton(
                          title: "Register",
                          onTap: () {
                            if (_form.currentState!.validate()) {
                              _authController.register(
                                email: _emailEditingController.text.trim(),
                                mobile:
                                    '03' + _mobileEditingController.text.trim(),
                                name: _nameEditingController.text.trim(),
                                password: _passwordConfirmationEditingController
                                    .text
                                    .trim(),
                                role: _selectedRole.value,
                              );
                            }
                          },
                        );
                }),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectType(String title, BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => _selectedRole.value = title,
        child: Container(
          decoration: BoxDecoration(
            color: kcGreyColor,
            borderRadius: BorderRadius.circular(kdBorderRadius),
          ),
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10),
          margin: EdgeInsets.symmetric(horizontal: kdPadding),
          child: Row(
            children: [
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        _selectedRole.value.toLowerCase() == title.toLowerCase()
                            ? kcSecondaryColor
                            : Colors.black,
                  ),
                  color:
                      _selectedRole.value.toLowerCase() == title.toLowerCase()
                          ? kcSecondaryColor
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: _selectedRole.value.toLowerCase() == title.toLowerCase()
                    ? Icon(Icons.check, size: 15, color: kcPrimaryColor)
                    : SizedBox(),
              ),
              SizedBox(width: 20.w),
              Text(
                "I'm ${title}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
