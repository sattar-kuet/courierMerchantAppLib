import 'package:courier_app/logic/TransactionDetailsProvider/DetailsProvider.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TransactionDetailsPage extends StatelessWidget {
  TransactionDetailsPage({super.key, required this.id, required this.color});
  final String id;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) =>
            TransactionDetailsProvider()..transactionDetailsAction(context, id),
        child: Consumer<TransactionDetailsProvider>(
            builder: (context, actionValue, child) {
          if (actionValue.transactionDetailsData != null) {
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                  statusBarColor: Theme.of(context).textTheme.bodyLarge!.color),
              child: Scaffold(
                body: SafeArea(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BodyText(
                                    text: actionValue
                                        .transactionDetailsData!.invoice!.number
                                        .toString(),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 2.5.sp,
                                  ),
                                  BodyText(
                                    text: "৳" +
                                        actionValue.transactionDetailsData!
                                            .invoice!.amount
                                            .toString(),
                                    fontsize: 25,
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 2.5.sp,
                                  ),
                                  BodyText(
                                    text: actionValue.transactionDetailsData!
                                        .invoice!.createdAt
                                        .toString(),
                                    fontsize: 10,
                                    textAlign: TextAlign.left,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ],
                              ),
                              Positioned(
                                  top: 2.sp,
                                  left: 30.w,
                                  child: Container(
                                      alignment: Alignment.center,
                                      constraints: BoxConstraints(
                                          maxHeight: 5.w, minWidth: 10.w),
                                      decoration: BoxDecoration(
                                          color: color.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(15.sp)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.sp),
                                        child: BodyText(
                                          text: "paid",
                                          fontsize: 10,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      )))
                            ],
                          ),
                          IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: Icon(Icons.close))
                        ],
                      ).animatedDisplay(Duration(milliseconds: 300)),
                      SizedBox(
                        height: 5.w,
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemCount:
                            actionValue.transactionDetailsData!.items!.length,
                        itemBuilder: (context, index) => Container(
                          constraints:
                              BoxConstraints(minHeight: 20.h, minWidth: 100.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.sp)),
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 5.w),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BodyText(text: "Tracking"),
                                    BodyText(
                                        text: actionValue
                                            .transactionDetailsData!
                                            .items![index]
                                            .tracking
                                            .toString()),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.sp,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BodyText(text: "Cash Collection"),
                                    BodyText(
                                        text: "৳" +
                                            actionValue.transactionDetailsData!
                                                .items![index].cashCollection
                                                .toString()),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.sp,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BodyText(text: "Cod Charge"),
                                    BodyText(
                                        text: "৳" +
                                            actionValue.transactionDetailsData!
                                                .items![index].codCharge
                                                .toString()),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.sp,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BodyText(text: "Delivery Charge"),
                                    BodyText(
                                        text: "৳" +
                                            actionValue.transactionDetailsData!
                                                .items![index].deliveryCharge
                                                .toString()),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.sp,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BodyText(text: "Total Charge"),
                                    BodyText(
                                        text: "৳" +
                                            actionValue.transactionDetailsData!
                                                .items![index].totalCharge
                                                .toString()),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.sp,
                                  child: Divider(
                                    height: 10.sp,
                                    color: Color.fromARGB(255, 219, 219, 219),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BodyText(text: "Merchant Amount"),
                                    BodyText(
                                        text: "৳" +
                                            actionValue.transactionDetailsData!
                                                .items![index].merchantAmount
                                                .toString()),
                                  ],
                                )
                              ]),
                            ),
                          ),
                        ).animatedDisplay(Duration(milliseconds: 300)),
                      ))
                    ],
                  ),
                )),
              ),
            );
          } else {
            return Scaffold(body: Container());
          }
        }).loadingOverlay(context));
  }
}
