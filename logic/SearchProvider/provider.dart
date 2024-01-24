import 'dart:convert';

import 'package:courier_app/model/parcelModel/parcelListModel.dart';
import 'package:courier_app/utility/aptRoot.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/utility/localStore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';

class SearchProvider extends ChangeNotifier {
  String _startDate = "30".startDateTime;
  String _endDate = "now".endDateTime;

  // Parcel List  Data Model
  List<ParcelListModel> _parcelListDate = [];
  List<ParcelListModel> get parcelListDate => _parcelListDate;

  void searchOnChangeAction(
    BuildContext context, {
    required String param,
  }) async {
    try {
      if (param.length > 0) {
        context.loaderOverlay.show();
        notifyListeners();

        http.Response response = await ApiRoot.POST_REQUEST(
            url: "parcel/list/${SystemInfo.getUid}",
            data: {
              "param": param.toString(),
              "status": "",
              "start_date": _startDate,
              "end_date": _endDate
            });

        if (response.statusCode == 200) {
          _parcelListDate =
              (json.decode(response.body)['result']['data'] as List)
                  .map((e) => ParcelListModel.fromJson(e))
                  .toList();
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
        }
        context.loaderOverlay.hide();
        notifyListeners();
      } else {
        _parcelListDate = [];
        parcelListDate.clear();
        notifyListeners();
      }
    } on http.ClientException catch (e) {
      context.loaderOverlay.hide();
      notifyListeners();
      print(e.toString());
    }
  }
}
