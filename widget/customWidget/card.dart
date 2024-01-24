import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class cardContainer extends StatelessWidget {
  const cardContainer({
    super.key,
    required this.onAction,
    required this.lable,
    required this.value,
    required this.color,
    required this.duration,
  });
  final VoidCallback onAction;
  final String lable;
  final String value;
  final Color color;
  final Duration duration;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onAction,
      child: Container(
        height: 25.w,
        width: 25.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BodyText(
              text: lable,
              fontsize: 8.sp,
              color: Colors.white,
            ),
            SizedBox(
              height: 2.5.w,
            ),
            BodyText(
              text: value.padLeft(2, "0"),
              fontsize: 12.sp,
              color: Colors.white,
            ),
          ],
        ),
      ),
    ).animatedDisplay(duration);
  }
}
