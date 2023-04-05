import 'package:flutter/material.dart';

class IzmaRadialGradientContainer extends StatelessWidget {
  const IzmaRadialGradientContainer({super.key, required this.child, this.alignment = Alignment.center});

  final Widget child;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height, minWidth: MediaQuery.of(context).size.width),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/radial-background.png'), fit: BoxFit.cover),
      ),
      alignment: alignment,
      child: child,
    );
  }
}
