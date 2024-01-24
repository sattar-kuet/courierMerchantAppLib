import 'package:courier_app/logic/PickUpBankDetails/Provider.dart';
import 'package:courier_app/main.dart';
import 'package:courier_app/model/BankModel/model.dart';
import 'package:courier_app/model/PickupModel/model.dart';
import 'package:courier_app/utility/enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatePickupandBankDetailsProvider extends ChangeNotifier {
  // Below Pickup Details Veriable
  int id = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  late String _districtItem;
  late String _upazillaItem;

  bool _btnEnable = false;
  bool get btnEnable => _btnEnable;
  bool _backToProfile = false;
  bool get backToProfile => _backToProfile;

  String get districtItem => _districtItem;
  String get upazillaItem => _upazillaItem;

  // Below Bank Details Veriable Secation
  TextEditingController phoneController = TextEditingController();
  MOBILEBANKSTATUS bankingType = MOBILEBANKSTATUS.personal;
  String _bankItem = "";
  BNAKDETAILSSTATUS bankingStatus = BNAKDETAILSSTATUS.none;
  bool _bankBtnEnable = false;
  bool get bankBtnEnable => _bankBtnEnable;
  String get bankItem => _bankItem;
  // Bank
  TextEditingController accountName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController branch = TextEditingController();

  // Below Pickup Details Function

  void initPickupPoint({
    int? id,
    String? name,
    String? address,
    int? districtID,
    int? upazillaID,
    required bool isUpdate,
    required bool backToProfile,
  }) {
    if (isUpdate) {
      id = id ?? 0;
      _backToProfile = backToProfile;
      nameController = TextEditingController(text: name);
      addressController = TextEditingController(text: address);
      _districtItem = districtID.toString();
      _upazillaItem = upazillaID.toString();
      _btnEnable = true;
      notifyListeners();
    } else {
      addressController = TextEditingController();
      _districtItem = objectbox.getDistrict.first.idDistrict.toString();
      _upazillaItem = objectbox.getsUpazilla
          .where((element) =>
              element.districtId == objectbox.getDistrict.first.idDistrict)
          .first
          .upazillaID
          .toString();
      notifyListeners();
    }
  }

  void onChangeDistrictAction(String value, BuildContext context) {
    _districtItem = value;

    List<upazillaModel> upazillaData = objectbox.getsUpazilla
        .where((element) => element.districtId == int.parse(value))
        .toList();

    Provider.of<PickupAndBankDetailsProvider>(context, listen: false)
      ..upazillaAction(context, upazillaData);
    _upazillaItem = upazillaData.first.upazillaID.toString();

    notifyListeners();
  }

  void onChangeUpazillaAction(String value, BuildContext context) {
    _upazillaItem = value;
    btnEnableAction();
    notifyListeners();
  }

  void btnEnableAction() {
    if (_districtItem != "" &&
        _upazillaItem != "" &&
        addressController.value.text.isNotEmpty) {
      _btnEnable = true;
      notifyListeners();
    } else {
      _btnEnable = false;
      notifyListeners();
    }
  }
  // Below Bank Details function Secation

  void initBankDataValue(
    String value, {
    required List<BankDetailsModel> bankData,
  }) {
    _bankItem = value;
    BankDetailsModel data =
        bankData.where((element) => element.id == int.parse(value)).first;
    if (data.isMobileBanking == true) {
      bankingStatus = BNAKDETAILSSTATUS.mobile;
    } else {
      bankingStatus = BNAKDETAILSSTATUS.bank;
    }
    notifyListeners();
  }

  void onChangeBankAction(
    String value, {
    required List<BankDetailsModel> bankData,
  }) async {
    _bankItem = value;
    BankDetailsModel data =
        bankData.where((element) => element.id == int.parse(value)).first;
    if (data.isMobileBanking == true) {
      bankingStatus = BNAKDETAILSSTATUS.mobile;
    } else {
      bankingStatus = BNAKDETAILSSTATUS.bank;
    }
    notifyListeners();
  }

  void radioOnchangeAction(MOBILEBANKSTATUS value) {
    bankingType = value;
    notifyListeners();
  }

  void bankOnChangeAction(String value) {
    if (value.length >= 11) {
      _bankBtnEnable = true;
      notifyListeners();
    } else {
      _bankBtnEnable = false;
      notifyListeners();
    }
  }

// Bank
  void onchangeAccountName() {
    if (accountName.value.text.isNotEmpty &&
        accountNumber.value.text.isNotEmpty &&
        branch.value.text.isNotEmpty) {
      _bankBtnEnable = true;
      notifyListeners();
    } else {
      _bankBtnEnable = false;
      notifyListeners();
    }
  }

  void onchangeAccountNumber() {
    if (accountName.value.text.isNotEmpty &&
        accountNumber.value.text.isNotEmpty &&
        branch.value.text.isNotEmpty) {
      _bankBtnEnable = true;
      notifyListeners();
    } else {
      _bankBtnEnable = false;
      notifyListeners();
    }
  }

  void onchangeBranch() {
    if (accountName.value.text.isNotEmpty &&
        accountNumber.value.text.isNotEmpty &&
        branch.value.text.isNotEmpty) {
      _bankBtnEnable = true;
      notifyListeners();
    } else {
      _bankBtnEnable = false;
      notifyListeners();
    }
  }

  void clear() {
    accountName.clear();
    accountNumber.clear();
    branch.clear();
    addressController.clear();
    phoneController.clear();
  }
}
