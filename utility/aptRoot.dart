import 'dart:convert';

import 'package:courier_app/utility/config.dart';
import 'package:courier_app/utility/localStore.dart';
import 'package:http/http.dart' as http;

class ApiRoot {
  static Future<http.Response> POST_REQUEST(
      {required String url, required Map data, bool isEmpty = false}) async {
    final mainUrl = Uri.parse(BASE_URL + "/$url");

    http.Response response = await http.post(mainUrl,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Cookie': 'session_id=${SystemInfo.getToken}'
          // 'Cookie': 'session_id=1c6af413972030cdd829e99b79621330fb8178f7'
        },
        body: isEmpty ? json.encode({}) : json.encode({"params": data}));
    return response;
  }

  static Future<http.Response> GET_REQUEST({required String url}) async {
    final mainUrl = Uri.parse(BASE_URL + "/$url");

    http.Response response = await http.get(
      mainUrl,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Cookie': 'session_id=${SystemInfo.getToken}'
      },
    );
    return response;
  }
}
