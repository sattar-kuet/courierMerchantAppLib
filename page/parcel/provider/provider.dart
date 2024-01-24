import 'dart:convert';

import 'package:courier_app/logic/parcelProvider/provider.dart';
import 'package:courier_app/main.dart';
import 'package:courier_app/model/parcelModel/getCustomerModel.dart';
import 'package:courier_app/utility/RegExp.dart';
import 'package:courier_app/utility/aptRoot.dart';
import 'package:courier_app/utility/enum.dart';
import 'package:courier_app/utility/localStore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class StatePracelProvider extends ChangeNotifier {
  // System Veriable Start Section
  bool _isFromShow = true;
  bool _searchBtnEnable = false;

  bool _exchange = false;

  bool get exchange => _exchange;

  getCustomerModel _customInfo = getCustomerModel();
  TextEditingController phoneController = TextEditingController();
  bool get searchBtnEnable => _searchBtnEnable;
  bool get isForShow => _isFromShow;
  getCustomerModel get customInfo => _customInfo;

  //  Customer Info Secation
  late TextEditingController name = TextEditingController();
  late TextEditingController address = TextEditingController();
  late String _districtItem = objectbox.getDistrict.first.idDistrict.toString();
  late String _upazillaItem = objectbox.getsUpazilla
      .where((element) =>
          element.districtId == objectbox.getDistrict.first.idDistrict)
      .first
      .upazillaID
      .toString();
  String get districtItem => _districtItem;
  String get upazillaItem => _upazillaItem;
  late String _pickupPointId = '';
  String get pickupPointId => _pickupPointId;

  // Parcel Information Secation Start
  TextEditingController noteController = TextEditingController();
  TextEditingController cashCollectionController = TextEditingController();
  TextEditingController parcelWeightController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController trakingIDController = TextEditingController();
  PARCELPAYMENTYPE _paymentType = PARCELPAYMENTYPE.paid;
  late String _deliverySpeedItem = "1";
  late String _parcelTyepItem =
      objectbox.getparcelType.first.parcelID.toString();

  double _deliveryfees = 0.0;
  bool _btnEnable = false;
  bool get btnEnable => _btnEnable;
  double get deliveryfees => _deliveryfees;
  String get parcelTypeItem => _parcelTyepItem;
  PARCELPAYMENTYPE get paymentType => _paymentType;
  String get deliverySpeedItem => _deliverySpeedItem;

// Parcel Information Method Section Start

  void onExchangeAction(bool value) {
    _exchange = value;
    notifyListeners();
  }

  void btnValidatorAction() {
    if (name.text.isNotEmpty &&
        address.text.isNotEmpty &&
        parcelWeightController.text.isNotEmpty &&
        productPriceController.text.isNotEmpty &&
        phoneController.text.isNotEmpty) {
      if (paymentType == PARCELPAYMENTYPE.cash &&
          cashCollectionController.text.isNotEmpty) {
        _btnEnable = true;
        notifyListeners();
      } else {
        _btnEnable = true;
        notifyListeners();
      }
    } else {
      _btnEnable = false;
      notifyListeners();
    }
  }

  void deliveryfessAction() async {
    try {
      http.Response deliveryfeesResponse =
          await ApiRoot.POST_REQUEST(url: "delivery/charge/get/", data: {
        "uid": SystemInfo.getUid,
        "delivery_point_upazilla_id": int.parse(_upazillaItem),
        "parcel_type_id": int.parse(_parcelTyepItem),
        "delivery_speed_id": int.parse(_deliverySpeedItem),
        "parcel_weight": parcelWeightController.value.text.isNotEmpty
            ? double.parse(parcelWeightController.value.text)
            : 0.0
      });
      if (deliveryfeesResponse.statusCode == 200) {
        final data = json.decode(deliveryfeesResponse.body)['result'];
        if (data['status'] == true) {
          _deliveryfees = data['data'];
        }
        notifyListeners();
      }
    } on http.ClientException catch (e) {
      print(e.toString());
    }
  }

  void deliverySpeedItemAction(String value) {
    _deliverySpeedItem = value.toString();
    deliveryfessAction();
    btnValidatorAction();
    notifyListeners();
  }

  void parcelTypeOnChange(BuildContext context, String value) {
    _parcelTyepItem = value;
    Provider.of<ParcelProvider>(
      context,
      listen: false,
    )..deliverySpeedAction(
        context,
        parcelType: value,
        upazilla: _upazillaItem,
      );
    deliveryfessAction();
    btnValidatorAction();
    notifyListeners();
  }

  void paymentTypeOnChange(BuildContext context, PARCELPAYMENTYPE paymentType) {
    _paymentType = paymentType;
    btnValidatorAction();
    cashCollectionController.clear();
    Provider.of<ParcelProvider>(context, listen: false)..cashFessClearAction();
    notifyListeners();
  }

