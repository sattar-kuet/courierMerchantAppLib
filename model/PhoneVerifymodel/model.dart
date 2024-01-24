class phoneVerifyModel {
  Params? params;

  phoneVerifyModel({this.params});

  phoneVerifyModel.fromJson(Map<String, dynamic> json) {
    params =
        json['params'] != null ? new Params.fromJson(json['params']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.params != null) {
      data['params'] = this.params!.toJson();
    }
    return data;
  }
}

class Params {
  String? phone;
  String? message;

  Params({this.phone, this.message});

  Params.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['message'] = this.message;
    return data;
  }
}
