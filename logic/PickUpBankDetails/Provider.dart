import 'dart:convert';

import 'package:courier_app/main.dart';
import 'package:courier_app/model/BankModel/model.dart';
import 'package:courier_app/model/PickupModel/model.dart';
import 'package:courier_app/model/profile/model.dart';
import 'package:courier_app/page/PickupAndBankDetails/Provider/provider.dart';
import 'package:courier_app/utility/aptRoot.dart';
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

class PickupAndBankDetailsProvider extends ChangeNotifier {
  // Blow Pickup Details Veriable Secation Start
  late TextEditingController titleController;
  late List<districtModel> _districtData;

  late List<upazillaModel> _upazillaData;
  List<districtModel> get districtData => _districtData;
  List<upazillaModel> get upazillaData => _upazillaData;

  // Blow Bank Details Veriable Secation Start

  late List<BankDetailsModel> _bankData = [];
  List<BankDetailsModel> get bankData => _bankData;

  // Blow Pickup Details Function Secation Start
  void loadDistrictUpazilla(bool isUpdate, int? districtID) {
    if (isUpdate) {
      _districtData = objectbox.getDistrict;
      _upazillaData = objectbox.getsUpazilla
          .where((element) => element.districtId == districtID)
          .toList();

      notifyListeners();
    } else {
      _districtData = objectbox.getDistrict;
      _upazillaData = objectbox.getsUpazilla
          .where((element) =>
              element.districtId == objectbox.getDistrict.first.idDistrict)
          .toList();
      notifyListeners();
    }
  }

  void upazillaAction(
      BuildContext context, List<upazillaModel> upazillaData) async {
    try {
      _upazillaData = [];
      _upazillaData = upazillaData;
      notifyListeners();
    } on http.ClientException catch (e) {
      debugPrint(e.toString());
    }
  }

  void pickupDetailsSubmitAction(
    BuildContext context, {
    int id = 0,
    required String name,
    required int districtId,
    required int upazillaId,
    required String address,
    required String lat,
    required String lng,
    bool backToProfile = false,
  }) async {
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      context.loaderOverlay.show();
      notifyListeners();
      dynamic pickupPointData = {
        "id": id,
        "uid": SystemInfo.getUid,
        "name": name,
        "district_id": districtId,
        "upazilla_id": upazillaId,
        "address": address,
        "lat": lat,
        "lng": lng
      };
      print(pickupPointData);
      http.Response response = await ApiRoot.POST_REQUEST(
          url: 'pickup_point/add_or_update/', data: pickupPointData);
      print(response.body);
      if (response.statusCode == 200) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          // //context.loaderOverlay.hide();
          Fluttertoast.showToast(
            msg: "পিক আপ পয়েন্ট সফলভাবে আপডেট করা হয়েছে",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 10.sp,
          );
        });

        if (backToProfile) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/profile", (route) => false);
            notifyListeners();
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/bankdetails", (route) => false);
            notifyListeners();
          });
        }
      } else {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          // //context.loaderOverlay.hide();
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/welcome", (route) => false);
          notifyListeners();
        });
      }
    } on http.ClientException catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //context.loaderOverlay.hide();
        notifyListeners();
        print(e.toString());
      });
    }
  }

  //  Blow Bank Details Secation Start

  void bankDetailsAction(
    BuildContext context,
  ) async {
    try {
      context.loaderOverlay.show();
      notifyListeners();
      http.Response response = await ApiRoot.POST_REQUEST(
        url: "bank/list/",
        isEmpty: true,
        data: {},
      );
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        _bankData = response.body.banksData;
        WidgetsBinding.instance.addPostFrameCallback((timeSta9mp) {
          Provider.of<StatePickupandBankDetailsProvider>(context, listen: false)
            ..initBankDataValue(response.body.banksData.first.id.toString(),
                bankData: response.body.banksData);
          context.loaderOverlay.hide();
          notifyListeners();
        });
      } else {
        context.loaderOverlay.hide();
        notifyListeners();
      }
    } on http.ClientException catch (e) {
      context.loaderOverlay.hide();
      notifyListeners();
      print(e.toString());
    }
  }

  void mobileOnSubmitAction(BuildContext context,
      {required String phone,
      required int bankId,
      required String type}) async {
    try {
      context.loaderOverlay.show();
      notifyListeners();
      http.Response response =
          await ApiRoot.POST_REQUEST(url: "bank/add_or_update/", data: {
        "uid": SystemInfo.getUid,
        "bank_id": bankId,
        "account_name": "",
        "account_number": "",
        "branch": "",
        "mobile_number": phone,
        "mobile_bank_account_type": type,
        "selected_bank_type": "mobile_bank"
      });

      if (response.statusCode == 200) {
        //context.loaderOverlay.hide();
        Fluttertoast.showToast(
          msg: "মোবাইল ব্যাংকিং তথ্য সফলভাবে আপডেট করা হয়েছে",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: Colors.black,
          fontSize: 10.sp,
        );
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/homePage", (route) => false);
        notifyListeners();
      } else {
        //context.loaderOverlay.hide();
        notifyListeners();
      }
    } on http.ClientException catch (e) {
      //context.loaderOverlay.hide();
      notifyListeners();
      print(e.toString());
    }
  }

  void bankOnSubmitAction(
    BuildContext context, {
    required String accountName,
    required String accountNumber,
    required int bank,
    required String branch,
  }) async {
    try {
      context.loaderOverlay.show();
      notifyListeners();
      http.Response response =
          await ApiRoot.POST_REQUEST(url: "bank/add_or_update/", data: {
        "uid": SystemInfo.getUid,
        "bank_id": bank,
        "account_name": accountName,
        "account_number": accountNumber,
        "branch": branch,
        "mobile_number": '',
        "mobile_bank_account_type": "",
        "selected_bank_type": "normal_bank"
      });
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        //context.loaderOverlay.hide();
        Fluttertoast.showToast(
          msg: "ব্যাঙ্কের তথ্য সফলভাবে আপডেট করা হয়েছে",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: Colors.black,
          fontSize: 10.sp,
        );
        Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
        notifyListeners();
      } else {
        //context.loaderOverlay.hide();
        notifyListeners();
      }
      if (kDebugMode)
        print("Banks Response is " + response.statusCode.toString());
    } on http.ClientException catch (e) {
      //context.loaderOverlay.hide();
      notifyListeners();
      print(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
