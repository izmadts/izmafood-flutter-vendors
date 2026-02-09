import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:izma_foods_vendor/controllers/auth_controller.dart';
import 'package:izma_foods_vendor/helpers/global_helpers.dart';
import 'package:izma_foods_vendor/pages/auth/login_page.dart';
import 'package:izma_foods_vendor/pages/finance/finance_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/theme.dart';
import '../widget/izma_app_bar.dart';
import '../widget/izma_radial_gradient_container.dart';

class MorePage extends StatefulWidget {
  MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final AuthController _authController = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    // _authController.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IzmaRadialGradientContainer(
        child: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              IzmaAppBar(title: "More"),
              Obx(() {
                return ListTile(
                  onTap: () {
                    if (_authController.profileModel.value?.success?.id ==
                        null) {
                      Get.to(() => LoginPage());
                    }
                  },
                  leading:
                      _authController.profileModel.value?.success?.id == null
                          ? CircleAvatar(
                              radius: 25,
                              backgroundColor: kcGreyColor,
                              child: Icon(
                                Icons.password,
                                color: Colors.red,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl: profileImageUrl(
                                  _authController
                                          .profileModel.value?.success?.photo ??
                                      '',
                                ),
                                width: 45.w,
                                height: 45.w,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) {
                                  return Icon(Icons.person_2_outlined);
                                },
                              ),
                            ),
                  dense: true,
                  title: Text(
                      _authController.profileModel.value?.success?.name == null
                          ? "You are not logged in."
                          : _authController.profileModel.value?.success?.name ??
                              '',
                      style: Theme.of(context).textTheme.bodyLarge),
                  subtitle: Text(
                    _authController.profileModel.value?.success?.mobile == null
                        ? "Tap Here to login"
                        : _authController.profileModel.value?.success?.mobile ??
                            '',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _authController.profileModel.value == null
                            ? kcSecondaryColor
                            : null),
                  ),
                );
              }),
              SizedBox(height: kdPadding.h),
              _buildMenuItem(
                context: context,
                icon: Icons.edit_outlined,
                title: "Edit Profile",
                color: Colors.blue,
                // onTap: () => Get.to(() => EditProfilePage()),
              ),
              _buildMenuItem(
                  context: context,
                  icon: Icons.location_on_outlined,
                  title: "My Address",
                  onTap: () async {
                    // Get.to(() => MyAddressesPage());
                  }),
              _buildMenuItem(
                context: context,
                icon: Icons.shopping_basket_outlined,
                title: "My Orders",
                // onTap: () => Get.to(() => OrderTrackingPage()),

                // MyOrdersPage()),
              ),
              _buildMenuItem(
                context: context,
                icon: Icons.account_balance_wallet_outlined,
                title: "Finance",
                onTap: () => Get.to(() => const FinancePage()),
              ),
              _buildMenuItem(
                context: context,
                icon: Icons.bolt_outlined,
                title: "My Wishlist",
                // onTap: () => Get.to(
                //   () => WishListPage(),
                // ),
              ),
              // _buildMenuItem(
              //     context: context,
              //     icon: Icons.chat_bubble_outline_rounded,
              //     title: "Chat with us",
              //     color: kcSecondaryColor),
              // _buildMenuItem(
              //     context: context,
              //     icon: Icons.mail_outline_rounded,
              //     title: "Mail to us"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kdPadding + 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Connect with us",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSocialIcon(
                          // icon: Icons.facebook,
                          // color: Color(0xFF1877F2),
                          imageUrl: 'assets/images/facebook.svg',
                          url: 'https://www.facebook.com/izmafood',
                          label: 'Facebook',
                        ),
                        _buildSocialIcon(
                          // icon: Icons.music_note,
                          // color: Colors.black,
                          imageUrl: 'assets/images/tiktok.svg',
                          url: 'https://www.tiktok.com/@izmafood',
                          label: 'TikTok',
                        ),
                        _buildSocialIcon(
                          // icon: Icons.camera_alt,
                          // color: Color(0xFFE4405F),
                          imageUrl: 'assets/images/instagram.svg',
                          url: 'https://www.instagram.com/izmafood/',
                          label: 'Instagram',
                        ),
                        _buildSocialIcon(
                          // icon: Icons.play_circle_filled,
                          // color: Color(0xFFFF0000),
                          imageUrl: 'assets/images/youtube.svg',
                          url: 'https://www.youtube.com/@izma-food',
                          label: 'YouTube',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Divider(
                color: Colors.grey.withValues(alpha: 0.2),
                thickness: 1,
                height: 15,
              ),
              _buildMenuItem(
                context: context,
                icon: Icons.phone_outlined,
                title: "Talk to our Support",
                color: Colors.orange,
                isImage: true,
                imageUrl: 'assets/icons/whats-app.png',
                onTap: () => _openWhatsApp(),
              ),

              // Divider(),

              _buildMenuItem(
                  context: context,
                  icon: Icons.power_settings_new_rounded,
                  title: "Log out",
                  color: Colors.red,
                  onTap: () {
                    _authController.logOut();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openWhatsApp() async {
    try {
      // Get user information
      final userName =
          _authController.profileModel.value?.success?.name ?? 'Guest User';
      final userMobile =
          _authController.profileModel.value?.success?.mobile ?? 'N/A';
      final userEmail =
          _authController.profileModel.value?.success?.email ?? 'N/A';
      const String supportNumber = '923336152231';

      // Create pre-filled message with user information
      final message = '''Hello, I need support.

My Details:
Name: $userName
Phone: $userMobile
Email: $userEmail

Please assist me.''';

      // Encode the message for URL
      final encodedMessage = Uri.encodeComponent(message);

      // Create WhatsApp URL with pre-filled message
      final Uri whatsappUri =
          Uri.parse('https://wa.me/$supportNumber?text=$encodedMessage');

      // Launch WhatsApp
      final bool launched = await launchUrl(
        whatsappUri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        Get.snackbar(
          'Error',
          'Could not open WhatsApp. Please make sure WhatsApp is installed.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to open WhatsApp: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error launching WhatsApp: $e');
    }
  }

  Column _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    void Function()? onTap,
    Color? color,
    bool? isImage = false,
    String? imageUrl,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          tileColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: kdPadding + 10),
          leading: isImage == true
              ? Image.asset(
                  imageUrl ?? '',
                  width: 24.w,
                  height: 24.h,
                  fit: BoxFit.cover,
                )
              : Icon(
                  icon,
                  color: color ?? Colors.black,
                ),
          dense: true,
          minLeadingWidth: 10.w,
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black),
          ),
        ),
        Divider(
          color: Colors.grey.withValues(alpha: 0.2),
          thickness: 1,
          height: 15,
        ),
      ],
    );
  }

  Widget _buildSocialIcon({
    // required IconData icon,
    required String url,
    // required Color color,
    required String imageUrl,
    required String label,
  }) {
    return GestureDetector(
      onTap: () async {
        try {
          final Uri uri = Uri.parse(url);
          // Use externalApplication to open in browser/external app
          // This prevents the ERR_UNKNOWN_URL_SCHEME error
          await launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
          );
        } catch (e) {
          // If external application fails, show error
          Get.snackbar(
            'Error',
            'Could not open $label. Please make sure you have a browser installed.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          print('Error launching $label: $e');
        }
      },
      child: Column(
        children: [
          SvgPicture.asset(
            imageUrl,
            color: kcSecondaryColor,
            // colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            width: 30.w,
            // height: 30.h,
            // fit: BoxFit.cover,
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
