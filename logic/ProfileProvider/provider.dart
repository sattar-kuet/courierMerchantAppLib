import 'dart:convert';
import 'package:courier_app/model/profile/model.dart';
import 'package:courier_app/utility/aptRoot.dart';
import 'package:courier_app/utility/localStore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileProvider extends ChangeNotifier {
  bool _isEditeMode = false;
  bool get isEditeMode => _isEditeMode;
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  String _name = "";
  String get name => _name;
  List<PickupPointModel> _pickupPoints = [];
  List<PickupPointModel> get pickupPoints => _pickupPoints;

  profileBankModel _bankDetails = profileBankModel();
  profileBankModel get bankDetails => _bankDetails;
  late TextEditingController nameController;

  void editeAction(String value) {
    _isEditeMode = true;
    nameController = TextEditingController(text: value);
    notifyListeners();
  }

  void nameChangeAction(BuildContext context, String name) async {
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      context.loaderOverlay.show();
      _isEditeMode = false;
      notifyListeners();
      http.Response nameChangeResponse =
          await ApiRoot.POST_REQUEST(url: "profile/update/", data: {
        "uid": SystemInfo.getUid,
        "name": name,
      });

      if (nameChangeResponse.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "সফলভাবে কাস্টমার নাম পরিবর্তন করা হয়েছে",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: Colors.black,
          fontSize: 10.sp,
        );
        Provider.of<ProfileProvider>(context, listen: false)
          ..nameGetAction(context);

        context.loaderOverlay.hide();
        notifyListeners();
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void nameGetAction(BuildContext context) async {
    try {
      context.loaderOverlay.show();
      notifyListeners();
      http.Response response = await ApiRoot.POST_REQUEST(
          url: "profile/get", data: {"uid": SystemInfo.getUid});

      if (response.statusCode == 200) {
        _name = json.decode(response.body)['result']['data']['name'];
        _isLoading = false;
        context.loaderOverlay.hide();
        notifyListeners();
      } else {
        _isLoading = false;
        context.loaderOverlay.hide();
        notifyListeners();
      }
    } catch (e) {
      _isLoading = false;
      context.loaderOverlay.hide();
      notifyListeners();
    }
  }

  void loadPickupPoints(BuildContext context) async {
    context.loaderOverlay.show();
    notifyListeners();
    http.Response response = await ApiRoot.POST_REQUEST(
        url: "pickup_point/get/", data: {"uid": SystemInfo.getUid});

    dynamic responseResult = json.decode(response.body)['result'];
    if (response.statusCode == 200 && responseResult['status']) {
      _pickupPoints = [];
      _pickupPoints = (json.decode(response.body)['result']['data'] as List)
          .map((e) => PickupPointModel.fromJson(e))
          .toList();
      _isLoading = false;
      context.loaderOverlay.hide();
      notifyListeners();
    } else {
      _isLoading = false;
      context.loaderOverlay.hide();
      notifyListeners();
    }
  }

  void deletePickupPoint(BuildContext context, int pickupPointId) async {
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      context.loaderOverlay.show();
      notifyListeners();
      http.Response response = await ApiRoot.POST_REQUEST(
          url: 'pickup_point/delete/', data: {'id': pickupPointId});
      print(response.body);
      if (response.statusCode == 200) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          // //context.loaderOverlay.hide();
          Fluttertoast.showToast(
            msg: "পিক আপ পয়েন্ট সফলভাবে ডিলেট হয়েছে",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 10.sp,
          );
        });
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/profile", (route) => false);
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

  void bankDetailsAction(BuildContext context) async {
    // try {
    context.loaderOverlay.show();
    notifyListeners();
    http.Response response = await ApiRoot.POST_REQUEST(
      url: "bank/get/",
      data: {"uid": SystemInfo.getUid},
    );

    if (response.statusCode == 200) {
      _bankDetails = profileBankModel.fromJson(
        json.decode(response.body)['result']['data'],
      );
      notifyListeners();
    }
    context.loaderOverlay.hide();
    notifyListeners();

    if (kDebugMode)
      print("Address Response is " + response.statusCode.toString());
    // } catch (e) {
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     context.loaderOverlay.hide();
    //     notifyListeners();
    //   });
    //   print(e.toString());
    // }
  }
}
