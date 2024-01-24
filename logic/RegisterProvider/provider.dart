import 'dart:convert';

import 'package:courier_app/model/registerModel/model.dart';
import 'package:courier_app/utility/aptRoot.dart';
import 'package:courier_app/utility/enum.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/utility/localStore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

class REGISTERACTIONPROVIDER extends ChangeNotifier {
  REGISTERERRORTYPE _errorType = REGISTERERRORTYPE.None;
  REGISTERERRORTYPE get errorType => _errorType;

  void registerAction(
    BuildContext context, {
    required registerTojson data,
  }) async {
    try {
      context.loaderOverlay.show();
      notifyListeners();
      http.Response response = await ApiRoot.POST_REQUEST(
        url: 'api/custom/registration/',
        data: data.toJson(),
      );
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        if (response.body.statusCheck == 200) {
          print(SystemInfo.geDBName);
          
          http.Response loginResponse = await ApiRoot.POST_REQUEST(
            url: 'web/session/authenticate/',
            data: {
              "db": SystemInfo.geDBName,
              "login": data.email,
              "password": data.password
            },
          );
          if (loginResponse.statusCode == 200) {
            SystemInfo.setToken(
                loginResponse.headers['set-cookie'].cookieFilter);
            SystemInfo.setUid(response.body.uidFilter);
            _errorType = REGISTERERRORTYPE.None;
            Fluttertoast.showToast(
              msg: "সফলভাবে রেজিষ্ট্রেশন করা হয়েছে",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Theme.of(context).colorScheme.primary,
              textColor: Colors.black,
              fontSize: 10.sp,
            );
            context.loaderOverlay.hide();
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/pickupdetails", (route) => false);
            notifyListeners();
          } else {
            context.loaderOverlay.hide();
            notifyListeners();
          }
        } else {
          _errorType = response.body.registerErrorType;
          context.loaderOverlay.hide();
          notifyListeners();
        }
      } else {
        context.loaderOverlay.hide();
        notifyListeners();
      }

      if (kDebugMode)
        print("Register Status is " + response.statusCode.toString());
    } on http.ClientException catch (e) {
      context.loaderOverlay.hide();
      notifyListeners();
      print(e);
    }
  }
}
