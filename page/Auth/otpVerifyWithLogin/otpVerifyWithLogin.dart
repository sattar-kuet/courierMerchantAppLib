import 'package:courier_app/page/Auth/otpVerifyWithLogin/Provider/provider.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:courier_app/widget/button/button.dart';
import 'package:courier_app/widget/logoWidget/Logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OtpVerifyWithLogin extends StatelessWidget {
  const OtpVerifyWithLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("কোড ভেরিফিকেশন")),
      body: SafeArea(child:
          Consumer<OtpLoginProvider>(builder: (context, actionValue, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  LogoView(
                    height: 22,
                    width: 22,
                  ).animatedDisplay(Duration(milliseconds: 200)),
                  SizedBox(
                    height: 3.h,
                  ),
                  SizedBox(
                    width: 70.w,
                    child: Text(
                      " অনুগ্রহ করে আপনি এই " +
                          actionValue.phone.toString() +
                          " ফোন নাম্বারটি চেক করুন",
                      textAlign: TextAlign.center,
                    ),
                  ).animatedDisplay(Duration(milliseconds: 250))
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Column(
                children: [
                  otpVerifyField(
                    context: context,
                    controller: TextEditingController(),
                    onChange: (value) =>
                        Provider.of<OtpLoginProvider>(context, listen: false)
                          ..onChangeAction(value),
                    onCompleted: (value) {},
                  ).animatedDisplay(Duration(milliseconds: 300)),
                  SizedBox(
                    height: 5.h,
                  ),
                  ActionButton(
                    btnEnable: actionValue.btnEnable,
                    onAction: () =>
                        Provider.of<OtpLoginProvider>(context, listen: false)
                          ..otpAction(context),
                    width: 40,
                    colorBg: Theme.of(context).colorScheme.primary,
                    height: 13,
                    child: BodyText(
                      text: "যাচাই",
                      color: Color(0xFFffffff),
                    ),
                  ).animatedDisplay(
                    Duration(milliseconds: 350),
                  ),
                ],
              )
            ],
          ),
        );
      })).fullSizedBox,
    ).loadingOverlay(context);
  }
}
