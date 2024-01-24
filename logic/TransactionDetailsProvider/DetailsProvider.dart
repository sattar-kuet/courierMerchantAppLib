import 'dart:convert';

import 'package:courier_app/model/transactionModel/model.dart';
import 'package:courier_app/utility/aptRoot.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:http/http.dart' as http;

class TransactionDetailsProvider extends ChangeNotifier {
  TransactionDetailsModel? _transactionDetailsData;
  TransactionDetailsModel? get transactionDetailsData =>
      _transactionDetailsData;

  void transactionDetailsAction(BuildContext context, String id) async {
    try {
      context.loaderOverlay.show();
      notifyListeners();
      http.Response response = await ApiRoot.POST_REQUEST(
        url: "transaction/detail/$id",
        data: {},
        isEmpty: true,
      );

      if (response.statusCode == 200) {
        _transactionDetailsData = TransactionDetailsModel.fromJson(
            json.decode(response.body)['result']['data']);

        context.loaderOverlay.hide();
        notifyListeners();
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
      }
    } on http.ClientException catch (e) {
      context.loaderOverlay.hide();
      Navigator.of(context).pop();
      notifyListeners();
      print(e.toString());
    }
  }
}