//  Customer Information Function Secation Start
  void districtOnChanageAction(BuildContext context, String id) {
    _districtItem = id;
    Provider.of<ParcelProvider>(context, listen: false)
      ..upazillaInitAction(int.parse(id));
    _upazillaItem = objectbox.getsUpazilla
        .where((element) => element.districtId == int.parse(id))
        .first
        .upazillaID
        .toString();
    btnValidatorAction();
    notifyListeners();
  }

  void pickupPointOnChanageAction(BuildContext context, String id) {
    _pickupPointId = id;
    Provider.of<ParcelProvider>(
      context,
      listen: false,
    )..deliverySpeedAction(
        context,
        parcelType: _parcelTyepItem,
        upazilla: _upazillaItem,
      );
    btnValidatorAction();
    deliveryfessAction();
  }

  void upazillaOnchangeAction(BuildContext context, String id) {
    _upazillaItem = id.toString();
    Provider.of<ParcelProvider>(
      context,
      listen: false,
    )..deliverySpeedAction(
        context,
        parcelType: _parcelTyepItem,
        upazilla: _upazillaItem,
      );
    btnValidatorAction();
    deliveryfessAction();
    notifyListeners();
  }

  void onChangeAction(dynamic value) {
    RegExp regExp = RegExp(PhoneRegExp);

    if (regExp.hasMatch(value)) {
      phoneController.clear();
      notifyListeners();
    }
    if (value.length == 10) {
      // Button Enable
      _searchBtnEnable = true;
      notifyListeners();
    } else {
      // Button Disable
      _isFromShow = false;
      _searchBtnEnable = false;
      notifyListeners();
    }
  }

  void isShowFormAction() {
    _isFromShow = true;
    notifyListeners();
  }

  void singleAddressAction(BuildContext context, List<getCustomerModel> data) {
    _districtItem = data.first.districtId.toString();
    _upazillaItem = data.first.upazillaId.toString();
    name = TextEditingController(text: data.first.name);
    address = TextEditingController(text: data.first.address!.split(',').first);
    Provider.of<ParcelProvider>(context, listen: false)
      ..deliverySpeedAction(
        context,
        parcelType: _parcelTyepItem,
        upazilla: data.first.upazillaId.toString(),
      );
    notifyListeners();
  }

  void routerDataAction(BuildContext context, getCustomerModel custommerData) {
    _customInfo = custommerData;
    name = TextEditingController(text: custommerData.name ?? "");
    address = TextEditingController(
        text: custommerData.address != null
            ? custommerData.address!.split(',').first
            : "");

    _districtItem = custommerData.districtId != null
        ? custommerData.districtId.toString()
        : objectbox.getDistrict.first.idDistrict.toString();
    _upazillaItem = custommerData.upazillaId != null
        ? custommerData.upazillaId.toString()
        : objectbox.getsUpazilla.first.upazillaID.toString();
    if (custommerData.districtId != null) {
      Provider.of<ParcelProvider>(context, listen: false)
        ..upazillaInitAction(int.parse(custommerData.districtId.toString()));
    }
    Provider.of<ParcelProvider>(context, listen: false)
      ..deliverySpeedAction(
        context,
        parcelType: _parcelTyepItem,
        upazilla: custommerData.upazillaId.toString(),
      );

    isShowFormAction();
    notifyListeners();
  }

// Dispose Method Start
  void close() {
    _isFromShow = false;
    _exchange = false;
    _searchBtnEnable = false;
    _deliveryfees = 0.0;
    trakingIDController.clear();
    productPriceController.clear();
    parcelWeightController.clear();
    cashCollectionController.clear();
    phoneController.clear();
    noteController.clear();
    name.clear();
    address.clear();
    _paymentType = PARCELPAYMENTYPE.paid;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
