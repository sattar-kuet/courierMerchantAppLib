import 'dart:convert';

import 'package:courier_app/model/parcelModel/parcelListModel.dart';
import 'package:courier_app/utility/aptRoot.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/utility/localStore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';

class ParcelListProvider extends ChangeNotifier {
  String _startDate = "30".startDateTime;
  String _endDate = "now".endDateTime;

  // Parcel List  Data Model
  List<ParcelListModel> _parcelListData = [];
  List<ParcelListModel> get parcelListDate => _parcelListData;

  void parceListAction(
    BuildContext context, {
    String? startDate,
    String? endDate,
    required String status,
  }) async {
    try {
      context.loaderOverlay.show();
      notifyListeners();
      http.Response response = await ApiRoot.POST_REQUEST(
          url: "parcel/list/${SystemInfo.getUid}",
          data: {
            "param": "",
            "status": status,
            "start_date": startDate ?? _startDate,
            "end_date": endDate ?? _endDate
          });

      if (response.statusCode == 200) {
        _parcelListData = [];
        _parcelListData = (json.decode(response.body)['result']['data'] as List)
            .map((e) => ParcelListModel.fromJson(e))
            .toList();
      }
      context.loaderOverlay.hide();
      notifyListeners();
    } on http.ClientException catch (e) {
      context.loaderOverlay.hide();
      notifyListeners();
      print(e.toString());
    }
  }
}
