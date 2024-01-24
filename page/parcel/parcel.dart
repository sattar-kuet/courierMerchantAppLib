import 'package:awesome_select/awesome_select.dart';
import 'package:courier_app/logic/parcelProvider/provider.dart';
import 'package:courier_app/model/PickupModel/model.dart';
import 'package:courier_app/model/parcelModel/deliveySpeed.dart';
import 'package:courier_app/model/parcelModel/parcelType.dart';
import 'package:courier_app/model/profile/model.dart';
import 'package:courier_app/page/parcel/provider/provider.dart';
import 'package:courier_app/utility/enum.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/widget/DropDown/dropdown.dart';
import 'package:courier_app/widget/FormField/formField.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:courier_app/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ParcelCreateView extends StatefulWidget {
  const ParcelCreateView({super.key});

  @override
  State<ParcelCreateView> createState() => _ParcelCreateViewState();
}

class _ParcelCreateViewState extends State<ParcelCreateView> {
  @override
  void didChangeDependencies() {
    Provider.of<StatePracelProvider>(context, listen: false)..close();
    Provider.of<ParcelProvider>(context, listen: false)..close();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ParcelProvider()..loadInitialData(context),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title:
              Consumer<ParcelProvider>(builder: (context, actionValue, child) {
            return Consumer<StatePracelProvider>(
                builder: (context, stateActionValue, child) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BodyText(
                        text: "ডেলিভারি ফি",
                        fontsize: 7.sp,
                        color: Colors.white70,
                      ),
                      BodyText(
                        text: "৳" + stateActionValue.deliveryfees.toString(),
                        fontsize: 8.sp,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BodyText(
                        text: "COD ফি",
                        fontsize: 7.sp,
                        color: Colors.white70,
                      ),
                      BodyText(
                        text: "৳" + actionValue.cashFees.toString(),
                        fontsize: 8.sp,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BodyText(
                        text: "মোট ফি",
                        fontsize: 7.sp,
                        color: Colors.white70,
                      ),
                      BodyText(
                        text: actionValue.deliveryFessshow == true
                            ? "৳${actionValue.cashFees + stateActionValue.deliveryfees}"
                            : "৳0.0",
                        fontsize: 8.sp,
                        color: Colors.white,
                      )
                    ],
                  )
                ],
              ).animatedDisplay(Duration(milliseconds: 250));
            });
          }),
        ),
        body: Consumer<ParcelProvider>(builder: (context, actionValue, child) {
          return Consumer<StatePracelProvider>(
              builder: (context, stateActionValue, child) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.5.h,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: BodyText(
                          text: "পিক আপ পয়েন্ট",
                          textAlign: TextAlign.left,
                          color: Colors.grey,
                        ),
                      ).animatedDisplay(Duration(milliseconds: 300)),
                      dropDownField(
                        context,
                        width: 100.w,
                        data: S2Choice.listFrom<String, PickupPointModel>(
                          source: actionValue.pickupPoint,
                          value: (index, item) => item.id.toString(),
                          title: (index, item) => item.title.toString(),
                        ),
                        onChange: (String value) =>
                            Provider.of<StatePracelProvider>(context,
                                listen: false)
                              ..pickupPointOnChanageAction(
                                  context, value.toString()),
                        placeholder: '',
                        selectItem: stateActionValue.pickupPointId,
                        title: 'পিক আপ পয়েন্ট নির্বাচন করুন',
                      ).animatedDisplay(Duration(milliseconds: 400)),
                      SizedBox(
                        height: 20.sp,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: BodyText(
                          text: "কাস্টমার ফোন নম্বর",
                          textAlign: TextAlign.left,
                          color: Colors.grey,
                        ),
                      ).animatedDisplay(Duration(milliseconds: 300)),
                      FormTextField(
                        controller: stateActionValue.phoneController,
                        hintText: 'কাস্টমার ফোন নম্বর লিখুন',
                        prefix: BodyText(
                          text: "880 ",
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                        //   iconButton: stateActionValue.searchBtnEnable
                        //       ? IconButton(
                        //           onPressed: () => Provider.of<ParcelProvider>(
                        //               context,
                        //               listen: false)
                        //             ..customeNumberSearchAction(
                        //                 context,
                        //                 "880" +
                        //                     stateActionValue
                        //                         .phoneController.value.text),
                        //           icon: Icon(Icons.arrow_circle_right),
                        //           iconSize: 25.sp,
                        //         )
                        //       : null,
                        onChanage: (String value) =>
                            Provider.of<StatePracelProvider>(context,
                                listen: false)
                              ..onChangeAction(value),
                      ).animatedDisplay(Duration(milliseconds: 250)),
                      // if (stateActionValue.isForShow ) ...[
                      //   // Customer Info Secation Start

                      Column(
                        children: [
                          SizedBox(
                            height: 20.sp,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: BodyText(
                              text: "কাস্টমারের নাম",
                              textAlign: TextAlign.left,
                              color: Colors.grey,
                            ),
                          ).animatedDisplay(Duration(milliseconds: 300)),
                          SizedBox(
                            height: 1.h,
                          ),
                          FormTextField(
                            controller: stateActionValue.name,
                            hintText: 'কাস্টমারের নাম লিখুন',
                            maxLength: 200,
                            inputType: TextInputType.text,
                            onChanage: (String value) {
                              Provider.of<StatePracelProvider>(context,
                                      listen: false)
                                  .btnValidatorAction();
                            },
                          ).animatedDisplay(Duration(milliseconds: 350)),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: BodyText(
                              text: "কাস্টমারের জেলা",
                              textAlign: TextAlign.left,
                              color: Colors.grey,
                            ),
                          ).animatedDisplay(Duration(milliseconds: 300)),
                          dropDownField(
                            context,
                            width: 100.w,
                            data: S2Choice.listFrom<String, districtModel>(
                              source: actionValue.district,
                              value: (index, item) =>
                                  item.idDistrict.toString(),
                              title: (index, item) => item.name.toString(),
                            ),
                            onChange: (String value) =>
                                Provider.of<StatePracelProvider>(context,
                                    listen: false)
                                  ..districtOnChanageAction(
                                      context, value.toString()),
                            placeholder: '',
                            selectItem: stateActionValue.districtItem,
                            title: 'জেলা নির্বাচন করুন',
                          ).animatedDisplay(Duration(milliseconds: 400)),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: BodyText(
                              text: "কাস্টমারের এলাকা",
                              textAlign: TextAlign.left,
                              color: Colors.grey,
                            ),
                          ).animatedDisplay(Duration(milliseconds: 300)),
                          dropDownField(
                            context,
                            width: 100.w,
                            data: S2Choice.listFrom<String, upazillaModel>(
                              source: actionValue.upazilla,
                              value: (index, item) =>
                                  item.upazillaID.toString(),
                              title: (index, item) => item.name.toString(),
                            ),
                            onChange: (String value) =>
                                Provider.of<StatePracelProvider>(context,
                                    listen: false)
                                  ..upazillaOnchangeAction(
                                      context, value.toString()),
                            placeholder: '',
                            selectItem: stateActionValue.upazillaItem,
                            title: 'এলাকা নির্বাচন করুন',
                          ).animatedDisplay(Duration(milliseconds: 450)),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: BodyText(
                              text: "কাস্টমারের ঠিকানা",
                              textAlign: TextAlign.left,
                              color: Colors.grey,
                            ),
                          ).animatedDisplay(Duration(milliseconds: 300)),
                          FormTextField(
                            controller: stateActionValue.address,
                            hintText: 'কাস্টমারের ঠিকানা',
                            maxLength: 200,
                            inputType: TextInputType.text,
                            onChanage: (String value) {
                              Provider.of<StatePracelProvider>(context,
                                      listen: false)
                                  .btnValidatorAction();
                            },
                          ).animatedDisplay(Duration(milliseconds: 450)),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 20.sp,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: BodyText(
                              text: "পার্সেল এর ধরন",
                              textAlign: TextAlign.left,
                              color: Colors.grey,
                            ).animatedDisplay(Duration(milliseconds: 500)),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          dropDownField(
                            context,
                            width: 100.w,
                            data: S2Choice.listFrom<String, parcelTypeModel>(
                              source: actionValue.parcelType,
                              value: (index, item) => item.parcelID.toString(),
                              title: (index, item) =>
                                  item.parcelType.toString(),
                            ),
                            onChange: (String value) =>
                                Provider.of<StatePracelProvider>(context,
                                    listen: false)
                                  ..parcelTypeOnChange(
                                    context,
                                    value.toString(),
                                  ),
                            placeholder: '',
                            selectItem: stateActionValue.parcelTypeItem,
                            title: 'পার্সেল ধরন নির্বাচন করুন',
                          ).animatedDisplay(Duration(milliseconds: 550)),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: BodyText(
                              text: "ডেলিভারির ধরন",
                              textAlign: TextAlign.left,
                              color: Colors.grey,
                            ).animatedDisplay(Duration(milliseconds: 500)),
                          ),
                          dropDownField(
                            context,
                            width: 100.w,
                            data: S2Choice.listFrom<String, deliverySpeedModel>(
                              source: actionValue.deliverySpeed,
                              value: (index, item) => item.idspeed.toString(),
                              title: (index, item) => item.label.toString(),
                            ),
                            onChange: (String value) =>
                                Provider.of<StatePracelProvider>(context,
                                    listen: false)
                                  ..deliverySpeedItemAction(
                                    value.toString(),
                                  ),
                            placeholder: '',
                            selectItem: stateActionValue.deliverySpeedItem,
                            title: 'ডেলিভারির ধরন নির্বাচন করুন',
                          ).animatedDisplay(Duration(milliseconds: 600)),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: stateActionValue.paymentType,
                                    groupValue: PARCELPAYMENTYPE.paid,
                                    onChanged: (value) =>
                                        Provider.of<StatePracelProvider>(
                                                context,
                                                listen: false)
                                            .paymentTypeOnChange(
                                                context, PARCELPAYMENTYPE.paid),
                                  ),
                                  BodyText(
                                    text: "Zero Condition",
                                    fontsize: 8.sp,
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: stateActionValue.paymentType,
                                    groupValue: PARCELPAYMENTYPE.cash,
                                    onChanged: (value) =>
                                        Provider.of<StatePracelProvider>(
                                                context,
                                                listen: false)
                                            .paymentTypeOnChange(
                                                context, PARCELPAYMENTYPE.cash),
                                  ),
                                  BodyText(
                                    text: "Cash Collection",
                                    fontsize: 8.sp,
                                  )
                                ],
                              )
                            ],
                          ).animatedDisplay(Duration(milliseconds: 650)),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          if (stateActionValue.paymentType ==
                              PARCELPAYMENTYPE.cash)
                            Align(
                              alignment: Alignment.topLeft,
                              child: BodyText(
                                text: "নগদ সংগ্রহ",
                                textAlign: TextAlign.left,
                                color: Colors.grey,
                              ).animatedDisplay(Duration(milliseconds: 500)),
                            ),
                          if (stateActionValue.paymentType ==
                              PARCELPAYMENTYPE.cash)
                            FormTextField(
                              controller:
                                  stateActionValue.cashCollectionController,
                              hintText: 'নগদ সংগ্রহ',
                              action: TextInputAction.done,
                              onChanage: (String value) {
                                if (value.length > 0) {
                                  Provider.of<ParcelProvider>(context,
                                      listen: false)
                                    ..cashCollectionAction(
                                        value, stateActionValue.upazillaItem);
                                }
                                Provider.of<StatePracelProvider>(context,
                                        listen: false)
                                    .btnValidatorAction();
                              },
                            ).animatedDisplay(Duration(milliseconds: 700)),
                          if (stateActionValue.paymentType ==
                              PARCELPAYMENTYPE.cash)
                            SizedBox(
                              height: 2.5.h,
                            ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: BodyText(
                              text: "ওজন (KG)",
                              textAlign: TextAlign.left,
                              color: Colors.grey,
                            ).animatedDisplay(Duration(milliseconds: 500)),
                          ),
                          FormTextField(
                            controller: stateActionValue.parcelWeightController,
                            hintText: 'ওজন (KG)',
                            onChanage: (String value) {
                              Provider.of<StatePracelProvider>(context,
                                  listen: false)
                                ..deliveryfessAction();
                              Provider.of<StatePracelProvider>(context,
                                      listen: false)
                                  .btnValidatorAction();
                            },
                          ).animatedDisplay(Duration(milliseconds: 750)),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: BodyText(
                              text: "পণ্যের আসল দাম",
                              textAlign: TextAlign.left,
                              color: Colors.grey,
                            ).animatedDisplay(Duration(milliseconds: 500)),
                          ),
                          FormTextField(
                            controller: stateActionValue.productPriceController,
                            hintText: 'পণ্যের আসল দাম',
                            onChanage: (String value) {
                              Provider.of<StatePracelProvider>(context,
                                      listen: false)
                                  .btnValidatorAction();
                            },
                          ).animatedDisplay(Duration(milliseconds: 800)),
                          Row(
                            children: [
                              Checkbox(
                                value: stateActionValue.exchange,
                                onChanged: (bool? value) =>
                                    Provider.of<StatePracelProvider>(context,
                                        listen: false)
                                      ..onExchangeAction(value as bool),
                              ),
                              BodyText(text: "exchange")
                            ],
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: BodyText(
                              text: "মার্চেন্ট ইনভয়েস নাম্বার",
                              textAlign: TextAlign.left,
                              color: Colors.grey,
                            ).animatedDisplay(Duration(milliseconds: 500)),
                          ),
                          FormTextField(
                            controller: stateActionValue.trakingIDController,
                            inputType: TextInputType.text,
                            hintText: 'মার্চেন্ট ইনভয়েস নাম্বার',
                            onChanage: (String value) {
                              Provider.of<StatePracelProvider>(context,
                                      listen: false)
                                  .btnValidatorAction();
                            },
                          ).animatedDisplay(Duration(milliseconds: 850)),
                          SizedBox(
                            height: 2.5.h,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: BodyText(
                              text: "পার্সেল নোট",
                              textAlign: TextAlign.left,
                              color: Colors.grey,
                            ).animatedDisplay(Duration(milliseconds: 500)),
                          ),
                          SizedBox(
                            width: 100.w,
                            child: TextFormField(
                                minLines: 6,
                                onChanged: (value) {
                                  Provider.of<StatePracelProvider>(context,
                                          listen: false)
                                      .btnValidatorAction();
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: 6,
                                controller: stateActionValue.noteController,
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
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "পার্সেল নোট",
                                )),
                          ).animatedDisplay(Duration(milliseconds: 900)),
                          SizedBox(
                            height: 3.h,
                          ),
                          ActionButton(
                            btnEnable: stateActionValue.btnEnable,
                            onAction: () => Provider.of<ParcelProvider>(context,
                                listen: false)
                              ..registerParcelAction(context,
                                  pickupPointId: stateActionValue.pickupPointId,
                                  exchange: stateActionValue.exchange,
                                  number: stateActionValue.phoneController.text,
                                  name: stateActionValue.name.text,
                                  district: stateActionValue.districtItem,
                                  upazilla: stateActionValue.upazillaItem,
                                  address: stateActionValue.address.text,
                                  typeid: stateActionValue.parcelTypeItem,
                                  deliverySpeed: stateActionValue
                                      .deliverySpeedItem,
                                  actualPrice: stateActionValue
                                      .productPriceController.text,
                                  cash:
                                      stateActionValue.cashCollectionController
                                              .text.isNotEmpty
                                          ? stateActionValue
                                              .cashCollectionController.text
                                          : "0",
                                  weight:
                                      stateActionValue
                                          .parcelWeightController.text,
                                  merchantReference:
                                      stateActionValue.trakingIDController.text,
                                  note: stateActionValue.noteController.text),
                            width: 45,
                            colorBg: Theme.of(context).colorScheme.primary,
                            height: 13,
                            child: BodyText(
                              text: "Submit",
                              color: Color(0xFFffffff),
                            ),
                          ).animatedDisplay(Duration(milliseconds: 950)),
                          SizedBox(
                            height: 10.sp,
                          )
                        ],
                      )
                    ],
                    // ],
                  ),
                ),
              ),
            );
          });
        }),
      ).loadingOverlay(context),
    );
  }
}
