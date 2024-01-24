import 'package:courier_app/logic/ParcelDetailsProvider/provider.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:courier_app/widget/sectionTitle/sectionTitle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) =>
            ParcelDetailsProvider()..parcelDetailsAction(context, id),
        child: Consumer<ParcelDetailsProvider>(
            builder: (context, actionValue, child) {
          if (actionValue.parcelDetails != null) {
            return Scaffold(
              appBar: AppBar(
                  centerTitle: false,
                  backgroundColor: Color(int.parse(actionValue
                      .parcelDetails!.parcel!.status!.icon!.bgColor
                      .toString())),
                  title: BodyText(
                      textAlign: TextAlign.left,
                      fontsize: 18,
                      color: Colors.white,
                      text: actionValue.parcelDetails!.parcel!.tracking
                          .toString())),
              body: SafeArea(
                minimum: EdgeInsets.only(top: 2.5.w, bottom: 2.5.w),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BodyText(text: "পার্সেল স্ট্যাটাস")
                              .animatedDisplay(Duration(milliseconds: 300)),
                          Row(
                            children: [
                              Icon(IconData(
                                  int.parse(
                                    actionValue.parcelDetails!.parcel!.status!
                                        .icon!.code
                                        .toString(),
                                  ),
                                  fontFamily: 'MaterialIcons')),
                              SizedBox(
                                width: 5.sp,
                              ),
                              BodyText(
                                  text: actionValue
                                      .parcelDetails!.parcel!.status!.label
                                      .toString())
                            ],
                          ).animatedDisplay(Duration(milliseconds: 300))
                        ],
                      ),
                    ),
                    SecationTitle(
                      title: "পেমেন্ট বিবরণ",
                    ).animatedDisplay(Duration(milliseconds: 300)),

                    // Payement Details Secation Start
                    for (var i = 0; i < actionValue.parcelCashLength; i++) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.5.w, vertical: 4.sp),
                        child: (actionValue.parcelCashLength - 1) == i
                            ? Column(
                                children: [
                                  Divider(
                                    height: 5.sp,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.sp),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BodyText(
                                            text: actionValue
                                                .parcelDetails!.cash![i].label
                                                .toString()),
                                        BodyText(
                                            text: "৳" +
                                                actionValue.parcelDetails!
                                                    .cash![i].value
                                                    .toString()),
                                      ],
                                    ),
                                  )
                                ],
                              ).animatedDisplay(Duration(milliseconds: 300))
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BodyText(
                                      text: actionValue
                                          .parcelDetails!.cash![i].label
                                          .toString()),
                                  BodyText(
                                      text: "৳" +
                                          actionValue
                                              .parcelDetails!.cash![i].value
                                              .toString()),
                                ],
                              ).animatedDisplay(Duration(milliseconds: 300)),
                      )
                    ],
                    // Custom Information Section Start
                    SecationTitle(
                      title: "গ্রাহক তথ্য",
                    ).animatedDisplay(Duration(milliseconds: 300)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BodyText(
                                text: "নাম",
                                textAlign: TextAlign.left,
                              ),
                              BodyText(
                                text: actionValue.parcelDetails!.customer!.name
                                    .toString(),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ).animatedDisplay(Duration(milliseconds: 300)),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BodyText(text: "মোবাইল নম্বর"),
                                  GestureDetector(
                                    onTap: () async {
                                      final Uri url = Uri(
                                        scheme: "tel",
                                        path: actionValue
                                            .parcelDetails!.customer!.phone
                                            .toString(),
                                      );
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      } else {
                                        print(' could not launch $url');
                                      }
                                    },
                                    child: BodyText(
                                      text: actionValue
                                          .parcelDetails!.customer!.phone
                                          .toString(),
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ).animatedDisplay(Duration(milliseconds: 300)),
                              // SizedBox(
                              //   width: 5.w,
                              // ),
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     BodyText(text: "ক্যাশ পরিমাণ"),
                              //     BodyText(
                              //       text: "0",
                              //     ),
                              //   ],
                              // ).animatedDisplay(Duration(milliseconds: 300)),
                            ],
                          )
                        ],
                      ),
                    ),
                    // Delivery Information Section Start
                    SecationTitle(
                      title: "ডেলিভারি তথ্য",
                    ).animatedDisplay(Duration(milliseconds: 300)),
                    SizedBox(
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BodyText(
                                  text: "ডেলিভারি ঠিকানা",
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  actionValue.parcelDetails!.customer!.address
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 15.sp),
                                ),
                              ],
                            ).animatedDisplay(Duration(milliseconds: 300)),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BodyText(
                                  text: "ডেলিভারি এরিয়া",
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  actionValue.deliveryArea,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 15.sp),
                                ),
                              ],
                            ).animatedDisplay(Duration(milliseconds: 300))
                          ],
                        ),
                      ),
                    ),
                    SecationTitle(
                      title: "পার্সেল তথ্য",
                    ).animatedDisplay(Duration(milliseconds: 300)),
                    SizedBox(
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BodyText(
                                      text: "পার্সেল প্রকার",
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      actionValue.parcelDetails!.parcel!.type
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 15.sp),
                                    ),
                                  ],
                                ).animatedDisplay(Duration(milliseconds: 300)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BodyText(
                                      text: "ওজন",
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      actionValue.parcelDetails!.parcel!.weight
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 15.sp),
                                    ),
                                  ],
                                ).animatedDisplay(Duration(milliseconds: 300)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BodyText(
                                      text: "রেফারেন্স",
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      actionValue.parcelDetails!.parcel!
                                          .merchantReference
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 15.sp),
                                    ),
                                  ],
                                ).animatedDisplay(Duration(milliseconds: 300)),
                              ],
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BodyText(
                                  text: "পার্সেল তৈরি",
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  actionValue.parcelDetails!.parcel!.createdAt
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 15.sp),
                                ),
                              ],
                            ).animatedDisplay(Duration(milliseconds: 300)),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BodyText(
                                  text: "বিনিময় আছে",
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  actionValue.parcelDetails!.parcel!
                                              .hasexchange ==
                                          true
                                      ? "Yes"
                                      : "No",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 15.sp),
                                ),
                              ],
                            ).animatedDisplay(Duration(milliseconds: 300)),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BodyText(
                                  text: "ডেলিভারি নির্দেশাবলী",
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  actionValue.parcelDetails!.parcel!.note
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontSize: 15.sp),
                                ),
                              ],
                            ).animatedDisplay(Duration(milliseconds: 300))
                          ],
                        ),
                      ),
                    ),
                    if (actionValue.parcelDetails!.tracking!.isNotEmpty) ...[
                      SecationTitle(
                        title: "পার্সেল ট্র্যাকিং",
                      ).animatedDisplay(Duration(milliseconds: 300)),
                      for (var i = 0;
                          i < actionValue.parcelDetails!.tracking!.length;
                          i++) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                          child: deliveryTracking(context,
                                  i: i, actionValue: actionValue)
                              .animatedDisplay(Duration(milliseconds: 300)),
                        ),
                      ]
                    ]
                  ]),
                ),
              ).fullSizedBox,
            );
          } else {
            return Scaffold(body: Container());
          }
        }).loadingOverlay(context));
  }
}
