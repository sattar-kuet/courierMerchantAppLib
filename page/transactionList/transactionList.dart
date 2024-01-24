import 'package:courier_app/page/transactionList/page/inProgress.dart';
import 'package:courier_app/page/transactionList/page/paid.dart';
import 'package:courier_app/page/transactionList/page/unpaid.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
    this.index,
    this.startDate,
    this.endDate,
  });
  final int? index;
  final String? startDate;
  final String? endDate;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: index != null ? index! - 1 : 0,
      child: Scaffold(
        appBar: AppBar(
          title: BodyText(
            text: "ট্রানজেকশন তালিকা",
            color: Colors.white,
          ),
          bottom: TabBar(
            onTap: (value) => print(value),
            tabs: [
              Tab(
                text: "Paid",
              ),
              Tab(
                text: "Progress",
              ),
              Tab(
                text: "Unpaid",
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          TransactionPaid(
            endDate: endDate,
            startDate: startDate,
          ),
          TransactionProgress(
            endDate: endDate,
            startDate: startDate,
          ),
          TransactionunPaid(
            endDate: endDate,
            startDate: startDate,
          )
        ]),
      ),
    );
  }
}
