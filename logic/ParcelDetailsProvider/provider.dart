import 'dart:convert';
import 'package:courier_app/model/parcelModel/parcelDetailsMode.dart';
import 'package:courier_app/utility/aptRoot.dart';
import 'package:courier_app/utility/localStore.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';

class ParcelDetailsProvider extends ChangeNotifier {
  bool _isNotNone = false;
  ParcelDetailsModel? _parcelDetails;
  ParcelDetailsModel? get parcelDetails => _parcelDetails;

  void parcelDetailsAction(BuildContext context, String id) async {
    try {
      context.loaderOverlay.show();
      notifyListeners();
      http.Response response = await ApiRoot.POST_REQUEST(
        url: "parcel/detail/$id",
        data: {
          "uid": SystemInfo.getUid,
        },
        isEmpty: false,
      );
      // print(response.body);
      if (response.statusCode == 200) {
        _parcelDetails = ParcelDetailsModel.fromJson(
            json.decode(response.body)['result']['data']);

        context.loaderOverlay.hide();
        notifyListeners();
      } else {
        Navigator.of(context).pop();
        context.loaderOverlay.hide();
        notifyListeners();
      }
    } on http.ClientException catch (e) {
      context.loaderOverlay.hide();
      notifyListeners();
      print(e.toString());
    }
  }
}
