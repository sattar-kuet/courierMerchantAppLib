import 'package:courier_app/logic/TransactionProvider/Provider.dart';
import 'package:courier_app/model/transactionModel/model.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TransactionProgress extends StatelessWidget {
  TransactionProgress({super.key, this.startDate, this.endDate});
  final String? startDate;
  final String? endDate;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransactionProvider()
        ..transactionListAction(
          context,
          status: 'in_progress',
          endDate: endDate,
          startDate: startDate,
        ),
      child: Scaffold(
        body: Consumer<TransactionProvider>(builder: (
          context,
          actionValue,
          child,
        ) {
          if (actionValue.transactionProcessListDate !=
              TransactionProcessModel()) {
            return SafeArea(
              child: actionValue.transactionProcessListDate.items!.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/json/72785-searching.json',
                              width: 40.w, height: 40.w, fit: BoxFit.contain),
                          BodyText(
                            text: "কোন তথ্য নেই",
                            color: Colors.grey,
                          )
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        Provider.of<TransactionProvider>(context, listen: false)
                            .transactionListAction(context,
                                status: 'in_progress',
                                endDate: endDate,
                                startDate: startDate);
                      },
                      child: ListView.builder(
                        itemCount: actionValue
                            .transactionProcessListDate.items!.length,
                        itemBuilder: (context, index) => Container(
                          constraints:
                              BoxConstraints(minHeight: 20.h, minWidth: 100.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 1.5.w),
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
                                            .transactionProcessListDate
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
                                            actionValue
                                                .transactionProcessListDate
                                                .items![index]
                                                .cashCollection
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
                                            actionValue
                                                .transactionProcessListDate
                                                .items![index]
                                                .codCharge
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
                                            actionValue
                                                .transactionProcessListDate
                                                .items![index]
                                                .deliveryCharge
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
                                            actionValue
                                                .transactionProcessListDate
                                                .items![index]
                                                .totalCharge
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
                                            actionValue
                                                .transactionProcessListDate
                                                .items![index]
                                                .merchantAmount
                                                .toString()),
                                  ],
                                )
                              ]),
                            ),
                          ),
                        ).animatedDisplay(Duration(milliseconds: 300)),
                      ),
                    ),
            );
          } else {
            return Container();
          }
        }),
      ).loadingOverlay(context),
    );
  }
}
