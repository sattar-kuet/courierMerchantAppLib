import 'dart:convert';

import 'package:courier_app/model/HomeModel/model.dart';
import 'package:courier_app/utility/aptRoot.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/utility/localStore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HomeProvider extends ChangeNotifier {
  String _startDate = "30".startDateTime;
  String _endDate = "now".endDateTime;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String get startDate => _startDate;
  String get endDate => _endDate;
  // Parcel Home Date
  List<HomeParcelModel> _homePracelData = [];
  List<HomeParcelModel> get homePracelData => _homePracelData;

  List<HomeTransactionModel> _homeTransactionData = [];
  List<HomeTransactionModel> get homeTransactionData => _homeTransactionData;

  homeNoticeDataModel _homeNoticeData = homeNoticeDataModel();
  homeNoticeDataModel get homeNoticeData => _homeNoticeData;

  accountManagerModel _homeAccountManagerData = accountManagerModel();
  accountManagerModel get homeAccountManagerData => _homeAccountManagerData;

  void parcelHomeAction({String? startDate, String? endDate}) async {
    try {
      _isLoading = true;
      notifyListeners();
      http.Response response = await ApiRoot.POST_REQUEST(
        url: "parcel/stat/",
        data: {
          "uid": SystemInfo.getUid,
          "start_date": startDate ?? _startDate,
          "end_date": endDate ?? _endDate,
        },
      );

      if (response.statusCode == 200) {
        _startDate = startDate ?? _startDate;
        _endDate = endDate ?? _endDate;

        // Do Something
        _homePracelData = (json.decode(response.body)['result']['data'] as List)
            .map((e) => HomeParcelModel.fromJson(e))
            .toList();
        _isLoading = false;
        notifyListeners();
      }

      if (kDebugMode)
        print("Parcel Home Data Response " + response.statusCode.toString());
    } on http.ClientException catch (e) {
      _isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }

// Account Manager Action
  void accountManagerHomeAction({String? startDate, String? endDate}) async {
    try {
      _isLoading = true;
      notifyListeners();
      http.Response managerResponse = await ApiRoot.POST_REQUEST(
        url: "account_manager/get/",
        data: {
          "uid": SystemInfo.getUid,
          "start_date": startDate ?? _startDate,
          "end_date": endDate ?? _endDate,
        },
      );

      if (managerResponse.statusCode == 200) {
        // Do Something
        final data = json.decode(managerResponse.body)['result']['data'];
        if (data != null) {
          _homeAccountManagerData = accountManagerModel.fromJson(data);
          notifyListeners();
        }
      }
      _isLoading = false;
      notifyListeners();
      if (kDebugMode)
        print("Account Manager Home Data Response " +
            managerResponse.statusCode.toString());
    } on http.ClientException catch (e) {
      _isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }

  void transactionHomeAction({String? startDate, String? endDate}) async {
    try {
      _isLoading = true;
      notifyListeners();
      http.Response response = await ApiRoot.POST_REQUEST(
        url: "transaction/stat",
        data: {
          "uid": SystemInfo.getUid,
          "start_date": startDate ?? _startDate,
          "end_date": endDate ?? _endDate,
        },
      );

      if (response.statusCode == 200) {
        // Do Something

        _homeTransactionData =
            (json.decode(response.body)['result']['data'] as List)
                .map((e) => HomeTransactionModel.fromJson(e))
                .toList();
        _isLoading = false;
        notifyListeners();
      }

      if (kDebugMode)
        print(
            "Transaction Home Data Response " + response.statusCode.toString());
    } on http.ClientException catch (e) {
      _isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }

  void noticeHomeAction({String? startDate, String? endDate}) async {
    try {
      _isLoading = true;
      notifyListeners();
      http.Response response = await ApiRoot.POST_REQUEST(
        url: "notice/get/",
        data: {"uid": SystemInfo.getUid},
      );
      print(response);
      if (response.statusCode == 200) {
        dynamic responseResult = json.decode(response.body)['result'];
        if (responseResult['status_code'] == 200) {
          _homeNoticeData = homeNoticeDataModel
              .fromJson(json.decode(response.body)['result']['data']);
          notifyListeners();
        }

        _isLoading = false;
      }
      notifyListeners();
      if (kDebugMode)
        print(
            "Transaction Home Data Response " + response.statusCode.toString());
    } on http.ClientException catch (e) {
      _isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }
}
