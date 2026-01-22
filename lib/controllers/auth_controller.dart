import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/helpers/functional_constant.dart';
import 'package:izma_foods_vendor/models/profile_model.dart';
import 'package:izma_foods_vendor/models/register_model.dart';
import 'package:izma_foods_vendor/pages/auth/register_page_one.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool shouldShowPassword = false.obs;

  final GlobalKey<FormState> form = GlobalKey();
  final TextEditingController userEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
      TextEditingController();

  final FocusNode userFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final registerModel = Rxn<RegisterModel>();

    final profileModel = Rxn<ProfileModel>();

  register({
    required String name,
    required String mobile,
    required String email,
    required String password,
    required String role,
  }) async {
    // final deviceInfo = await FunctionalConstants().getDeviceInfo();
    // isLoading(true);
    // try {
    //   final response = await APIHelper().request(
    //     url: 'register',
    //     method: Method.POST,
    //     params: {
    //       'name': name,
    //       'email': email,
    //       'mobile': mobile,
    //       'role': role,
    //       'password': password,
    //       'device_id': deviceInfo['deviceID'],
    //       ...Get.find<LocationController>().getLocationMap,
    //     },
    //   );

    //   // Parse response into BaseModel (status + message)
    //   registerModel.value = RegisterModel.fromJson(response.data);
    //   if (registerModel.value?.status == true) {
    //     showSnackBar(registerModel.value?.messege ?? 'Registration failed');
    await Get.offAll(() => RegisterPageOne());
    //   } else {
    //     throw APIException(
    //       message: registerModel.value?.messege ?? 'Registration failed',
    //       statusCode: response.statusCode ?? 500,
    //     );
    //   }
    // } catch (e) {
    //   handleControllerExceptions(e);
    // } finally {
    //   isLoading(false);
    // }
  }

  Future<void> loginWithGoogle() async {
    // signOutGoogle();
    // try {
    //   const String serverClientId =
    //       '659535326641-t73h7l2bbrtrsfjfm0mskii3q6odm4eb.apps.googleusercontent.com';
    //   await GoogleSignIn.instance.initialize(
    //     serverClientId: serverClientId,
    //     // scopes: ['email', 'profile'],
    //   );
    //   final GoogleSignInAccount googleUser =
    //       await GoogleSignIn.instance.authenticate();

    //   final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    //   if (googleAuth.idToken == null) {
    //     throw Exception('Failed to obtain idToken');
    //   }
    //   print('googleAuth: ${googleAuth.idToken}');
    // } catch (e) {
    //   print('Error during Google sign-in: ${e.toString()}');
    //   showSnackBar('Failed to sign in with Google: ${e.toString()}');
    //   handleControllerExceptions(e);
    // } finally {
    //   // isLoading(false);
    // }
  }

  Future<void> loginWithFacebook() async {
    // try {
    //   final LoginResult result = await FacebookAuth.instance.login(
    //     permissions: [
    //       'public_profile',
    //       // 'email'
    //     ],
    //   );

    //   if (result.status == LoginStatus.success) {
    //     print('result: ${result.accessToken}');
    //     AccessToken? accessToken = result.accessToken;
    //     print('accessToken: ${accessToken?.tokenString}');
    //     String? accessTokenString = accessToken?.tokenString;

    //     if (accessTokenString != null) {
    //       // await _facebookAuth(accessTokenString,);
    //     }
    //   } else {
    //     debugPrint('Facebook login failed: ${result.message}');
    //   }
    // } catch (e) {
    //   debugPrint('Error during Facebook login: $e');
    //   await FacebookAuth.instance.logOut();
    //   rethrow;
    // }
  }

  /// Sign out from Google
  Future<void> signOutGoogle() async {
    // try {
    //   await _googleSignIn.disconnect();
    //   print('Signed out from Google');
    // } catch (e) {
    //   print('Error signing out from Google: ${e.toString()}');
    // }
  }
}
