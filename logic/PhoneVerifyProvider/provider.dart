import 'dart:convert';
import 'package:courier_app/model/router/loginModel.dart';
import 'package:courier_app/page/Auth/otpVerifyWithLogin/Provider/provider.dart';
import 'package:courier_app/utility/aptRoot.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PHONENUMBERVERIFYPROVIDER extends ChangeNotifier {
  void phoneVerifyAction(
      {required String phone, required BuildContext context}) async {
    try {
      context.loaderOverlay.show();
      notifyListeners();
      // This Method Check user is Exist or Not
      http.Response isExistResponse = await ApiRoot.POST_REQUEST(
        url: "user/is_exist/",
        data: {"phone": phone, 'user_type': 'merchant'},
      );
      if (isExistResponse.statusCode == 200) {
        userExistModel existData = userExistModel.fromJson(
          json.decode(isExistResponse.body)['result'],
        );
        if (existData.wrongUserType!) {
          Fluttertoast.showToast(
            msg: "এই নাম্বারটি রাইডার হিসাবে রেজিস্ট্রেশন করা আছে!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: const Color.fromARGB(255, 255, 254, 254),
            fontSize: 10.sp,
          );
          context.loaderOverlay.hide();
          notifyListeners();
        } else {
          http.Response response = await ApiRoot.POST_REQUEST(
            url: "password/sendotp/",
            data: {
              "phone": phone,
              "message": "আপনার ভেরিফিকেশন কোড হচ্ছে: " +
                  existData.newPassword.toString(),
            },
          );
          if (response.statusCode == 200) {
            context.loaderOverlay.hide();
            Provider.of<OtpLoginProvider>(context, listen: false)
              ..routerDataAction(data: existData, phone: phone);
            Navigator.of(context).pushNamed("/otpVerifyWithLogin");
            notifyListeners();
          } else {
            context.loaderOverlay.hide();
            notifyListeners();
          }
          context.loaderOverlay.hide();
          notifyListeners();
          if (kDebugMode) print("Otp Send Response is ${response.statusCode}");
        }
      } else {
        context.loaderOverlay.hide();
        notifyListeners();
      }
      if (kDebugMode)
        print("User Exist Response is ${isExistResponse.statusCode}");
    } on http.ClientException catch (e) {
      context.loaderOverlay.hide();
      notifyListeners();
      print(e.toString());
    }
  }
}
