import 'dart:convert';
import 'package:courier_app/model/transactionModel/model.dart';
import 'package:courier_app/utility/aptRoot.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/utility/localStore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';

class TransactionProvider extends ChangeNotifier {
  String _startDate = "30".startDateTime;
  String _endDate = "now".endDateTime;

  // Parcel List  Data Model
  TransactionListModel _transactionListDate = TransactionListModel();
  TransactionListModel get transactionListDate => _transactionListDate;

  // Parcel List  Data Model
  TransactionProcessModel _transactionProcessListDate =
      TransactionProcessModel();
  TransactionProcessModel get transactionProcessListDate =>
      _transactionProcessListDate;

  void transactionListAction(
    BuildContext context, {
    String? startDate,
    String? endDate,
    required String status,
  }) async {
    try {
      context.loaderOverlay.show();
      notifyListeners();
      http.Response response = await ApiRoot.POST_REQUEST(
          url: "transaction/list/${SystemInfo.getUid}",
          data: {
            "status": status,
            "start_date": startDate ?? _startDate,
            "end_date": endDate ?? _endDate
          });
      if (response.statusCode == 200) {
        if (status == "in_progress") {
          _transactionProcessListDate = TransactionProcessModel.fromJson(
              json.decode(response.body)['result']['data']);

          context.loaderOverlay.hide();
          notifyListeners();
        } else {
          _transactionListDate = TransactionListModel.fromJson(
              json.decode(response.body)['result']['data']);
          print(_transactionListDate);
          context.loaderOverlay.hide();
          notifyListeners();
        }
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
      }
    } on http.ClientException catch (e) {
      context.loaderOverlay.hide();
      notifyListeners();
      print(e.toString());
    }
  }
}
