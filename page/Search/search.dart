import 'package:anim_search_app_bar/anim_search_app_bar.dart';
import 'package:courier_app/logic/SearchProvider/provider.dart';
import 'package:courier_app/page/parcelList/DetailsPage/detailsPage.dart';
import 'package:courier_app/widget/ParcelList/card.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SearchView extends StatefulWidget {
  SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchProvider())
      ],
      child: Scaffold(body:
          Consumer<SearchProvider>(builder: (context, actionValue, child) {
        return Column(
          children: [
            AnimSearchAppBar(
              cancelButtonText: "Cancel",
              hintText: 'Tracking, Customer name or phone',
              hintStyle: TextStyle(color: Colors.black),
              clearIconColor: Colors.black,
              iconColor: Colors.black,
              cSearch: searchController,
              onChanged: (value) =>
                  Provider.of<SearchProvider>(context, listen: false)
                    ..searchOnChangeAction(context, param: value),
              appBar: AppBar(
                title: Text("পার্সেল অনুসন্ধান"),
              ),
            ),
            if (actionValue.parcelListDate.isEmpty) ...[
              Spacer(),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/json/72785-searching.json',
                        width: 40.w, height: 40.w, fit: BoxFit.contain),
                    SizedBox(
                      width: 70.w,
                      child: Text(
                        "Tracking Number অথবা Customer Name অথবা Customer Phone দিয়ে সার্চ করুন",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
            ],
            if (actionValue.parcelListDate.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
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
                      trackingID:
                          actionValue.parcelListDate[index].tracking.toString(),
                      bgColor: Color(int.parse(actionValue
                              .parcelListDate[index].status!.icon!.bgColor
                              .toString()))
                          .withOpacity(0.6),
                      forColor: Color(int.parse(actionValue
                          .parcelListDate[index].status!.icon!.bgColor
                          .toString())),
                      status: actionValue.parcelListDate[index].status!.label
                          .toString(),
                      textColor: Color(int.parse(actionValue
                          .parcelListDate[index].status!.icon!.fontColor
                          .toString())),
                    ),
                  ),
                ),
              )
          ],
        );
      })),
    );
  }
}
