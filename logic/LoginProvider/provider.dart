import 'dart:async';
import 'dart:convert';

import 'package:courier_app/utility/aptRoot.dart';
import 'package:courier_app/utility/enum.dart';
import 'package:courier_app/utility/localStore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

class LOGINUSERACCOUNTPROVIDER extends ChangeNotifier {
  void loginAction(
    BuildContext context, {
    required String mail,
    required String password,
  }) async {
    try {
      context.loaderOverlay.show();
      notifyListeners();
      http.Response response = await ApiRoot.POST_REQUEST(
        url: 'web/session/authenticate/',
        data: {"db": SystemInfo.geDBName, "login": mail, "password": password},
      );
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        SystemInfo.setToken(response.headers['set-cookie'].cookieFilter);
        SystemInfo.setUid(response.body.uidFilter);
        Fluttertoast.showToast(
          msg: "সফলভাবে লগইন করা হয়েছে",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: Colors.black,
          fontSize: 10.sp,
        );
        PICKUPANDBANKDETAILS _pickBankStatus =
            await pickupAndBankChecker(response.body.uidFilter.toString())
                as PICKUPANDBANKDETAILS;

        if (_pickBankStatus == PICKUPANDBANKDETAILS.none) {
          // Welcome to Home Page
          Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
        } else if (_pickBankStatus == PICKUPANDBANKDETAILS.pickup) {
          print("Bank");
          // you need to Setup Pickup Address
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/pickupdetails", (route) => false);
        } else if (_pickBankStatus == PICKUPANDBANKDETAILS.bank) {
          print("Bank");
          // you need to Setup  Bank Details
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/bankdetails", (route) => false);
        }
        context.loaderOverlay.hide();
        notifyListeners();
      } else {
        context.loaderOverlay.hide();
        notifyListeners();
      }
    } on http.ClientException catch (e) {
      context.loaderOverlay.hide();
      notifyListeners();
      if (kDebugMode) print(e.toString());
    }
  }

  Future<PICKUPANDBANKDETAILS?> pickupAndBankChecker(String uid) async {
    try {
      http.Response _pickupresponse = await ApiRoot.POST_REQUEST(
        url: 'pickup_point/completion/$uid/',
        data: {},
        isEmpty: true,
      );
      http.Response _bankresponse = await ApiRoot.POST_REQUEST(
        url: 'bank/completion/$uid',
        data: {},
        isEmpty: true,
      );

      if (_pickupresponse.statusCode == 200 &&
          _bankresponse.statusCode == 200) {
        if (!_pickupresponse.body.pickupBankStatus) {
          return PICKUPANDBANKDETAILS.pickup;
        } else if (!_bankresponse.body.pickupBankStatus) {
          return PICKUPANDBANKDETAILS.bank;
        } else {
          return PICKUPANDBANKDETAILS.none;
        }
      }
      print(_pickupresponse.body);
      debugPrint("Pickup Response is " +
          _pickupresponse.statusCode.toString() +
          " Bank Response is " +
          _bankresponse.statusCode.toString());
    } on http.ClientException catch (e) {
      print(e.toString());
    }
  }
}
