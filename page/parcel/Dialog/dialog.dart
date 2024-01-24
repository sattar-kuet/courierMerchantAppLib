import 'package:courier_app/logic/parcelProvider/provider.dart';
import 'package:courier_app/page/parcel/Dialog/Provider/provider.dart';
import 'package:courier_app/utility/enum.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/widget/DropDown/dropdown.dart';
import 'package:courier_app/widget/TextWidget/bodyText.dart';
import 'package:courier_app/widget/button/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ParcelProvider>(builder: (context, actionValue, child) {
      if (actionValue.customerGetLoading == CUSTOMERDATAGET.Loading) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Container(
                height: 40.h,
                width: 100.w,
              ),
            ),
          ),
        );
      } else if (actionValue.customerGetLoading == CUSTOMERDATAGET.Success) {
        return ChangeNotifierProvider(
          create: (context) => alertDialogProvider()
            ..initItemSelect(actionValue.customerInfo.first.id.toString()),
          child: Consumer<alertDialogProvider>(
              builder: (context, stateActionValue, child) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: Container(
                  height: 40.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20.sp)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Material(
                        child: DropDown(
                            value: stateActionValue.itemSelect,
                            data: actionValue.customerInfo,
                            items: iterableDrepdown(context,
                                itemData: actionValue.customerInfo),
                            onChangeAction: (value) =>
                                Provider.of<alertDialogProvider>(context,
                                    listen: false)
                                  ..onchangeAction(value.toString())),
                      ),
                      Material(
                        child: ActionButton(
                            child: BodyText(
                              text: "এগিয়ে যান",
                              color: Colors.white,
                            ),
                            onAction: () => Provider.of<alertDialogProvider>(
                                context,
                                listen: false)
                              ..selectAction(context, actionValue.customerInfo),
                            width: 8.w,
                            height: 3.w,
                            btnEnable: true,
                            colorBg: Theme.of(context).colorScheme.primary),
                      )
                    ],
                  ),
                ),
              ),
            )
                .animatedDisplay(Duration(milliseconds: 300),
                    offset: Offset(0.0, .05))
                .loadingOverlay(context);
          }),
        );
      } else {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Container(
              height: 40.h,
              width: 100.w,
            ),
          ),
        );
      }
    });
  }
}
