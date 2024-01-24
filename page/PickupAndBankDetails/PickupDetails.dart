import 'package:awesome_select/awesome_select.dart';
import 'package:courier_app/logic/PickUpBankDetails/Provider.dart';
import 'package:courier_app/model/PickupModel/model.dart';
import 'package:courier_app/model/profile/model.dart';
import 'package:courier_app/page/PickupAndBankDetails/Provider/provider.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/widget/DropDown/dropdown.dart';
import 'package:courier_app/widget/FormField/formField.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:courier_app/widget/button/button.dart';
import 'package:courier_app/widget/logoWidget/Logo.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PickupDetails extends StatelessWidget {
  PickupDetails({
    super.key,
    this.id = 0,
    this.name,
    this.address,
    this.upazillaID,
    this.districtID,
    this.isUpdate = false,
    this.backToProfile = false,
  });

  final int id;
  final String? name;
  final int? districtID;
  final int? upazillaID;
  final String? address;
  final bool isUpdate;
  final bool backToProfile;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => PickupAndBankDetailsProvider()
              ..loadDistrictUpazilla(isUpdate, districtID)),
        ChangeNotifierProvider(
          create: (context) => StatePickupandBankDetailsProvider()
            ..initPickupPoint(
              id: id,
              name: name,
              districtID: districtID,
              upazillaID: upazillaID,
              address: address,
              isUpdate: isUpdate,
              backToProfile: backToProfile,
            ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title:
              isUpdate ? Text("পিক আপ পয়েন্ট পরিবর্তন") : Text("পিক আপ পয়েন্ট"),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 6.w,
            ),
            child: SingleChildScrollView(
              child: Consumer<PickupAndBankDetailsProvider>(
                  builder: (context, actionValue, child) {
                return Consumer<StatePickupandBankDetailsProvider>(
                    builder: (context, stateAction, child) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        LogoView(
                          height: 25,
                          width: 25,
                        ).animatedDisplay(
                          Duration(milliseconds: 300),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: BodyText(
                            text: "পিক আপ পয়েন্ট টাইটেল",
                            textAlign: TextAlign.left,
                            color: Colors.grey,
                          ).animatedDisplay(Duration(milliseconds: 500)),
                        ),
                        FormTextField(
                          controller: stateAction.nameController,
                          inputType: TextInputType.text,
                          maxLength: 30,
                          hintText: 'পিক আপ পয়েন্ট টাইটেল',
                          onChanage: (String value) {
                            Provider.of<StatePickupandBankDetailsProvider>(
                                    context,
                                    listen: false)
                                .btnEnableAction();
                          },
                        ).animatedDisplay(Duration(milliseconds: 850)),
                        SizedBox(
                          height: 2.h,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: BodyText(
                            text: "জেলা",
                            textAlign: TextAlign.left,
                            color: Colors.grey,
                          ).animatedDisplay(Duration(milliseconds: 500)),
                        ),
                        dropDownField(
                          width: double.infinity,
                          context,
                          data: S2Choice.listFrom<String, districtModel>(
                            source: actionValue.districtData,
                            value: (index, item) => item.idDistrict.toString(),
                            title: (index, item) => item.name.toString(),
                          ),
                          onChange: (String value) => Provider.of<
                                  StatePickupandBankDetailsProvider>(context,
                              listen: false)
                            ..onChangeDistrictAction(value.toString(), context),
                          placeholder: '',
                          selectItem: stateAction.districtItem,
                          title: 'জেলা নির্বাচন করুন',
                        ).animatedDisplay(Duration(milliseconds: 300)),
                        SizedBox(
                          height: 2.h,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: BodyText(
                            text: "এলাকা",
                            textAlign: TextAlign.left,
                            color: Colors.grey,
                          ).animatedDisplay(Duration(milliseconds: 500)),
                        ),
                        dropDownField(
                          width: double.infinity,
                          context,
                          data: S2Choice.listFrom<String, upazillaModel>(
                            source: actionValue.upazillaData,
                            value: (index, item) => item.upazillaID.toString(),
                            title: (index, item) => item.name.toString(),
                          ),
                          onChange: (String value) => Provider.of<
                                  StatePickupandBankDetailsProvider>(context,
                              listen: false)
                            ..onChangeUpazillaAction(value.toString(), context),
                          placeholder: '',
                          selectItem: stateAction.upazillaItem,
                          title: 'এলাকা নির্বাচন করুন',
                        ).animatedDisplay(Duration(milliseconds: 300)),
                        SizedBox(
                          height: 2.h,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: BodyText(
                            text: "বিস্তারিত ঠিকানা",
                            textAlign: TextAlign.left,
                            color: Colors.grey,
                          ).animatedDisplay(Duration(milliseconds: 500)),
                        ),
                        TextFormField(
                            minLines: 3,
                            onChanged: (value) {
                              Provider.of<StatePickupandBankDetailsProvider>(
                                      context,
                                      listen: false)
                                  .btnEnableAction();
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            controller: stateAction.addressController,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 15.sp),
                            decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              helperStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 5.sp, vertical: 8.sp),
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "বিস্তারিত ঠিকানা",
                            )).animatedDisplay(Duration(milliseconds: 300)),
                        SizedBox(
                          height: 3.h,
                        ),
                        ActionButton(
                          colorBg: Theme.of(context).colorScheme.primary,
                          width: 40,
                          height: 13,
                          btnEnable: stateAction.btnEnable,
                          onAction: () => Provider.of<
                                  PickupAndBankDetailsProvider>(context,
                              listen: false)
                            ..pickupDetailsSubmitAction(
                              context,
                              id: id,
                              name: stateAction.nameController.text,
                              districtId: int.parse(stateAction.districtItem),
                              upazillaId: int.parse(stateAction.upazillaItem),
                              address: stateAction.addressController.text,
                              lat: '',
                              lng: '',
                              backToProfile: backToProfile,
                            ),
                          child: BodyText(
                            text: "জমা দিন",
                            color: Color(0xFFffffff),
                          ),
                        ).animatedDisplay(Duration(milliseconds: 300))
                      ]);
                });
              }).fullSizedBox,
            ),
          ),
        ),
      ).loadingOverlay(context),
    );
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
