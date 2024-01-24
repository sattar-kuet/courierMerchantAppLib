import 'package:courier_app/logic/PhoneVerifyProvider/provider.dart';
import 'package:courier_app/page/Auth/PhoneVerification/Provider/Provider.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/widget/FormField/formField.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:courier_app/widget/button/button.dart';
import 'package:courier_app/widget/logoWidget/Logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PhoneVerify extends StatelessWidget {
  PhoneVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PHONENUMBERVERIFYPROVIDER(),
        ),
        ChangeNotifierProvider(
          create: (context) => PhoneVerifyActionProvider(),
        ),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).textTheme.bodyLarge!.color),
        child: Scaffold(body: Consumer<PHONENUMBERVERIFYPROVIDER>(
            builder: (context, verifyStatus, child) {
          return SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Phone Number Verify Logo with titile Section Start
                Column(
                  children: [
                    LogoView(
                      height: 22,
                      width: 22,
                    ).animatedDisplay(Duration(milliseconds: 200)),
                    SizedBox(
                      height: 3.h,
                    ),
                    BodyText(
                      text: "আপনার ফোন নাম্বার যাচাই করুন",
                    ).animatedDisplay(Duration(milliseconds: 250)),
                  ],
                ),
                //  Phone Verify Input Field with Button Secation start
                SizedBox(
                  height: 5.h,
                ),
                Consumer<PhoneVerifyActionProvider>(
                    builder: (context, action, child) {
                  return Column(
                    children: [
                      FormTextField(
                        controller: action.controller,
                        onChanage: (value) =>
                            Provider.of<PhoneVerifyActionProvider>(
                          context,
                          listen: false,
                        ).onChange(value),
                        hintText: "1XXXXXXXXX",
                        prefix: BodyText(
                          text: "880 ",
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ).animatedDisplay(Duration(milliseconds: 300)),
                      SizedBox(
                        height: 5.h,
                      ),
                      ActionButton(
                        btnEnable: action.btnEnable,
                        onAction: () => Provider.of<PhoneVerifyActionProvider>(
                          context,
                          listen: false,
                        )..verifyAction(context),
                        width: 40,
                        colorBg: Theme.of(context).colorScheme.primary,
                        height: 13,
                        child: BodyText(
                          text: "পরবর্তী",
                          color: Color(0xFFffffff),
                        ),
                      ).animatedDisplay(Duration(milliseconds: 350)),
                    ],
                  );
                }),
              ],
            ),
          )).fullSizedBox;
        })).loadingOverlay(context),
      ),
    );
  }
}
