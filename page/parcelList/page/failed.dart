import 'package:courier_app/logic/ParcelListProvider/provider.dart';
import 'package:courier_app/page/parcelList/DetailsPage/detailsPage.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/widget/ParcelList/card.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Failed extends StatelessWidget {
  const Failed({super.key, this.startDate, this.endDate});
  final String? startDate;
  final String? endDate;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ParcelListProvider()
        ..parceListAction(context,
            status: 'failed', endDate: endDate, startDate: startDate),
      child: Scaffold(
        body: Consumer<ParcelListProvider>(builder: (
          context,
          actionValue,
          child,
        ) {
          return SafeArea(
            child: actionValue.parcelListDate.isEmpty
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
                      Provider.of<ParcelListProvider>(context, listen: false)
                          .parceListAction(
                        context,
                        status: 'failed',
                        endDate: endDate,
                        startDate: startDate,
                      );
                    },
                    child: ListView.builder(
                      itemCount: actionValue.parcelListDate.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                        id: actionValue.parcelListDate[index].id
                                            .toString(),
                                      )));
                        },
                        child: ParcelCard(
                          date: actionValue.parcelListDate[index].created_at
                              .toString(),
                          icon: IconData(
                              int.parse(actionValue
                                  .parcelListDate[index].status!.icon!.code
                                  .toString()),
                              fontFamily: 'MaterialIcons'),
                          address: actionValue
                              .parcelListDate[index].customer!.address
                              .toString(),
                          name: actionValue.parcelListDate[index].customer!.name
                              .toString(),
                          trackingID: actionValue.parcelListDate[index].tracking
                              .toString(),
                          bgColor: Color(int.parse(actionValue
                                  .parcelListDate[index].status!.icon!.bgColor
                                  .toString()))
                              .withOpacity(0.6),
                          forColor: Color(int.parse(actionValue
                              .parcelListDate[index].status!.icon!.bgColor
                              .toString())),
                          status: actionValue
                              .parcelListDate[index].status!.label
                              .toString(),
                          textColor: Color(int.parse(actionValue
                              .parcelListDate[index].status!.icon!.fontColor
                              .toString())),
                        ),
                      ),
                    ),
                  ),
          );
        }),
      ).loadingOverlay(context),
    );
  }
}
