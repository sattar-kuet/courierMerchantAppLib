import 'package:courier_app/logic/LoginProvider/provider.dart';
import 'package:courier_app/model/router/loginModel.dart';
import 'package:courier_app/page/Auth/Register/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OtpLoginProvider extends ChangeNotifier {
  String otpController = '';
  userExistModel _data = userExistModel();
  String _phone = "";
  bool _btnEnable = false;
  String get phone => _phone;
  bool get btnEnable => _btnEnable;
  userExistModel get routerData => _data;

  void routerDataAction({required userExistModel data, required String phone}) {
    _data = data;
    _phone = phone;
    notifyListeners();
  }

  void onChangeAction(String value) {
    if (value.length == 6) {
      _btnEnable = true;
      otpController = value;
      notifyListeners();
    } else {
      _btnEnable = false;
      notifyListeners();
    }
  }

  void otpAction(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    context.loaderOverlay.show();
    notifyListeners();
    if (_data.newPassword == otpController) {
      context.loaderOverlay.hide();
      if (_data.status!) {
        Provider.of<LOGINUSERACCOUNTPROVIDER>(context, listen: false)
          ..loginAction(
            context,
            mail: _data.login.toString(),
            password: _data.newPassword.toString(),
          );
      } else {
        Provider.of<registerProvider>(context, listen: false)
          ..routerData(password: _data.newPassword.toString(), phone: _phone);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/register', (route) => false);
      }
    } else {
      context.loaderOverlay.hide();
      notifyListeners();
      Fluttertoast.showToast(
        msg: "Wrong OTP",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 10.sp,
      );
    }
  }
}
