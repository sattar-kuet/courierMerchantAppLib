import 'package:courier_app/page/Home/Home.dart';
import 'package:courier_app/page/Profile/profile.dart';
import 'package:courier_app/page/Search/search.dart';
import 'package:courier_app/page/parcelList/ParcelList.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class dashboardProvider extends ChangeNotifier {
  int _isSelectItem = 0;

  int get isSelectItem => _isSelectItem;

  void onChangeMenuAction(int item) {
    _isSelectItem = item;
    notifyListeners();
  }

  // Blow Menu Item With Page List

  List<dynamic> PageList = [
    Home(),
    SearchView(),
    ParcelList(),
    Profile(),
  ];

  List<Map<String, dynamic>> menuItem = [
    {
      "id": 0,
      "icon": Icons.home,
      'lable': "Home",
      "padding": 5.sp,
      "isLeft": true,
    },
    {
      "id": 1,
      "icon": Icons.search,
      'lable': "Search",
      "padding": 25.sp,
      "isLeft": true,
    },
    {
      "id": 2,
      "icon": Icons.shopping_bag,
      'lable': "Parcel",
      "padding": 25.sp,
      "isLeft": false,
    },
    {
      "id": 3,
      "icon": Icons.account_circle,
      'lable': "Profile",
      "padding": 5.sp,
      "isLeft": false,
    }
  ];
}
