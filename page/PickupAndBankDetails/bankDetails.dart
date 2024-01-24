import 'package:awesome_select/awesome_select.dart';
import 'package:courier_app/logic/PickUpBankDetails/Provider.dart';
import 'package:courier_app/model/BankModel/model.dart';
import 'package:courier_app/page/PickupAndBankDetails/Provider/provider.dart';
import 'package:courier_app/utility/enum.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/widget/DropDown/dropdown.dart';
import 'package:courier_app/widget/FormField/formField.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:courier_app/widget/button/button.dart';
import 'package:courier_app/widget/logoWidget/Logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({super.key});

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  @override
  void didChangeDependencies() {
    Provider.of<StatePickupandBankDetailsProvider>(context, listen: false)
      ..clear();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              PickupAndBankDetailsProvider()..bankDetailsAction(context),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
            title: Text(
          "ব্যাংক তথ্য",
        )),
        body: Consumer<PickupAndBankDetailsProvider>(
            builder: (context, actionValue, child) {
          return SafeArea(child: SingleChildScrollView(
            child: Consumer<StatePickupandBankDetailsProvider>(
                builder: (context, stateAction, child) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    LogoView(
                      height: 22,
                      width: 22,
                    ).animatedDisplay(Duration(milliseconds: 200)),
                    SizedBox(
                      height: 10.h,
                    ),
                    dropDownField(
                      context,
                      data: S2Choice.listFrom<String, BankDetailsModel>(
                        source: actionValue.bankData,
                        value: (index, item) => item.id.toString(),
                        title: (index, item) => item.name.toString(),
                      ),
                      onChange: (String value) =>
                          Provider.of<StatePickupandBankDetailsProvider>(
                              context,
                              listen: false)
                            ..onChangeBankAction(
                              value.toString(),
                              bankData: actionValue.bankData,
                            ),
                      placeholder: '',
                      selectItem: stateAction.bankItem,
                      title: 'ব্যাংক নির্বাচন করুন',
                    ).animatedDisplay(Duration(milliseconds: 250)),
                    SizedBox(
                      height: 2.5.h,
                    ),
                    if (stateAction.bankingStatus ==
                        BNAKDETAILSSTATUS.mobile) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: FormTextField(
                          maxLength: 11,
                          controller: stateAction.phoneController,
                          hintText: 'মোবাইল নাম্বার লিখুন',
                          onChanage: (String value) =>
                              Provider.of<StatePickupandBankDetailsProvider>(
                                      context,
                                      listen: false)
                                  .bankOnChangeAction(value),
                        ),
                      ).animatedDisplay(Duration(milliseconds: 300)),
                      SizedBox(
                        height: 2.5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: MOBILEBANKSTATUS.personal,
                                  groupValue: stateAction.bankingType,
                                  onChanged: (MOBILEBANKSTATUS? value) =>
                                      Provider.of<
                                              StatePickupandBankDetailsProvider>(
                                          context,
                                          listen: false)
                                        ..radioOnchangeAction(
                                            value as MOBILEBANKSTATUS),
                                ),
                                BodyText(text: "Personal")
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: MOBILEBANKSTATUS.agent,
                                  groupValue: stateAction.bankingType,
                                  onChanged: (MOBILEBANKSTATUS? value) =>
                                      Provider.of<
                                              StatePickupandBankDetailsProvider>(
                                          context,
                                          listen: false)
                                        ..radioOnchangeAction(
                                            value as MOBILEBANKSTATUS),
                                ),
                                BodyText(text: "Agent")
                              ],
                            )
                          ],
                        ),
                      ).animatedDisplay(Duration(milliseconds: 350)),
                      SizedBox(
                        height: 10.h,
                      ),
                      ActionButton(
                        btnEnable: stateAction.bankBtnEnable,
                        onAction: () =>
                            Provider.of<PickupAndBankDetailsProvider>(
                          context,
                          listen: false,
                        )..mobileOnSubmitAction(
                                context,
                                phone: stateAction.phoneController.value.text,
                                bankId: int.parse(stateAction.bankItem),
                                type: stateAction.bankingType ==
                                        MOBILEBANKSTATUS.personal
                                    ? "personal"
                                    : "agent",
                              ),
                        width: 40,
                        colorBg: Theme.of(context).colorScheme.primary,
                        height: 13,
                        child: BodyText(
                          text: "জমা দিন",
                          color: Color(0xFFffffff),
                        ).animatedDisplay(Duration(milliseconds: 400)),
                      ),
                    ] else if (stateAction.bankingStatus ==
                        BNAKDETAILSSTATUS.bank) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: FormTextField(
                          maxLength: 11,
                          inputType: TextInputType.name,
                          controller: stateAction.branch,
                          hintText: 'ব্যাংকের শাখা',
                          onChanage: (String value) =>
                              Provider.of<StatePickupandBankDetailsProvider>(
                                      context,
                                      listen: false)
                                  .onchangeBranch(),
                        ).animatedDisplay(Duration(milliseconds: 300)),
                      ),
                      SizedBox(
                        height: 2.5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: FormTextField(
                          maxLength: 11,
                          inputType: TextInputType.name,
                          controller: stateAction.accountName,
                          hintText: 'হিসাবের নাম',
                          onChanage: (String value) =>
                              Provider.of<StatePickupandBankDetailsProvider>(
                                      context,
                                      listen: false)
                                  .onchangeAccountName(),
                        ).animatedDisplay(Duration(milliseconds: 350)),
                      ),
                      SizedBox(
                        height: 2.5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: FormTextField(
                          maxLength: 11,
                          controller: stateAction.accountNumber,
                          inputType: TextInputType.text,
                          hintText: 'হিসাব নাম্বার',
                          onChanage: (String value) =>
                              Provider.of<StatePickupandBankDetailsProvider>(
                                      context,
                                      listen: false)
                                  .onchangeAccountNumber(),
                        ).animatedDisplay(Duration(milliseconds: 400)),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ActionButton(
                        btnEnable: stateAction.bankBtnEnable,
                        onAction: () =>
                            Provider.of<PickupAndBankDetailsProvider>(
                          context,
                          listen: false,
                        )..bankOnSubmitAction(context,
                                accountName: stateAction.accountName.value.text,
                                accountNumber:
                                    stateAction.accountNumber.value.text,
                                branch: stateAction.branch.value.text,
                                bank: int.parse(stateAction.bankItem)),
                        width: 40,
                        colorBg: Theme.of(context).colorScheme.primary,
                        height: 13,
                        child: BodyText(
                          text: "জমা দিন",
                          color: Color(0xFFffffff),
                        ),
                      ).animatedDisplay(Duration(milliseconds: 450)),
                    ]
                  ],
                ).fullSizedBox,
              );
            }),
          ));
        }),
      ).loadingOverlay(context),
    );
  }
}
