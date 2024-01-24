import 'dart:convert';
import 'package:courier_app/logic/HomeProvider/provider.dart';
import 'package:courier_app/main.dart';
import 'package:courier_app/model/PickupModel/model.dart';
import 'package:courier_app/model/parcelModel/deliveySpeed.dart';
import 'package:courier_app/model/parcelModel/getCustomerModel.dart';
import 'package:courier_app/model/parcelModel/parcelType.dart';
import 'package:courier_app/model/profile/model.dart';
import 'package:courier_app/page/Home/Home.dart';
import 'package:courier_app/page/parcel/Dialog/dialog.dart';
import 'package:courier_app/page/parcel/provider/provider.dart';
import 'package:courier_app/page/parcel/routerSettings/settings.dart';
import 'package:courier_app/utility/aptRoot.dart';
import 'package:courier_app/utility/enum.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/utility/localStore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ParcelProvider extends ChangeNotifier {
  // Custom info Ge with Send Data router Variable Secation Start

  CUSTOMERDATAGET _customerGetLoading = CUSTOMERDATAGET.None;
  List<getCustomerModel> _customerInfo = [];
  CUSTOMERDATAGET get customerGetLoading => _customerGetLoading;
  List<getCustomerModel> get customerInfo => _customerInfo;

// Address Infromation Variable Secation Start

  List<districtModel> _district = objectbox.getDistrict;
  late List<upazillaModel> _upazilla = objectbox.getsUpazilla
      .where((element) =>
          element.districtId == objectbox.getDistrict.first.idDistrict)
      .toList();

  List<districtModel> get district => _district;
  List<upazillaModel> get upazilla => _upazilla;
  late List<PickupPointModel> _pickupPoint = [];
  List<PickupPointModel> get pickupPoint => _pickupPoint;

  // Parcel Information Secation Start

  List<parcelTypeModel> _parcelType = objectbox.getparcelType;
  List<parcelTypeModel> get parcelType => _parcelType;

  double _cashFess = 0.0;
  double get cashFees => _cashFess;

  bool _deliveryFessshow = false;
  bool get deliveryFessshow => _deliveryFessshow;

  late List<deliverySpeedModel> _deliverySpeed = [];
  List<deliverySpeedModel> get deliverySpeed => _deliverySpeed;

  // Parcel Info Mathod Secation Start

  void cashFessClearAction() {
    _cashFess = 0.0;
  }

  void cashCollectionAction(String cash, String upazilla) async {
    try {
      http.Response cashResponse =
          await ApiRoot.POST_REQUEST(url: "cod/charge/get/", data: {
        "uid": SystemInfo.getUid,
        "delivery_point_upazilla_id": int.parse(upazilla),
        "cash_collection": int.parse(cash)
      });

      if (cashResponse.statusCode == 200) {
        _cashFess = json.decode(cashResponse.body)['result']['data'];
        notifyListeners();
      }
    } on http.ClientException catch (e) {
      print(e);
    }
  }

  void upazillaInitAction(int? id) {
    _upazilla = [];
    _upazilla = objectbox.getsUpazilla
        .where((element) =>
            element.districtId ==
            (id ?? objectbox.getDistrict.first.idDistrict))
        .toList();
    notifyListeners();
  }

