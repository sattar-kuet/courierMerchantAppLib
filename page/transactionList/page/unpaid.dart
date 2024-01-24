import 'package:courier_app/logic/TransactionProvider/Provider.dart';
import 'package:courier_app/model/transactionModel/model.dart';
import 'package:courier_app/page/transactionList/DetailsPage/detailsPage.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/widget/ParcelList/card.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TransactionunPaid extends StatelessWidget {
  const TransactionunPaid({super.key, this.startDate, this.endDate});
  final String? startDate;
  final String? endDate;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransactionProvider()
        ..transactionListAction(context,
            status: 'unpaid', endDate: endDate, startDate: startDate),
      child: Scaffold(
        body: Consumer<TransactionProvider>(builder: (
          context,
          actionValue,
          child,
        ) {
          if (actionValue.transactionListDate != TransactionListModel()) {
            return SafeArea(
              child: actionValue.transactionListDate.items == null
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
                                status: 'unpaid',
                                endDate: endDate,
                                startDate: startDate);
                      },
                      child: ListView.builder(
                        itemCount:
                            actionValue.transactionListDate.items!.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TransactionDetailsPage(
                                          id: actionValue.transactionListDate
                                              .items![index].id
                                              .toString(),
                                          color: Color(int.parse(actionValue
                                              .transactionListDate
                                              .color!
                                              .bgColor
                                              .toString())),
                                        )));
                          },
                          child: ParcelCard(
                            height: 30.w,
                            isbtn: true,
                            date: actionValue
                                .transactionListDate.items![index].date
                                .toString(),
                            name: "৳" +
                                actionValue
                                    .transactionListDate.items![index].amount
                                    .toString(),
                            trackingID: actionValue
                                .transactionListDate.items![index].number
                                .toString(),
                            bgColor: Color(int.parse(actionValue
                                    .transactionListDate.color!.bgColor
                                    .toString()))
                                .withOpacity(0.6),
                            forColor: Color(int.parse(actionValue
                                .transactionListDate.color!.bgColor
                                .toString())),
                            status: "paid",
                          ).animatedDisplay(Duration(milliseconds: 300)),
                        ),
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
