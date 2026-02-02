import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:izma_foods_vendor/config/local_storage.dart';
import 'package:izma_foods_vendor/helpers/api_exception.dart';
import 'package:izma_foods_vendor/helpers/global_helpers.dart';
import 'package:izma_foods_vendor/models/base_model.dart';
import 'package:izma_foods_vendor/models/login_model.dart';
import 'package:izma_foods_vendor/models/main_model.dart';
import 'package:izma_foods_vendor/models/profile_model.dart';
import 'package:izma_foods_vendor/models/register_model.dart';
import 'package:izma_foods_vendor/models/register_page_one_model.dart';
import 'package:izma_foods_vendor/models/register_page_two_model.dart';
import 'package:izma_foods_vendor/models/shop_details_model.dart';
import 'package:izma_foods_vendor/pages/auth/hurray_page.dart';
import 'package:izma_foods_vendor/pages/auth/login_page.dart';
import 'package:izma_foods_vendor/pages/auth/register_page_one.dart';
import 'package:izma_foods_vendor/pages/auth/register_page_three.dart';
import 'package:izma_foods_vendor/pages/auth/register_page_two.dart';
import 'package:izma_foods_vendor/pages/main_page.dart';
import 'package:izma_foods_vendor/pages/splash_page.dart';

import '../helpers/api_helper.dart';

class AuthController extends GetxController {
  final ImagePicker imagePicker = ImagePicker();
  final RxBool isLoading = false.obs;
  final RxBool shouldShowPassword = false.obs;
  Rx<LoginModel?> loginModel = Rx(null);
  final baseModel = Rxn<BaseModel>();
  Rx<BaseModel?> updateProfileModel = Rx(null);
  final registerPageOneModel = Rxn<RegisterPageOneModel>();
  final registerPageTwoModel = Rxn<RegisterPageTwoModel>();
  final shopDetailsModel = Rxn<ShopDetailsModel>();
  final GlobalKey<FormState> form = GlobalKey();
  final TextEditingController userEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  final FocusNode userFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final registerModel = Rxn<RegisterModel>();
  final profileModel = Rxn<ProfileModel>();
  final RxString dateOfBirth = ''.obs;
  // Register Page One controllers
  final addressController = TextEditingController();

  // Register Page Two controllers
  final shopNameController = TextEditingController();
  final shopTypeController = TextEditingController();
  final shopCategoryController = TextEditingController();
  final bankController = TextEditingController();
  final accountTitleController = TextEditingController();
  final accountNumberController = TextEditingController();

  // Observable state
  final selectedGender = 'Male'.obs;
  // Generic selected image (used on Register Page One)
  final selectedImage = Rxn<File>();

  // Register Page Two / Three image state
  final shopLogoFile = Rxn<File>();
  final shopBannerFile = Rxn<File>();
  final cnicFrontFile = Rxn<File>();
  final cnicBackFile = Rxn<File>();
  final foodCertificateFile = Rxn<File>();
  final ntnFile = Rxn<File>();
  // list of shop types
  final shopTypes = ['Wholesale', 'Retail'].obs;
  // list of banks in pakistan
  final banks = [
    'HBL',
    'UBL',
    'MCB',
    'Faysal',
    'Askari',
    'Housing',
    'Standard Chartered',
    'Sindh Bank',
    'NBP',
    'JS Bank',
    'United Bank',
    'Allied Bank',
    'Bank of Khyber',
    'Bank of Punjab',
    'Bank of Sindh',
    'Bank of Balochistan',
    'Bank of Gilgit-Baltistan',
    'Bank of Kashmir',
    'Bank of Gilgit-Baltistan',
    'Bank of Kashmir'
  ].obs;

  final selectedShopType = ''.obs;
  final selectedBank = ''.obs;

  final shopCategoriesModel = Rxn<MainModel>();
  final selectedShopCategory = Rxn<Category>();

  onInit() {
    super.onInit();
    getShopCategoriesModel();
  }

  getShopCategoriesModel() async {
    isLoading(true);
    try {
      final response = await APIHelper().request(
        url: 'categories',
        method: Method.GET,
      );
      print('response login: ${jsonEncode(response.data)}');
      shopCategoriesModel.value = MainModel.fromJson(response.data);
      if (shopCategoriesModel.value?.status == true) {
        isLoading(false);
      } else {
        throw APIException(
          message: 'Failed to get shop categories',
          statusCode: response.statusCode ?? 500,
        );
      }
    } catch (e) {
      handleControllerExceptions(e);
    } finally {
      isLoading(false);
    }
  }