//  Custom Phone Search is already Exists or not
  void customeNumberSearchAction(BuildContext context, String phone) async {
    try {
      _customerGetLoading = CUSTOMERDATAGET.Loading;
      notifyListeners();
      http.Response response = await ApiRoot.POST_REQUEST(
          url: "customer/get/", data: {"phone": phone});

      if (response.statusCode == 200) {
        List data = response.body.getCustomer;
        if (data.first == CUSTOMHASDATA.Has) {
          // Custom Date insert
          _customerInfo = [];
          _customerInfo.addAll(data.last);
          _customerGetLoading = CUSTOMERDATAGET.Success;

          _deliveryFessshow = true;
          notifyListeners();

          if (_customerInfo.length > 1) {
            // open Address Selete Dialog
            getCustomerModel custommerData = await Navigator.of(context)
                .push(HeroDialogRoute(builder: (context) {
              return DialogPage();
            }));

            if (custommerData != getCustomerModel()) {
              // Call Router Date Action
              Provider.of<StatePracelProvider>(context, listen: false)
                ..routerDataAction(context, custommerData);
            } else {
              // Just Forme Show
              Provider.of<StatePracelProvider>(context, listen: false)
                ..isShowFormAction();
            }
          } else if (data.isNotEmpty) {
            _deliveryFessshow = true;
            notifyListeners();
            // this section when open if custom date length 1 is execute
            upazillaInitAction(_customerInfo.first.districtId);
            Provider.of<StatePracelProvider>(context, listen: false)
                .isShowFormAction();

            Provider.of<StatePracelProvider>(context, listen: false)
                .singleAddressAction(context, _customerInfo);
          }
          notifyListeners();
        } else if (data.first == CUSTOMHASDATA.Not) {
          _deliveryFessshow = true;
          notifyListeners();
          // custom not exists date this statement execute
          _customerGetLoading = CUSTOMERDATAGET.Success;
          Provider.of<StatePracelProvider>(context, listen: false)
              .isShowFormAction();
          notifyListeners();
        }
      }
      if (kDebugMode)
        print("customer get Response " + response.statusCode.toString());
    } on http.ClientException catch (e) {
      _customerGetLoading = CUSTOMERDATAGET.Success;
      notifyListeners();
      print(e.toString());
    }
  }

  void registerParcelAction(
    BuildContext context, {
    required String pickupPointId,
    required String number,
    required String name,
    required String district,
    required String upazilla,
    required String address,
    required String typeid,
    required String deliverySpeed,
    required String actualPrice,
    required String cash,
    required String weight,
    required String merchantReference,
    required String note,
    required bool exchange,
  }) async {
    try {
      print(exchange);
      context.loaderOverlay.show();
      notifyListeners();
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      http.Response parcelCreateResponse =
          await ApiRoot.POST_REQUEST(url: "parcel/add_or_update/", data: {
        "uid": SystemInfo.getUid,
        "id": 0,
        "pickup_point_id": int.parse(pickupPointId),
        "customer": {
          "phone": "880" + number,
          "name": name,
          "district_id": int.parse(district),
          "upazilla_id": int.parse(upazilla),
          "detail_address": address
        },
        "parcel": {
          "type_id": int.parse(typeid),
          "delivery_speed_id": int.parse(deliverySpeed),
          "actual_price": int.parse(actualPrice),
          "cash_collection": int.parse(cash),
          "weight": weight as dynamic,
          "merchant_reference": merchantReference,
          "has_exchange": exchange,
          "note": note
        }
      });

      if (parcelCreateResponse.statusCode == 200) {
        context.loaderOverlay.hide();
        print(parcelCreateResponse.body);
        Fluttertoast.showToast(
          msg: json.decode(parcelCreateResponse.body)['result']['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: Colors.black,
          fontSize: 10.sp,
        );
        Provider.of<HomeProvider>(context, listen: false)
          ..parcelHomeAction()
          ..transactionHomeAction()
          ..accountManagerHomeAction()
          ..noticeHomeAction();
        Navigator.of(context).pop();

        notifyListeners();
      } else {
        context.loaderOverlay.hide();
        notifyListeners();
      }
      print("Parcel Create Response " +
          parcelCreateResponse.statusCode.toString());
    } on http.ClientException catch (e) {
      print(e.toString());
      context.loaderOverlay.hide();
      notifyListeners();
    }
  }

  void loadInitialData(BuildContext context) async {
    try {
      http.Response pickupPointResponse = await ApiRoot.POST_REQUEST(
          url: "pickup_point/get", data: {"uid": SystemInfo.getUid});

      if (pickupPointResponse.statusCode == 200) {
        _pickupPoint =
            (json.decode(pickupPointResponse.body)['result']['data'] as List)
                .map((e) => PickupPointModel.fromJson(e))
                .toList();
        notifyListeners();
      }
    } on http.ClientException catch (e) {
      print(e);
    }
  }

  void deliverySpeedAction(
    BuildContext context, {
    required String upazilla,
    required String parcelType,
  }) async {
    try {
      http.Response deliverySpeedResponse =
          await ApiRoot.POST_REQUEST(url: "delivery/speed/get/", data: {
        "uid": SystemInfo.getUid,
        "delivery_point_upazilla_id": int.parse(upazilla),
        "parcel_type_id": int.parse(parcelType)
      });

      if (deliverySpeedResponse.statusCode == 200) {
        _deliverySpeed =
            (json.decode(deliverySpeedResponse.body)['result']['data'] as List)
                .map((e) => deliverySpeedModel.fromJson(e))
                .toList();
        Provider.of<StatePracelProvider>(context, listen: false)
          ..deliverySpeedItemAction(_deliverySpeed.first.idspeed.toString());
        notifyListeners();
      }
    } on http.ClientException catch (e) {
      print(e);
    }
  }

  void close() {
    _cashFess = 0.0;
    _deliveryFessshow = false;
  }
}
