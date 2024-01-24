import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key,
      required this.child,
      required this.onAction,
      required this.width,
      required this.height,
      this.btnEnable = false,
      required this.colorBg});
  final Widget child;
  final VoidCallback onAction;
  final double width;
  final double height;
  final Color colorBg;
  final bool btnEnable;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: btnEnable ? onAction : null,
      splashColor: Theme.of(context).splashColor,
      child: Container(
        width: width.w,
        height: height.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.sp),
          color: btnEnable ? colorBg : Theme.of(context).disabledColor,
        ),
        child: child,
      ),
    );
  }
}
