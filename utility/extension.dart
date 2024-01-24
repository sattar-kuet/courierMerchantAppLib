import 'dart:convert';
import 'package:courier_app/logic/ParcelDetailsProvider/provider.dart';
import 'package:courier_app/model/parcelModel/getCustomerModel.dart';
import 'package:courier_app/model/BankModel/model.dart';
import 'package:courier_app/model/PickupModel/model.dart';
import 'package:courier_app/model/parcelModel/parcelType.dart';
import 'package:courier_app/utility/enum.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

extension ThirdPartyPckageImplements on Widget {
  Widget get fullSizedBox {
    return SizedBox(
      width: 100.w,
      height: 100.h,
      child: this,
    );
  }

  Widget animatedDisplay(Duration duration, {Offset? offset}) {
    return DelayedDisplay(
      child: this,
      slidingBeginOffset: offset ?? Offset(0.0, 0.35),
      delay: duration,
    );
  }

  Widget loadingOverlay(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: SpinKitChasingDots(
          color: Theme.of(context).primaryColor,
          size: 50.0,
        ),
      ),
      child: this,
    );
  }

  Widget otpVerifyField(
      {required TextEditingController controller,
      required Function(String value) onChange,
      required Function(String value) onCompleted,
      required BuildContext context}) {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      autoFocus: true,
      animationType: AnimationType.fade,
      textStyle: Theme.of(context).textTheme.bodyText1,
      cursorColor: Theme.of(context).primaryColor,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 10.w,
          fieldWidth: 10.w,
          activeFillColor: Colors.transparent,
          inactiveColor: Theme.of(context).splashColor,
          inactiveFillColor: Colors.transparent,
          selectedFillColor: Colors.transparent),
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: controller,
      onCompleted: onCompleted,
      onChanged: onChange,
      appContext: context,
    );
  }

  Widget deliveryTracking(BuildContext context,
      {required int i, required ParcelDetailsProvider actionValue}) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      indicatorStyle: IndicatorStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
      afterLineStyle: LineStyle(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      beforeLineStyle: LineStyle(
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      lineXY: 0.25,
      isFirst: i == 0 ? true : false,
      isLast:
          i == actionValue.parcelDetails!.tracking!.length - 1 ? true : false,
      endChild: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.sp),
        alignment: Alignment.centerLeft,
        constraints: BoxConstraints(
          minHeight: 10.h,
        ),
        child: Text(
          actionValue.parcelDetails!.tracking![i].message.toString(),
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      startChild: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              actionValue.parcelDetails!.tracking![i].date.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 10.sp, color: Colors.grey),
            ),
            Text(
              actionValue.parcelDetails!.tracking![i].time.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 10.sp, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

extension httpJson on dynamic {
  int get statusCheck {
    return json.decode(this)['result']['status'];
  }

  REGISTERERRORTYPE get registerErrorType {
    var _errorData =
        (json.decode(this)['result']['error'] as String).split(" ")[0];
    switch (_errorData) {
      case "Company":
        return REGISTERERRORTYPE.Business;
      case "Email":
        return REGISTERERRORTYPE.Mail;
      default:
        return REGISTERERRORTYPE.None;
    }
  }

  String get cookieFilter {
    // filter Response Header Cookie
    return ((this as String).split(';')[0]).split("=")[1];
  }

  int get uidFilter {
    return json.decode(this)['result']['uid'];
  }

  bool get pickupBankStatus {
    return json.decode(this)['result']['data'];
  }

  List<districtModel> get district {
    return (json.decode(this)['result']['data'] as List)
        .map((e) => districtModel.fromJson(e))
        .toList();
  }

  List<districtModel> get districts {
    return (json.decode(this)['result']['data'] as List)
        .map((e) => districtModel(id: 0, idDistrict: e['id'], name: e['name']))
        .toList();
  }

  List<upazillaModel> get upazillas {
    return (json.decode(this)['result']['data'] as List)
        .map((e) => upazillaModel(
            id: 0,
            upazillaID: e['id'],
            districtId: e['district_id'],
            name: e['name']))
        .toList();
  }

  List<parcelTypeModel> get parceltype {
    return (json.decode(this)['result']['data'] as List)
        .map((e) => parcelTypeModel(
            id: 0, parcelID: e['id'], parcelType: e['parcel_type']))
        .toList();
  }

  // List<deliverySpeedModel> get deliveryspeed {
  //   return (json.decode(this)['result']['data'] as List)
  //       .map((e) =>
  //           deliverySpeedModel(id: 0, idspeed: e['id'], label: e['label']))
  //       .toList();
  // }

  List<BankDetailsModel> get banksData {
    return (json.decode(this)['result']['data'] as List)
        .map((e) => BankDetailsModel.fromJson(e))
        .toList();
  }

  dynamic get getCustomer {
    final data = json.decode(this)['result']['data'] as List;
    if (data.isNotEmpty) {
      return [
        CUSTOMHASDATA.Has,
        data.map((e) => getCustomerModel.fromJson(e)).toList(),
      ];
    } else {
      return [CUSTOMHASDATA.Not];
    }
  }
}

extension CustomLogic on dynamic {
  List<DropdownMenuItem<String>> iterableDrepdown(BuildContext context,
      {required List<getCustomerModel> itemData}) {
    List<DropdownMenuItem<String>> items = [];

    for (var i = 0; i <= itemData.length; i++) {
      if (i < itemData.length) {
        items.add(DropdownMenuItem<String>(
          value: itemData[i].id.toString(),
          child: Text(itemData[i].address.toString()),
        ));
      }
      if (i == itemData.length) {
        items.add(DropdownMenuItem<String>(
          value: "custom",
          child: Text("Add New Address"),
        ));
      }
    }
    return items;
  }

  bool get customerStatus {
    return this != null;
  }

  String get startDateTime {
    DateTime now = DateTime.now();
    Duration duration = Duration(days: int.parse(this));
    DateTime endDate = now.subtract(duration);
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(endDate);
  }

  String get customDateTime {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(this);
  }

  String get endDateTime {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }

  Uint8List get memoryImage {
    return base64Decode(this);
  }

  int get parcelCashLength {
    return int.parse(
      this.parcelDetails!.cash!.length.toString(),
    );
  }

  String get deliveryArea {
    List listdata = this.parcelDetails!.customer!.address.toString().split(',');
    return listdata[listdata.length - 2].toString().trim();
  }

  String get fullProfileAddress {
    return "${this.profileaddress.address} ${this.profileaddress.upazilla} ${this.profileaddress.district}";
  }

  String get bankNumberFormate {
    final data = this.split('');
    return "${data[data.length - 4]}${data[data.length - 3]}${data[data.length - 2]}${data[data.length - 1]}";
  }
}
