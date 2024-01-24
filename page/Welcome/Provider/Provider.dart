import 'dart:convert';

import 'package:courier_app/main.dart';
import 'package:courier_app/model/PickupModel/model.dart';
import 'package:courier_app/model/parcelModel/parcelType.dart';
import 'package:courier_app/utility/aptRoot.dart';
import 'package:courier_app/utility/enum.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/utility/localStore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginStatusProvider extends ChangeNotifier {
  void loginStatusAction(BuildContext context) async {
    initDataStore();
    getDatabaseName();
    bool loginStatus = await loginStatusCheck() as bool;
    if (SystemInfo.getToken != null && loginStatus == true) {
      PICKUPANDBANKDETAILS _pickBankStatus =
          await pickupAndBankChecker(SystemInfo.getUid.toString())
              as PICKUPANDBANKDETAILS;

      if (_pickBankStatus == PICKUPANDBANKDETAILS.none) {
        // Welcome to Home Page
        Future.delayed(
          Duration(seconds: 3),
          () => Navigator.of(context).pushNamedAndRemoveUntil(
            "/homePage",
            (route) => false,
          ),
        );
      } else if (_pickBankStatus == PICKUPANDBANKDETAILS.pickup) {
        // you need to Setup Pickup Address
        Future.delayed(
          Duration(seconds: 3),
          () => Navigator.of(context).pushNamedAndRemoveUntil(
            "/pickupdetails",
            (route) => false,
          ),
        );
      } else if (_pickBankStatus == PICKUPANDBANKDETAILS.bank) {
        // you need to Setup  Bank Details
        Future.delayed(
          Duration(seconds: 3),
          () => Navigator.of(context).pushNamedAndRemoveUntil(
            "/bankdetails",
            (route) => false,
          ),
        );
      }
    } else {
      Future.delayed(
        Duration(seconds: 3),
        () => Navigator.of(context).pushNamedAndRemoveUntil(
          "/phoneverify",
          (route) => false,
        ),
      );
      notifyListeners();
    }
  }

  Future<PICKUPANDBANKDETAILS?> pickupAndBankChecker(String uid) async {
    try {
      http.Response _pickupresponse = await ApiRoot.POST_REQUEST(
        url: 'pickup_point/completion/$uid/',
        data: {},
        isEmpty: true,
      );
      http.Response _bankresponse = await ApiRoot.POST_REQUEST(
        url: 'bank/completion/$uid',
        data: {},
        isEmpty: true,
      );

      if (_pickupresponse.statusCode == 200 &&
          _bankresponse.statusCode == 200) {
        if (!_pickupresponse.body.pickupBankStatus) {
          return PICKUPANDBANKDETAILS.pickup;
        } else if (!_bankresponse.body.pickupBankStatus) {
          print(json.decode(_bankresponse.body));
          return PICKUPANDBANKDETAILS.bank;
        } else {
          return PICKUPANDBANKDETAILS.none;
        }
      }

      debugPrint("Pickup get Response is " +
          _pickupresponse.statusCode.toString() +
          " Bank get Response is " +
          _bankresponse.statusCode.toString());
    } on http.ClientException catch (e) {
      print(e.toString());
    }
  }

  void initDataStore() async {
    try {
      http.Response districtResponse = await ApiRoot.POST_REQUEST(
        url: 'district/get/',
        data: {},
        isEmpty: true,
      );
      http.Response upazillaResponse = await ApiRoot.POST_REQUEST(
        url: 'upazilla/list/',
        data: {},
        isEmpty: true,
      );
      http.Response parcelTyepResponse = await ApiRoot.POST_REQUEST(
        url: 'parcel/type/get/',
        data: {},
        isEmpty: true,
      );

      // http.Response deliverySpeedResponse = await ApiRoot.POST_REQUEST(
      //   url: 'delivery/speed/get/',
      //   data: {},
      //   isEmpty: true,
      // );

      if (districtResponse.statusCode == 200 &&
          upazillaResponse.statusCode == 200 &&
          parcelTyepResponse.statusCode == 200) {
        // district
        objectbox.deleteDistrict();
        List<districtModel> districtData = districtResponse.body.districts;
        districtData.forEach((element) => objectbox.setDistrict(element));

        //upazill
        objectbox.deleteUpazilla();
        List<upazillaModel> upazillaData = upazillaResponse.body.upazillas;
        upazillaData.forEach((element) => objectbox.setUpazilla(element));

        // Parcel Type
        objectbox.deleteparcelType();
        List<parcelTypeModel> parcelData = parcelTyepResponse.body.parceltype;
        parcelData.forEach((element) => objectbox.setparcelType(element));

        // Delivery Speed
        // objectbox.deleteDeliverySpeed();
        // List<deliverySpeedModel> deliverySpeedData =
        //     deliverySpeedResponse.body.deliveryspeed;
        // deliverySpeedData
        //     .forEach((element) => objectbox.setDeliverySpeed(element));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool?> loginStatusCheck() async {
    try {
      http.Response response = await ApiRoot.POST_REQUEST(
          url: "session/check/", data: {}, isEmpty: true);
      print(json.decode(response.body));
      if (response.statusCode == 200) {
        bool data = json.decode(response.body)['result']['status'];
        if (data == true) {
          return true;
        }
        if (data == false) {
          return false;
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getDatabaseName() async {
    http.Response response =
        await ApiRoot.POST_REQUEST(url: 'db_name', data: {}, isEmpty: true);
    if (response.statusCode == 200) {
      SystemInfo.setDBName(json.decode(response.body)['result']['db']);
      print(SystemInfo.geDBName);
    }
  }
}
