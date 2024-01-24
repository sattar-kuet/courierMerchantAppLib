import 'package:courier_app/logic/ProfileProvider/provider.dart';
import 'package:courier_app/page/PickupAndBankDetails/PickupDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StateProfileProvider extends ChangeNotifier {
  bool _isBtnEnable = true;
  bool get isBtnEnable => _isBtnEnable;

  void nameOnChangeAction(String name) {
    if (name.length > 0) {
      _isBtnEnable = true;
      notifyListeners();
    } else {
      _isBtnEnable = false;
      notifyListeners();
    }
  }

  void addressChangeAction(
    BuildContext context, {
    required int districtID,
    required int upazillaID,
    required String address,
  }) {
    Navigator.of(context, rootNavigator: true)
        .push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => PickupDetails(
          districtID: districtID,
          upazillaID: upazillaID,
          address: address,
          isUpdate: true,
        ),
      ),
    )
        .then((value) {
      Provider.of<ProfileProvider>(context, listen: false)
        ..bankDetailsAction(context);
      notifyListeners();
    });
    notifyListeners();
  }
}
