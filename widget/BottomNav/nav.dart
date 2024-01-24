import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NavContainer extends StatelessWidget {
  const NavContainer(
      {super.key,
      required this.lable,
      required this.icon,
      required this.isActive,
      required this.onAction});
  final String lable;
  final IconData icon;
  final bool isActive;
  final VoidCallback onAction;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onAction,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 22.sp,
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).iconTheme.color,
          ),
          BodyText(
            text: lable,
            fontsize: 7.sp,
            color: isActive
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).iconTheme.color,
          )
        ],
      ),
    );
  }
}