  login({
    required String emailOrPhoneNumber,
    required String password,
  }) async {
    // final deviceInfo = await FunctionalConstants().getDeviceInfo();
    // print(deviceInfo['deviceID']);
    isLoading(true);
    try {
      final response = await APIHelper().request(
        url: 'login',
        method: Method.POST,
        params: {
          'user': emailOrPhoneNumber,
          'password': password,
          // 'device_id': deviceInfo['deviceID'],
        },
      );
      print('response login: ${jsonEncode(response.data)}');
      loginModel.value = LoginModel.fromJson(response.data);
      // If API still uses old error format with status == false
      if (loginModel.value != null && loginModel.value?.status == false) {
        throw APIException(
          message: loginModel.value?.data?.massage ?? 'Login failed',
          statusCode: response.statusCode ?? 500,
        );
      }

      // Persist auth info (for auto-login, etc.)
      await LocalStorageHelper.storageAutInfo(
        token: loginModel.value?.data?.token ?? '',
      );

      // Check success message and navigate
      if (loginModel.value?.status == true) {
        if (loginModel.value?.data?.user?.shop == null) {
          Get.offAll(() => RegisterPageOne());
        } else if (loginModel.value?.data?.user?.shop?.status == 'inactive') {
          Get.offAll(() => HurrayPage());
        } else {
          Get.offAll(() => MainPage());
        }
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

  register({
    required String name,
    required String mobile,
    required String email,
    required String password,
    required String role,
  }) async {
    // final deviceInfo = await FunctionalConstants().getDeviceInfo();
    isLoading(true);
    try {
      var latlong = await getCurrentLocation();
      // print(latlong.)
      final response = await APIHelper().request(
        url: 'register',
        method: Method.POST,
        params: {
          'name': name,
          'email': email,
          'mobile': mobile,
          'role': role,
          'password': password,
          // 'device_id': deviceInfo['deviceID'],
          'lat': latlong.latitude,
          'lng': latlong.longitude,
        },
      );

      registerModel.value = RegisterModel.fromJson(response.data);
      if (registerModel.value?.status == true) {
        showSnackBar(registerModel.value?.messege ?? 'Registration failed');
        isLoading(false);
        // if (role == 'seller') {
        // await Get.offAll(RegisterPageOne());
        await Get.offAll(() => LoginPage());
        // }
        // await Get.offAll(() => LoginPage());
      } else {
        throw APIException(
          message: registerModel.value?.messege ?? 'Registration failed',
          statusCode: response.statusCode ?? 500,
        );
      }
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

  void setGender(String gender) {
    selectedGender.value = gender;
  }

  Future<void> selectDateOfBirth() async {
    // Calculate date 18 years ago
    final DateTime eighteenYearsAgo = DateTime(
      DateTime.now().year - 18,
      DateTime.now().month,
      DateTime.now().day,
    );

    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: eighteenYearsAgo,
      firstDate: DateTime(1900),
      lastDate: eighteenYearsAgo,
    );
    {
      if (picked != null) {
        dateOfBirth.value = DateFormat('yyyy-MM-dd').format(picked);
      }
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await imagePicker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: ${e.toString()}');
    }
  }

  Future<void> showImageSourceDialog() async {
    return Get.dialog(
      AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Get.back();
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Get.back();
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  void clearImage() {
    selectedImage.value = null;
  }

  // Helpers for Register Page Two image picking
  Future<void> showShopImageSourceDialog(String fieldKey) async {
    return Get.dialog(
      AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Get.back();
                _pickShopImage(fieldKey, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Get.back();
                _pickShopImage(fieldKey, ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickShopImage(String fieldKey, ImageSource source) async {
    try {
      final XFile? image = await imagePicker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        final file = File(image.path);
        switch (fieldKey) {
          case 'logo':
            shopLogoFile.value = file;
            await uploadShopImage(
              field: fieldKey,
              shopId: registerPageTwoModel.value?.data?.id.toString() ?? '',
              image: file,
            );
            break;
          case 'banner':
            shopBannerFile.value = file;
            await uploadShopImage(
              field: fieldKey,
              shopId: registerPageTwoModel.value?.data?.id.toString() ?? '',
              image: file,
            );
            break;
          case 'fcnic':
            cnicFrontFile.value = file;
            await uploadShopImage(
              field: fieldKey,
              shopId: registerPageTwoModel.value?.data?.id.toString() ?? '',
              image: file,
            );
            break;
          case 'bcnic':
            cnicBackFile.value = file;
            await uploadShopImage(
              field: fieldKey,
              shopId: registerPageTwoModel.value?.data?.id.toString() ?? '',
              image: file,
            );
            break;
          case 'licence_photo':
            foodCertificateFile.value = file;
            await uploadShopImage(
              field: fieldKey,
              shopId: registerPageTwoModel.value?.data?.id.toString() ?? '',
              image: file,
            );
            break;
          case 'ntn_photo':
            ntnFile.value = file;
            await uploadShopImage(
              field: fieldKey,
              shopId: registerPageTwoModel.value?.data?.id.toString() ?? '',
              image: file,
            );
            break;
          default:
            break;
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: ${e.toString()}');
    }
  }

  Future<void> registerPageOne() async {
    var token = await LocalStorageHelper.getAuthInfoFromStorage();
    try {
      isLoading(true);

      // Create FormData for multipart/form-data upload
      Map<String, dynamic> formDataMap = {
        'name': loginModel.value?.data?.user?.name?.trim(),
        'mobile': 031066690634,
        // int.parse(loginModel.value?.data?.user?.mobile ?? '0000000000'),
        'dob': dateOfBirth.value.trim(),
        'gender': selectedGender.value.toLowerCase().trim(),
      };
      print('formDataMap: ${jsonEncode(formDataMap)}');
      // Add photo as MultipartFile if image is selected
      if (selectedImage.value != null) {
        formDataMap['photo'] = await MultipartFile.fromFile(
          selectedImage.value!.path,
          filename: selectedImage.value!.path.split('/').last,
        );
      }

      FormData formData = FormData.fromMap(formDataMap);

      final response = await APIHelper().request(
        url: 'seller/update/profile',
        method: Method.POST,
        params: formData,
        token: token?['token'],
      );
      registerPageOneModel.value = RegisterPageOneModel.fromJson(response.data);
      print('response register page one: ${jsonEncode(response.data)}');

      if (registerPageOneModel.value?.message ==
          'Profile Updated Successfully') {
        showSnackBar(
            response.data['messege'] ?? 'Profile updated successfully');
        Get.off(() => RegisterPageTwo());
      } else {
        throw APIException(
          message: response.data['messege'] ?? 'Failed to update profile',
          statusCode: response.statusCode ?? 500,
        );
      }
    } catch (e) {
      handleControllerExceptions(e);
    } finally {
      isLoading(false);
    }
  }

  Future<void> registerPageTwo() async {
    var token = await LocalStorageHelper.getAuthInfoFromStorage();
    var latlong = await getCurrentLocation();
    try {
      isLoading(true);

      final response = await APIHelper().request(
        url: 'seller/shop/create',
        method: Method.POST,
        params: {
          'shop_name': shopNameController.text.trim(),
          'lat': latlong.latitude.toString(),
          'lng': latlong.longitude.toString(),
          'shop_category': selectedShopCategory.value?.id,
          'shop_type': selectedShopType.value.trim(),
          'ip': '144.48.134.188',
        },
        token: token?['token'],
      );
      registerPageTwoModel.value = RegisterPageTwoModel.fromJson(response.data);
      print('response register page two: ${jsonEncode(response.data)}');

      if (registerPageTwoModel.value?.success ==
          'You Shop data has been receive for verification please wait for approval') {
        showSnackBar(response.data['messege'] ?? 'Shop created successfully');
        Get.to(() => const RegisterPageThree());
      } else {
        throw APIException(
          message: response.data['messege'] ?? 'Failed to create shop',
          statusCode: response.statusCode ?? 500,
        );
      }
    } catch (e) {
      handleControllerExceptions(e);
    } finally {
      isLoading(false);
    }
  }

  Future<void> uploadShopImage(
      {required String field,
      required String shopId,
      required File image}) async {
    var token = await LocalStorageHelper.getAuthInfoFromStorage();
    try {
      isLoading(true);

      // Create FormData for multipart/form-data upload
      Map<String, dynamic> formDataMap = {
        'field': field,
        'shop_id': shopId,
      };

      formDataMap['docs'] = await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      );

      FormData formData = FormData.fromMap(formDataMap);

      final response = await APIHelper().request(
        url: 'seller/shop/document',
        method: Method.POST,
        params: formData,
        token: token?['token'],
      );
      baseModel.value = BaseModel.fromJson(response.data);
      print('response register page one: ${jsonEncode(response.data)}');

      if (baseModel.value?.status == true) {
        showSnackBar(
            response.data['messege'] ?? 'Document uploaded successfully');
      } else {
        throw APIException(
          message: response.data['messege'] ?? 'Failed to upload document',
          statusCode: response.statusCode ?? 500,
        );
      }
    } catch (e) {
      handleControllerExceptions(e);
    } finally {
      isLoading(false);
    }
  }

  /// Register Page Three: go to main page (call when Continue is tapped; required files already checked in UI).
  Future<void> registerPageThree() async {
    Get.offAll(() => MainPage());
  }

  getShopDetails() async {
    var token = await LocalStorageHelper.getAuthInfoFromStorage();
    try {
      isLoading(true);
      final response = await APIHelper().request(
        url: 'seller/shop',
        method: Method.GET,
        token: token?['token'],
      );
      shopDetailsModel.value = ShopDetailsModel.fromJson(response.data);
      print('response shop details: ${jsonEncode(response.data)}');
      if (shopDetailsModel.value?.status == true) {
        showSnackBar('Shop details fetched successfully');
      } else {
        throw APIException(
          message: 'Failed to fetch shop details',
          statusCode: response.statusCode ?? 500,
        );
      }
    } catch (e) {
      handleControllerExceptions(e);
    } finally {
      isLoading(false);
    }
  }
}
