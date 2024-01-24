import 'package:courier_app/model/parcelModel/getCustomerModel.dart';
import 'package:courier_app/page/parcel/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class alertDialogProvider extends ChangeNotifier {
  late String _itemSelect;
  String get itemSelect => _itemSelect;

  void initItemSelect(String value) {
    _itemSelect = value;
    notifyListeners();
  }

  void onchangeAction(String value) {
    _itemSelect = value;
    print(value);
    notifyListeners();
  }

  void selectAction(
      BuildContext context, List<getCustomerModel> custommerData) {
    if (_itemSelect != "custom") {
      Navigator.of(context).pop(custommerData
          .where((element) => element.id == int.parse(_itemSelect))
          .first);
    } else {
      Navigator.of(context).pop(getCustomerModel());
    }
  }

  @override
  void dispose() {
    _itemSelect = "";
    super.dispose();
  }
}
