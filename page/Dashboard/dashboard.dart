import 'package:courier_app/logic/parcelProvider/provider.dart';
import 'package:courier_app/main.dart';
import 'package:courier_app/page/parcel/parcel.dart';
import 'package:courier_app/utility/extension.dart';
import 'package:courier_app/widget/BottomNav/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'Provider/Provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return ChangeNotifierProvider(
      create: (context) => dashboardProvider(),
      child: Builder(builder: (context) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
              statusBarColor: Theme.of(context).textTheme.bodyLarge!.color),
          child: Scaffold(
            body: Consumer<dashboardProvider>(
                builder: (context, stateAction, child) {
              return PageView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: stateAction.PageList.length,
                  itemBuilder: (context, index) =>
                      stateAction.PageList[stateAction.isSelectItem]);
            }),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Visibility(
              visible: !keyboardIsOpen,
              child: FloatingActionButton(
                onPressed: () {
                  Provider.of<ParcelProvider>(context, listen: false)
                    ..deliverySpeedAction(
                      context,
                      parcelType:
                          objectbox.getparcelType.first.parcelID.toString(),
                      upazilla:
                          objectbox.getsUpazilla.first.upazillaID.toString(),
                    );
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => ParcelCreateView(),
                    ),
                  );
                },
                child: Icon(
                  Icons.add,
                  size: 25.sp,
                  color: Colors.white,
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ).animate().scale(duration: Duration(milliseconds: 300)),
            ),
            bottomNavigationBar: BottomAppBar(
                notchMargin: 5.0.sp,
                shape: CircularNotchedRectangle(),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Consumer<dashboardProvider>(
                    builder: (context, stateAction, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: stateAction.menuItem
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.only(
                                left: e["isLeft"] != true ? e['padding'] : 0,
                                right: e["isLeft"] != false ? e['padding'] : 0,
                                top: 4.sp,
                                bottom: 5.sp),
                            child: NavContainer(
                              onAction: () => Provider.of<dashboardProvider>(
                                  context,
                                  listen: false)
                                ..onChangeMenuAction(e['id']),
                              icon: e['icon'],
                              isActive: stateAction.isSelectItem == e['id'],
                              lable: e['lable'],
                            ),
                          ).animatedDisplay(Duration(milliseconds: 200)),
                        )
                        .toList(),
                  );
                })),
          ),
        );
      }),
    );
  }
}
