import 'package:courier_app/logic/LogoutProvider/provider.dart';
import 'package:courier_app/logic/ProfileProvider/provider.dart';
import 'package:courier_app/page/PickupAndBankDetails/PickupDetails.dart';
import 'package:courier_app/page/Profile/provider/provider.dart';
import 'package:courier_app/page/Profile/widgets/pickup_point_card.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/widget/FormField/formField.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:courier_app/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProfileProvider()
            ..loadPickupPoints(context)
            ..bankDetailsAction(context)
            ..nameGetAction(context),
        ),
        ChangeNotifierProvider(create: (context) => StateProfileProvider()),
        ChangeNotifierProvider(create: (context) => LogoutProvider())
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("মার্চেন্ট প্রোফাইল"),
          centerTitle: true,
        ),
        body: SafeArea(child:
            Consumer<ProfileProvider>(builder: (context, actionValue, child) {
          if (actionValue.isLoading) {
            return Container(
              color: Theme.of(context).backgroundColor,
            );
          } else {
            return Consumer<StateProfileProvider>(
                builder: (context, stateActionValue, child) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 20.w,
                          width: 20.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.w),
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer),
                          child: Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: Image.asset(
                              'assets/logo/logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ).animatedDisplay(Duration(milliseconds: 200)),
                      ),

                      // Start Information Update Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BodyText(
                            text: "মার্চেন্ট নাম",
                            fontsize: 12,
                            color: Colors.grey,
                          ).animatedDisplay(Duration(milliseconds: 200)),
                          if (actionValue.isEditeMode) ...[
                            FormTextField(
                              controller: actionValue.nameController,
                              hintText: 'আপনার নতুন নাম',
                              inputType: TextInputType.text,
                              maxLength: 255,
                              iconButton: IconButton(
                                onPressed: !stateActionValue.isBtnEnable
                                    ? null
                                    : () => Provider.of<ProfileProvider>(
                                        context,
                                        listen: false)
                                      ..nameChangeAction(context,
                                          actionValue.nameController.text),
                                icon: Icon(Icons.done),
                              ),
                              onChanage: (String value) =>
                                  Provider.of<StateProfileProvider>(context,
                                      listen: false)
                                    ..nameOnChangeAction(value),
                            ).animatedDisplay(Duration(milliseconds: 200)),
                          ] else ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BodyText(
                                  text: actionValue.name,
                                  fontsize: 15,
                                ),
                                GestureDetector(
                                  onTap: () => Provider.of<ProfileProvider>(
                                      context,
                                      listen: false)
                                    ..editeAction(actionValue.name),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ).animatedDisplay(Duration(milliseconds: 200)),
                          ],
                          SizedBox(
                            height: 10.w,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BodyText(
                                text: "পিক আপ পয়েন্ট",
                                fontsize: 12,
                                color: Colors.grey,
                              ).animatedDisplay(Duration(milliseconds: 200)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => PickupDetails(
                                        id: 0,
                                        name: '',
                                        address: '',
                                        isUpdate: false,
                                        districtID: 0,
                                        upazillaID: 0,
                                        backToProfile: true,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 24,
                                  alignment: Alignment.centerLeft,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          actionValue.pickupPoints.length > 0
                              ? SizedBox(
                                  width: double.infinity,
                                  height: 40.w,
                                  child: ListView.builder(
                                    itemCount: actionValue.pickupPoints.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        PickupPointCardWidget(
                                      stateAction: actionValue,
                                      index: index,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Text('No pickup point'),
                                ),
                          SizedBox(
                            height: 10.w,
                          ),
                          BodyText(
                            text: "মার্চেন্ট পেমেন্ট",
                            fontsize: 12,
                            color: Colors.grey,
                          ).animatedDisplay(Duration(milliseconds: 200)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (actionValue.bankDetails.selectedBankType ==
                                  "mobile_bank") ...[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BodyText(
                                      text:
                                          "${actionValue.bankDetails.bankName} ${actionValue.bankDetails.mobileBankAccountType}",
                                      fontsize: 13,
                                    ),
                                    if (actionValue.bankDetails.mobileNumber
                                        is String)
                                      BodyText(
                                        text:
                                            "01XXXXX${actionValue.bankDetails.mobileNumber.bankNumberFormate}",
                                        fontsize: 13,
                                      ),
                                  ],
                                ).animatedDisplay(Duration(milliseconds: 200)),
                              ],
                              if (actionValue.bankDetails.selectedBankType ==
                                  "normal_bank") ...[
                                BodyText(
                                  text: "${actionValue.bankDetails.bankName}",
                                  fontsize: 13,
                                ).animatedDisplay(Duration(milliseconds: 200)),
                                if (actionValue.bankDetails.mobileNumber
                                    is String)
                                  BodyText(
                                    text:
                                        "XXXXXXXXXX${actionValue.bankDetails.accountNumber.bankNumberFormate}",
                                    fontsize: 13,
                                  ).animatedDisplay(
                                      Duration(milliseconds: 200)),
                              ],
                            ],
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly, // Adjust as needed
                        children: [
                          ActionButton(
                            colorBg:
                                Theme.of(context).colorScheme.primaryContainer,
                            height: 10,
                            btnEnable: true,
                            onAction: () => Provider.of<LogoutProvider>(context,
                                listen: false)
                              ..logoutAction(context),
                            width: 25,
                            child: BodyText(text: "Logout"),
                          ),
                          SizedBox(width: 8), // Adjust spacing between buttons
                          ActionButton(
                            colorBg:
                                Theme.of(context).colorScheme.primaryContainer,
                            height: 10,
                            btnEnable: true,
                            onAction: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/", (route) => false);
                            },
                            width: 25,
                            child: Icon(Icons.home),
                          ),
                        ],
                      )
                    ],
                  ).fullSizedBox,
                ),
              );
            });
          }
        })),
      ).loadingOverlay(context),
    );
  }
}
