import 'package:courier_app/page/Auth/PhoneVerification/PhoneVerify.dart';
import 'package:courier_app/page/Auth/Register/register.dart';
import 'package:courier_app/page/Auth/otpVerifyWithLogin/otpVerifyWithLogin.dart';
import 'package:courier_app/page/Dashboard/dashboard.dart';
import 'package:courier_app/page/PickupAndBankDetails/PickupDetails.dart';
import 'package:courier_app/page/PickupAndBankDetails/bankDetails.dart';
import 'package:courier_app/page/Profile/profile.dart';
import 'package:courier_app/page/Welcome/Welcome.dart';
import 'package:courier_app/page/parcel/parcel.dart';

class Routers {
  static final getPages = {
    "/": (_) => WelcomePage(),
    "/profile": (_) => Profile(),
    "/homePage": (_) => Dashboard(),
    "/phoneverify": (_) => PhoneVerify(),
    "/otpVerifyWithLogin": (_) => OtpVerifyWithLogin(),
    "/register": (_) => Register(),
    "/pickupdetails": (_) => PickupDetails(),
    "/bankdetails": (_) => BankDetails(),
    "/order": (_) => ParcelCreateView(),
  };
}
