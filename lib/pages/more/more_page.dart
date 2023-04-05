import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../config/theme.dart';
import '../widget/izma_app_bar.dart';
import '../widget/izma_radial_gradient_container.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IzmaRadialGradientContainer(
        child: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              IzmaAppBar(title: "More"),
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('https://picsum.photos/300/300?random=1'),
                ),
                dense: true,
                title: Text("Zohaib Hassan", style: Theme.of(context).textTheme.bodyLarge),
                subtitle: Text("01XXXXXXXXXX", style: Theme.of(context).textTheme.bodySmall),
              ),
              SizedBox(height: 50.h),
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
                // onTap: () => Get.to(() => MyAddressesPage()),
              ),
              _buildMenuItem(
                context: context,
                icon: Icons.shopping_basket_outlined,
                title: "My Orders",
                // onTap: () => Get.to(() => MyOrdersPage()),
              ),
              _buildMenuItem(
                context: context,
                icon: Icons.bolt_outlined,
                title: "My Wishlist",
                // onTap: () => Get.to(() => WishListPage()),
              ),
              _buildMenuItem(context: context, icon: Icons.chat_bubble_outline_rounded, title: "Chat with us", color: kcSecondaryColor),
              _buildMenuItem(context: context, icon: Icons.phone_outlined, title: "Talk to our Support", color: Colors.orange),
              _buildMenuItem(context: context, icon: Icons.mail_outline_rounded, title: "Mail to us"),
              _buildMenuItem(context: context, icon: Icons.facebook, title: "Message to facebook page", color: Colors.blue),
              _buildMenuItem(context: context, icon: Icons.power_settings_new_rounded, title: "Log out", color: Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    void Function()? onTap,
    Color? color,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          tileColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: kdPadding + 10),
          leading: Icon(
            icon,
            color: color ?? Colors.black,
          ),
          dense: true,
          minLeadingWidth: 10.w,
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
          ),
        ),
        Divider(),
      ],
    );
  }
}
