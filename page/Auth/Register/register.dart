import 'package:courier_app/logic/RegisterProvider/provider.dart';
import 'package:courier_app/model/registerModel/model.dart';
import 'package:courier_app/page/Auth/Register/provider/provider.dart';
import 'package:courier_app/utility/enum.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/widget/FormField/formField.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:courier_app/widget/button/button.dart';
import 'package:courier_app/widget/logoWidget/Logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => REGISTERACTIONPROVIDER(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("আপনার প্রতিষ্ঠানকে নিবন্ধন করুন"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LogoView(
                    height: 25,
                    width: 25,
                  ).animatedDisplay(
                    Duration(milliseconds: 200),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Consumer<registerProvider>(
                      builder: (context, actionValue, child) {
                    return Consumer<REGISTERACTIONPROVIDER>(
                        builder: (context, registerAction, child) {
                      print(registerAction.errorType);
                      return Column(
                        children: [
                          FormTextField(
                            controller: actionValue.name,
                            hintText: "আপনার নাম লিখুন",
                            isIcon: true,
                            maxLength: 50,
                            inputType: TextInputType.text,
                            action: TextInputAction.next,
                            icon: Icon(
                              Icons.account_box_sharp,
                              size: 20.sp,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            onChanage: (String value) =>
                                Provider.of<registerProvider>(context,
                                    listen: false)
                                  ..onChangeAction(),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          FormTextField(
                            controller: actionValue.email,
                            hintText: "আপনার ইমেল ঠিকানা লিখুন",
                            isIcon: true,
                            maxLength: 50,
                            errorText: registerAction.errorType ==
                                    REGISTERERRORTYPE.Mail
                                ? "আপনার ইমেল ঠিকানা বিদ্যমান রয়েছে"
                                : null,
                            inputType: TextInputType.emailAddress,
                            action: TextInputAction.next,
                            icon: Icon(
                              Icons.email_outlined,
                              size: 20.sp,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            onChanage: (String value) =>
                                Provider.of<registerProvider>(context,
                                    listen: false)
                                  ..onChangeAction(),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          FormTextField(
                            controller: actionValue.business,
                            hintText: "আপনার প্রতিষ্ঠানের নাম লিখেন",
                            isIcon: true,
                            maxLength: 50,
                            errorText: registerAction.errorType ==
                                    REGISTERERRORTYPE.Business
                                ? "আপনার প্রতিষ্ঠানের নাম বিদ্যমান রয়েছে"
                                : null,
                            inputType: TextInputType.emailAddress,
                            action: TextInputAction.done,
                            icon: Icon(
                              Icons.business_sharp,
                              size: 20.sp,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            onChanage: (String value) =>
                                Provider.of<registerProvider>(context,
                                    listen: false)
                                  ..onChangeAction(),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          ActionButton(
                            btnEnable: actionValue.btnEnable,
                            onAction: () => Provider.of<REGISTERACTIONPROVIDER>(
                                context,
                                listen: false)
                              ..registerAction(context,
                                  data: registerTojson(
                                      name: actionValue.name.value.text,
                                      email: actionValue.email.value.text,
                                      phone: actionValue.phone,
                                      password: actionValue.password,
                                      company:
                                          actionValue.business.value.text)),
                            width: 40,
                            colorBg: Theme.of(context).colorScheme.primary,
                            height: 13,
                            child: BodyText(
                              text: "নিবন্ধন",
                              color: Color(0xFFffffff),
                            ),
                          ).animatedDisplay(Duration(milliseconds: 350)),
                        ],
                      );
                    });
                  })
                ],
              ).fullSizedBox,
            ),
          ),
        ),
      ).loadingOverlay(context),
    );
  }
}
