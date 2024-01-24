import 'package:courier_app/utility/RegExp.dart';
import 'package:flutter/material.dart';

class registerProvider extends ChangeNotifier {
  late String _password;
  late String _phone;
  bool _btnEnable = false;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController business = TextEditingController();

  bool get btnEnable => _btnEnable;
  String get phone => _phone;
  String get password => _password;
  void routerData({required String password, required String phone}) {
    _password = password;
    _phone = phone;
    notifyListeners();
  }

  void onChangeAction() {
    final mailValidation = RegExp(maileRegExp);
    if (name.value.text.isNotEmpty &&
        mailValidation.hasMatch(email.text) &&
        business.value.text.isNotEmpty) {
      _btnEnable = true;
      notifyListeners();
    } else {
      _btnEnable = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    business.dispose();
    super.dispose();
  }
}
