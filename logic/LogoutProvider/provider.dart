import 'package:courier_app/utility/aptRoot.dart';
import 'package:courier_app/utility/localStore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class LogoutProvider extends ChangeNotifier {
  void logoutAction(BuildContext context) async {
    try {
      http.Response response =
          await ApiRoot.POST_REQUEST(url: "logout/", data: {}, isEmpty: true);
      if (response.statusCode == 200) {
        SystemInfo.removeDBName();
        SystemInfo.removeToken();
        SystemInfo.removeUID();
        Fluttertoast.showToast(
          msg: "সফলভাবে লগ আউট করা হয়েছে",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: Colors.black,
          fontSize: 10.sp,
        );
        Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
