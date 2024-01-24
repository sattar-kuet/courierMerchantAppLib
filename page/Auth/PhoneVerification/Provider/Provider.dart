import 'package:courier_app/logic/PhoneVerifyProvider/provider.dart';
import 'package:courier_app/utility/RegExp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneVerifyActionProvider extends ChangeNotifier {
  TextEditingController controller = TextEditingController();
  bool _btnEnable = false;

  bool get btnEnable => _btnEnable;

  void onChange(dynamic value) {
    RegExp regExp = RegExp(PhoneRegExp);

    if (regExp.hasMatch(value)) {
      controller.clear();
      notifyListeners();
    }
    if (value.length == 10) {
      _btnEnable = true;
      notifyListeners();
    } else {
      _btnEnable = false;
      notifyListeners();
    }
  }

  void verifyAction(BuildContext context) {
    Provider.of<PHONENUMBERVERIFYPROVIDER>(context, listen: false)
      ..phoneVerifyAction(context: context, phone: "880" + controller.text);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
