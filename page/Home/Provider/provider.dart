import 'package:courier_app/logic/HomeProvider/provider.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:courier_app/utility/extension.dart';

class StateHomeProvider extends ChangeNotifier {
  String _date = "last 30 Days";
  String _range = '30';

  String get range => _range;
  String get date => _date;
  // According to Date Range Data Get Action
  void dateRangeDateAction(BuildContext context, {required String range}) {
    _range = range;
    notifyListeners();
    if (range == "1") {
      _date = "Today";
      print("call");
      notifyListeners();
    }
    if (range == "7") {
      _date = "Last 7 Days";
      notifyListeners();
    }
    if (range == "15") {
      _date = "Last 15 Days";
      notifyListeners();
    }
    if (range == "30") {
      _date = "Last 30 Days";
      notifyListeners();
    }

    notifyListeners();
    Provider.of<HomeProvider>(context, listen: false)
      ..parcelHomeAction(
        startDate: range.startDateTime,
        endDate: endDateTime,
      );
    Provider.of<HomeProvider>(context, listen: false)
      ..transactionHomeAction(
        startDate: range.startDateTime,
        endDate: endDateTime,
      );
    Provider.of<HomeProvider>(context, listen: false)
      ..noticeHomeAction(
        startDate: range.startDateTime,
        endDate: endDateTime,
      );
    Provider.of<HomeProvider>(context, listen: false)
      ..accountManagerHomeAction(
        startDate: range.startDateTime,
        endDate: endDateTime,
      );
  }

  // According to Custom Date Range Data Get Action
  void customDateRnageDateAction(BuildContext context) async {
    List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
        context: context, primaryColor: Theme.of(context).primaryColor);
    if (dateTimeList != null) {
      _date = dateTimeList.first.customDateTime +
          " to " +
          dateTimeList.last.customDateTime;
      notifyListeners();
      Provider.of<HomeProvider>(context, listen: false)
        ..parcelHomeAction(
          startDate: dateTimeList.first.customDateTime,
          endDate: dateTimeList.last.customDateTime,
        );
      Provider.of<HomeProvider>(context, listen: false)
        ..transactionHomeAction(
          startDate: dateTimeList.first.customDateTime,
          endDate: dateTimeList.last.customDateTime,
        );
      Provider.of<HomeProvider>(context, listen: false)
        ..noticeHomeAction(
          startDate: dateTimeList.first.customDateTime,
          endDate: dateTimeList.last.customDateTime,
        );
      Provider.of<HomeProvider>(context, listen: false)
        ..accountManagerHomeAction(
          startDate: dateTimeList.first.customDateTime,
          endDate: dateTimeList.last.customDateTime,
        );
    }
  }
}
