import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ParcelCard extends StatelessWidget {
  const ParcelCard(
      {super.key,
      required this.trackingID,
      required this.name,
      this.address,
      this.icon,
      this.bgColor,
      this.forColor,
      required this.status,
      this.textColor,
      required this.date,
      this.isbtn = true,
      this.height});
  final String trackingID;
  final String name;
  final String? address;
  final Color? forColor;
  final Color? bgColor;
  final IconData? icon;
  final String status;
  final String date;
  final bool isbtn;
  final double? height;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 8.sp),
      child: Container(
        constraints:
            BoxConstraints(minWidth: 100.w, maxWidth: 100.w, minHeight: 35.w),
        child: Card(
          color: bgColor ?? Theme.of(context).colorScheme.primaryContainer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.sp)),
          child: Wrap(
            children: [
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100.w,
                        height: 10.w,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 5.sp),
                        decoration: BoxDecoration(
                            color: forColor ??
                                Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.sp),
                              topRight: Radius.circular(5.sp),
                            )),
                        child: BodyText(
                          text: trackingID,
                          color: textColor ??
                              Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.sp, vertical: 5.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BodyText(
                              text: name,
                              fontsize: 12.sp,
                              color: textColor ??
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            SizedBox(
                              height: 5.sp,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (icon != null)
                                  Icon(
                                    Icons.location_on,
                                    color: textColor ??
                                        Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                  ),
                                if (address != null)
                                  SizedBox(
                                    width: 80.w,
                                    child: Text(
                                      address.toString(),
                                      style: TextStyle(
                                          color: textColor ??
                                              Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color,
                                          fontSize: 10.sp),
                                    ),
                                  )
                              ],
                            ),
                            SizedBox(
                              height: 2.sp,
                            ),
                            BodyText(
                              text: "  " + date,
                              fontStyle: FontStyle.italic,
                              color: textColor ??
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontsize: 10,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  if (icon != null)
                    Positioned(
                        top: 5.sp,
                        right: 5.sp,
                        child: Row(
                          children: [
                            Icon(
                              icon,
                              color: textColor ??
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            SizedBox(
                              width: 5.sp,
                            ),
                            BodyText(
                              text: status,
                              fontsize: 10,
                              color: textColor ??
                                  Theme.of(context).textTheme.bodyText1!.color,
                            )
                          ],
                        )),
                  if (isbtn)
                    Positioned(
                        bottom: 13.sp,
                        right: 5.sp,
                        child: BodyText(
                          text: "Details",
                          color: textColor ??
                              Theme.of(context).textTheme.bodyText1!.color,
                          fontsize: 10.sp,
                        )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
