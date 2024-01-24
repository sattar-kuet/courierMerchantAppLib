import 'dart:math';

import 'package:courier_app/logic/HomeProvider/provider.dart';
import 'package:courier_app/model/HomeModel/model.dart';
import 'package:courier_app/page/Home/Provider/provider.dart';
import 'package:courier_app/page/Home/videoIframe/iframe.dart';
import 'package:courier_app/page/Profile/profile.dart';
import 'package:courier_app/page/parcelList/ParcelList.dart';
import 'package:courier_app/page/transactionList/transactionList.dart';
import 'package:courier_app/utility/config.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:courier_app/widget/customWidget/card.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'videoIframe/RouterSetting/settings.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StateHomeProvider(),
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Consumer<HomeProvider>(builder: (context, actionValue, child) {
            if (actionValue.isLoading == true) {
              context.loaderOverlay.show();
            }
            if (actionValue.isLoading == false) {
              context.loaderOverlay.hide();
            }
            return actionValue.isLoading == true
                ? Container()
                : Consumer<StateHomeProvider>(
                    builder: (context, stateActionValue, child) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        print("Is Woring");
                        Provider.of<HomeProvider>(context, listen: false)
                          ..parcelHomeAction(
                            startDate: stateActionValue.range.startDateTime,
                            endDate: endDateTime,
                          );
                        Provider.of<HomeProvider>(context, listen: false)
                          ..transactionHomeAction(
                            startDate: stateActionValue.range.startDateTime,
                            endDate: endDateTime,
                          );
                        Provider.of<HomeProvider>(context, listen: false)
                          ..noticeHomeAction(
                            startDate: stateActionValue.range.startDateTime,
                            endDate: endDateTime,
                          );
                        Provider.of<HomeProvider>(context, listen: false)
                          ..accountManagerHomeAction(
                            startDate: stateActionValue.range.startDateTime,
                            endDate: endDateTime,
                          );
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "স্বাগতম\n",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline4!
                                              .color,
                                        ),
                                    children: [
                                      TextSpan(
                                        text: name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ).animatedDisplay(Duration(milliseconds: 200)),
                                Container(
                                        height: 12.w,
                                        width: 12.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.w),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primaryContainer),
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Profile()));
                                            },
                                            icon: Image.asset(
                                                "assets/logo/logo.png")))
                                    .animatedDisplay(
                                        Duration(milliseconds: 200)),
                              ],
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BodyText(
                                      text: "Overview",
                                      color: Colors.grey,
                                    )..animatedDisplay(
                                        Duration(milliseconds: 500)),
                                    BodyText(
                                      text: stateActionValue.date,
                                      fontsize: 10,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                                IconButton(
                                        onPressed: () {
                                          showMenu(
                                            context: context,
                                            position: RelativeRect.fromLTRB(
                                                100, 100, 0, 0),
                                            items: <PopupMenuEntry>[
                                              PopupMenuItem(
                                                onTap: () {
                                                  Provider.of<
                                                          StateHomeProvider>(
                                                      context,
                                                      listen: false)
                                                    ..dateRangeDateAction(
                                                        context,
                                                        range: "1");
                                                },
                                                child: Text("Today"),
                                              ),
                                              PopupMenuItem(
                                                onTap: () {
                                                  Provider.of<
                                                          StateHomeProvider>(
                                                      context,
                                                      listen: false)
                                                    ..dateRangeDateAction(
                                                        context,
                                                        range: "7");
                                                },
                                                child: Text('Last 7 Days'),
                                              ),
                                              PopupMenuItem(
                                                onTap: () {
                                                  Provider.of<
                                                          StateHomeProvider>(
                                                      context,
                                                      listen: false)
                                                    ..dateRangeDateAction(
                                                        context,
                                                        range: "15");
                                                },
                                                child: Text('Last 15 Days'),
                                              ),
                                              PopupMenuItem(
                                                onTap: () {
                                                  Provider.of<
                                                          StateHomeProvider>(
                                                      context,
                                                      listen: false)
                                                    ..dateRangeDateAction(
                                                        context,
                                                        range: "30");
                                                },
                                                child: Text('Last 30 Days'),
                                              ),
                                              PopupMenuItem(
                                                onTap: () => Future(() async {
                                                  Provider.of<
                                                          StateHomeProvider>(
                                                      context,
                                                      listen: false)
                                                    ..customDateRnageDateAction(
                                                      context,
                                                    );
                                                }),
                                                child: Text('Custom'),
                                              ),
                                            ],
                                          );
                                        },
                                        icon: Icon(
                                          Icons.calendar_month_outlined,
                                          size: 25.sp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ))
                                    .animatedDisplay(
                                        Duration(milliseconds: 300))
                              ],
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: actionValue.homePracelData
                                  .map((HomeParcelModel item) => cardContainer(
                                        lable: item.title.toString(),
                                        value: item.value.toString(),
                                        color: Color(int.parse(
                                            item.color!.bgColor.toString())),
                                        onAction: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) => ParcelList(
                                                index: item.id,
                                                startDate:
                                                    actionValue.startDate,
                                                endDate: actionValue.endDate,
                                              ),
                                            ),
                                          );
                                        },
                                        duration: Duration(milliseconds: 300),
                                      ))
                                  .toList(),
                            ),

                            SizedBox(
                              height: 2.5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: actionValue.homeTransactionData
                                  .map((HomeTransactionModel item) =>
                                      cardContainer(
                                        lable: item.title.toString(),
                                        value: item.value.toString(),
                                        color: Color(int.parse(
                                            item.color!.bgColor.toString())),
                                        onAction: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TransactionList(
                                                index: item.id,
                                                startDate:
                                                    actionValue.startDate,
                                                endDate: actionValue.endDate,
                                              ),
                                            ),
                                          );
                                        },
                                        duration: Duration(milliseconds: 300),
                                      ))
                                  .toList(),
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            if (actionValue.homeNoticeData.image != null)
                              SizedBox(
                                height: 45.w,
                                width: 100.w,
                                child: Column(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5.sp),
                                    child: Image.memory(
                                      actionValue
                                          .homeNoticeData.image.memoryImage,
                                      width: 100.w,
                                      height: 20.w,
                                      fit: BoxFit.contain,
                                    ),
                                  ).animatedDisplay(
                                    Duration(milliseconds: 300),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.sp),
                                    child: SizedBox(
                                      height: 10.w,
                                      width: 100.w,
                                      child: Text(
                                        actionValue.homeNoticeData.content
                                            .toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 10.sp),
                                      ),
                                    ),
                                  ).animatedDisplay(
                                      Duration(milliseconds: 300)),
                                  if (actionValue.homeNoticeData.url != false)
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                        onTap: () => Future(() {
                                          Navigator.of(context).push(
                                              videoIframeRoute(
                                                  builder: (context) =>
                                                      VideoIframe(
                                                        videoUrl: actionValue
                                                            .homeNoticeData.url
                                                            .toString(),
                                                      )));
                                        }),
                                        child: BodyText(
                                          text: "আরো বিস্তারিত ",
                                          fontsize: 8.sp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ).animatedDisplay(
                                            Duration(milliseconds: 300)),
                                      ),
                                    )
                                ]),
                              ),
                            // Manager Call Secation
                            if (actionValue.homeAccountManagerData.avatar !=
                                null)
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: 20.w,
                                width: 100.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(10.sp)),
                                child: ListTile(
                                  title: BodyText(
                                    text: actionValue
                                        .homeAccountManagerData.name
                                        .toString(),
                                    textAlign: TextAlign.left,
                                  ),
                                  subtitle: Text("Manager"),
                                  leading: CircleAvatar(
                                    radius: 20.sp,
                                    backgroundImage: MemoryImage(actionValue
                                        .homeAccountManagerData
                                        .avatar
                                        .memoryImage),
                                  ),
                                  trailing: IconButton(
                                      onPressed: () async {
                                        final Uri url = Uri(
                                            scheme: "tel",
                                            path: actionValue
                                                .homeAccountManagerData.phone);
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url);
                                        } else {
                                          print(' could not launch $url');
                                        }
                                      },
                                      icon: Icon(
                                        Icons.call,
                                        size: 20.sp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      )),
                                ),
                              ).animatedDisplay(Duration(milliseconds: 300)),
                          ],
                        ).fullSizedBox,
                      ),
                    );
                  });
          }),
        )),
      ).loadingOverlay(context),
    );
  }
}
