import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:izma_foods_vendor/helpers/api_exception.dart';
import 'package:izma_foods_vendor/helpers/functional_constant.dart';
import 'package:izma_foods_vendor/helpers/global_helpers.dart';
import 'package:izma_foods_vendor/models/base_model.dart';
import 'package:izma_foods_vendor/models/login_model.dart';
import 'package:izma_foods_vendor/models/profile_model.dart';
import 'package:izma_foods_vendor/models/register_model.dart';
import 'package:izma_foods_vendor/pages/main_page.dart';
import 'package:izma_foods_vendor/pages/splash_page.dart';

import '../helpers/api_helper.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool shouldShowPassword = false.obs;
  Rx<LoginModel?> loginModel = Rx(null);
  Rx<BaseModel?> baseModel = Rx(null);
  // Rx<RegisterModel?> registerModel = Rx(null);
  Rx<BaseModel?> updateProfileModel = Rx(null);
  // final profileModel = Rxn<ProfileModel>();

  // Google Sign In instance (singleton)
  // final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final GlobalKey<FormState> form = GlobalKey();
  final TextEditingController userEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  final FocusNode userFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final registerModel = Rxn<RegisterModel>();
  final profileModel = Rxn<ProfileModel>();

  login({
    required String emailOrPhoneNumber,
    required String password,
  }) async {
    final deviceInfo = await FunctionalConstants().getDeviceInfo();
    print(deviceInfo['deviceID']);
    isLoading(true);
    try {
      final response = await APIHelper().request(
        url: 'login',
        method: Method.POST,
        params: {
          'user': emailOrPhoneNumber,
          'password': password,
          'device_id': deviceInfo['deviceID'],
        },
      );

      loginModel.value = LoginModel.fromJson(response.data);
      // If API still uses old error format with status == false
      if (loginModel.value != null &&
          loginModel.value?.data?.massage != "Login Successfully!") {
        throw APIException(
          message: response.data['messege'] ?? 'Login failed',
          statusCode: response.statusCode ?? 500,
        );
      }

      // Persist auth info (for auto-login, etc.)
      // await LocalStorageHelper.storageAutInfo(
      //   email: emailOrPhoneNumber,
      //   password: password,
      //   token: loginModel.value?.data?.token ?? '',
      // );

      // Check success message and navigate
      if (loginModel.value?.data?.massage == "Login Successfully!") {
        Get.offAll(() => MainPage());
      } else {
        // If message is something else, show it as feedback
        showSnackBar(loginModel.value?.data?.massage ?? 'Login failed');
      }
    } catch (e) {
      handleControllerExceptions(e);
    } finally {
      isLoading(false);
    }
  }

  // Future<bool> attemptLogin() async {
  //   Map<String, dynamic>? authData =
  //       await LocalStorageHelper.getAuthInfoFromStorage();
  //   if (authData != null) {
  //     await login(
  //         emailOrPhoneNumber: authData['user'], password: authData['password']);
  //     return loginModel.value != null;
  //   }
  //   return false;
  // }

  register({
    required String name,
    required String mobile,
    required String email,
    required String password,
    required String role,
  }) async {
    final deviceInfo = await FunctionalConstants().getDeviceInfo();
    isLoading(true);
    try {
      final response = await APIHelper().request(
        url: 'register',
        method: Method.POST,
        params: {
          'name': name,
          'email': email,
          'mobile': mobile,
          'role': role,
          'password': password,
          'device_id': deviceInfo['deviceID'],
          // ...Get.find<LocationController>().getLocationMap,
        },
      );

      // Parse response into BaseModel (status + message)
      // registerModel.value = RegisterModel.fromJson(response.data);
      // if (registerModel.value?.status == true) {
      //   showSnackBar(registerModel.value?.messege ?? 'Registration failed');
      //   await Get.offAll(() => LoginPage());
      // } else {
      //   throw APIException(
      //     message: registerModel.value?.messege ?? 'Registration failed',
      //     statusCode: response.statusCode ?? 500,
      //   );
      // }
    } catch (e) {
      handleControllerExceptions(e);
    } finally {
      isLoading(false);
    }
  }

  logOut() async {
    // profileModel.value = ProfileModel();
    // profileModel.value = null;
    var box = GetStorage();
    await box.erase();
    this.loginModel.value = null;

    Get.offAll(() => SplashPage());
  }

  // Future<bool> checkToken() async {
  //   final authInfo = await LocalStorageHelper.getAuthInfoFromStorage();
  //   if (authInfo != null) {
  //     return true;
  //   }
  //   return false;
  // }

  getUserProfile() async {
    isLoading(true);

    try {
      // final authInfo = await LocalStorageHelper.getAuthInfoFromStorage();
      final response = await APIHelper().request(
        url: 'users/profile',
        method: Method.GET,
        // token: authInfo?['token'],
      );
      print('response userProfile ${jsonEncode(response.data)}');
      // profileModel.value = ProfileModel.fromJson(response.data);
      // if (profileModel.value?.success?.status == false) {
      //   throw APIException(
      //     message: profileModel.value?.success?.status ??
      //         'Failed to get user profile',
      //     statusCode: response.statusCode ?? 500,
      //   );
      // }
    } on APIException catch (e) {
      print('error user profile: ${e.message}');
    } catch (e) {
      print('error user profile: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateProfile({
    required String name,
    required String mobile,
    required String email,
    required String address,
    // required String dob,
    required String gender,
  }) async {
    print('update profile: $name, $mobile, $email, $address, $gender');
    isLoading(true);
    try {
      // final authInfo = await LocalStorageHelper.getAuthInfoFromStorage();
      final response = await APIHelper().request(
        url: 'user',
        method: Method.POST,
        params: {
          // 'user_id': profileModel.value?.success?.id?.toString(),
          // 'latitude': profileModel.value?.success?.lat?.toString(),
          // 'longitude': profileModel.value?.success?.lng?.toString(),
          'email': email.toString(),
          'mobile': mobile.toString(),
          'address': address.toString(),
          'gender': gender.toLowerCase().toString(),
          // 'dob': dob.toString(),
          'name': name.toString(),
        },
        // token: authInfo?['token'],
      );
      print('response update profile: ${jsonEncode(response.data)}');

      if (response.data['status'] == 'true') {
        await getUserProfile();
        showSnackBar(
            response.data['messege'] ?? 'Profile updated successfully');
        Get.back();
      } else {
        throw APIException(
          message: response.data['messege'] ?? 'Failed to update profile',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on APIException catch (e) {
      print('error update profile: ${e.message}');
    } catch (e) {
      print('error update profile: ${e.toString()}');
      handleControllerExceptions(e);
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateProfileImage(String filePath) async {
    isLoading(true);
    try {
      // final authInfo = await LocalStorageHelper.getAuthInfoFromStorage();

      // Create FormData for multipart/form-data upload
      FormData formData = FormData.fromMap({
        'profile_picture': await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        ),
      });

      final response = await APIHelper().request(
        url: 'user/profile/image',
        method: Method.POST,
        params: formData,
        // token: authInfo?['token'],
      );

      print('response update profile image: ${jsonEncode(response.data)}');

      // if (response.data['status'] == 'true') {
      await getUserProfile();
      showSnackBar(
          response.data['messege'] ?? 'Profile image updated successfully');
      // } else {
      // throw APIException(
      // message: response.data['messege'] ?? 'Failed to update profile image',
      // statusCode: response.statusCode ?? 500,
      // );
      // }
    } on APIException catch (e) {
      print('error update profile image: ${e.message}');
      showSnackBar(e.message);
    } catch (e) {
      print('error update profile image: ${e.toString()}');
      handleControllerExceptions(e);
    } finally {
      isLoading(false);
    }
  }
}
