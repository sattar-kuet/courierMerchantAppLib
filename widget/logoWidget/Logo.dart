import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LogoView extends StatelessWidget {
  const LogoView({super.key, required this.width, required this.height});
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/logo/logo.png",
      width: width.w,
      height: height.w,
    );
  }
}
