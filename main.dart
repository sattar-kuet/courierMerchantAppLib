import 'package:courier_app/logic/HomeProvider/provider.dart';
import 'package:courier_app/logic/LoginProvider/provider.dart';
import 'package:courier_app/logic/ParcelListProvider/provider.dart';
import 'package:courier_app/logic/ProfileProvider/provider.dart';
import 'package:courier_app/logic/SearchProvider/provider.dart';
import 'package:courier_app/page/PickupAndBankDetails/Provider/provider.dart';
import 'package:courier_app/page/parcel/provider/provider.dart';
import 'package:courier_app/router/router.dart';
import 'package:courier_app/utility/config.dart';
import 'package:courier_app/utility/localStore.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'logic/parcelProvider/provider.dart';
import 'page/Auth/Register/provider/provider.dart';
import 'page/Auth/otpVerifyWithLogin/Provider/provider.dart';

late LocalStore objectbox;
late SharedPreferences prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await LocalStore.create();
  prefs = await SharedPreferences.getInstance();
  runApp(const CourierApp());
}

class CourierApp extends StatelessWidget {
  const CourierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, __, _) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => OtpLoginProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => registerProvider(),
          ),
          ChangeNotifierProvider(
              create: (context) => LOGINUSERACCOUNTPROVIDER()),
          ChangeNotifierProvider(
            create: (context) => StatePickupandBankDetailsProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ParcelProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => StatePracelProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => HomeProvider()
              ..parcelHomeAction()
              ..transactionHomeAction()
              ..accountManagerHomeAction()
              ..noticeHomeAction(),
          ),
          ChangeNotifierProvider(create: (context) => ParcelListProvider()),
          ChangeNotifierProvider(
            create: (context) => ProfileProvider()..bankDetailsAction(context),
          ),
          ChangeNotifierProvider(
            create: (context) => SearchProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => SearchProvider(),
          ),
        ],
        child: MaterialApp(
          title: name,
          debugShowCheckedModeBanner: false,
          theme: FlexThemeData.light(
            scheme: FlexScheme.green,
            useMaterial3: false,
          ),
          darkTheme: FlexThemeData.dark(
            scheme: FlexScheme.red,
            useMaterial3: false,
          ),
          themeMode: ThemeMode.light,
          routes: Routers.getPages,
          initialRoute: "/",
        ),
      );
    });
  }
}
