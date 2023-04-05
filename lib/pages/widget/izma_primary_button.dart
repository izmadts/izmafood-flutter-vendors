import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/theme.dart';

class IzmaPrimaryButton extends StatelessWidget {
  const IzmaPrimaryButton({
    super.key,
    required this.title,
    this.onTap,
    this.suffixIcon,
    this.hideSuffixIcon = false,
    this.bgColor,
    this.textColor,
    this.disablePadding = false,
  });

  final String title;
  final void Function()? onTap;
  final IconData? suffixIcon;
  final bool hideSuffixIcon;
  final Color? bgColor;
  final Color? textColor;
  final bool disablePadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: disablePadding ? 0 : kdPadding),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith((states) => kcSecondaryColor.withOpacity(0.2)),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => bgColor ?? Theme.of(context).colorScheme.secondary,
          ),
          shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(borderRadius: BorderRadius.circular(kdBorderRadius))),
        ),
        onPressed: onTap ?? () {},
        child: Container(
          width: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: textColor ?? Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
              Positioned(
                right: 10,
                top: 0,
                bottom: 0,
                child: hideSuffixIcon ? SizedBox() : Icon(suffixIcon ?? Icons.arrow_forward, color: Colors.white, size: 24),
              )
            ],
          ),
        ),
      ),
    );
  }
}
