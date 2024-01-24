import 'package:courier_app/page/parcelList/page/delivered.dart';
import 'package:courier_app/page/parcelList/page/failed.dart';
import 'package:courier_app/page/parcelList/page/inProgress.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:flutter/material.dart';

class ParcelList extends StatelessWidget {
  const ParcelList({
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
            text: "পার্সেল তালিকা",
            color: Colors.white,
          ),
          bottom: TabBar(
            onTap: (value) => print(value),
            tabs: [
              Tab(
                text: "Delivered",
              ),
              Tab(
                text: "in Progress",
              ),
              Tab(
                text: "Failed",
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          Delivered(
            endDate: endDate,
            startDate: startDate,
          ),
          InProgress(
            endDate: endDate,
            startDate: startDate,
          ),
          Failed(
            endDate: endDate,
            startDate: startDate,
          )
        ]),
      ),
    );
  }
}
