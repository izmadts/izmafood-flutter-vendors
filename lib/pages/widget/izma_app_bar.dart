import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../config/theme.dart';
import '../home/notifications_page.dart';

class IzmaAppBar extends StatelessWidget {
  const IzmaAppBar({
    super.key,
    required this.title,
    this.actions = const [],
    this.showCustomActions = true,
  });

  final String title;
  final List<Widget> actions;
  final bool showCustomActions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kdPadding),
      height: 70.h,
      width: double.infinity,
      child: Row(
        children: [
          Navigator.canPop(context) ? Icon(Icons.arrow_back_rounded) : SizedBox(),
          SizedBox(width: 15.w),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: showCustomActions
                ? actions
                : [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.support_agent_rounded),
                      visualDensity: VisualDensity.compact,
                    ),
                    IconButton(
                      onPressed: () => Get.to(() => NotificationsPage()),
                      icon: Icon(Icons.notifications_outlined),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
          ),
        ],
      ),
    );
  }
}
