// Home Parcel Model
class HomeParcelModel {
  int? id;
  String? title;
  int? value;
  PaColor? color;
  String? status;

  HomeParcelModel({this.id, this.title, this.value, this.color, this.status});

  HomeParcelModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    value = json['value'];
    color = json['color'] != null ? new PaColor.fromJson(json['color']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['value'] = this.value;
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class PaColor {
  String? code;
  String? bgColor;
  String? fontColor;

  PaColor({this.code, this.bgColor, this.fontColor});

  PaColor.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    bgColor = json['bg_color'];
    fontColor = json['font_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['bg_color'] = this.bgColor;
    data['font_color'] = this.fontColor;
    return data;
  }
}


// Home Transaction Model
class HomeTransactionModel {
  int? id;
  String? title;
  dynamic value;
  TrColor? color;
  String? status;

  HomeTransactionModel(
      {this.id, this.title, this.value, this.color, this.status});

  HomeTransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    value = json['value'];
    color = json['color'] != null ? new TrColor.fromJson(json['color']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['value'] = this.value;
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class TrColor {
  String? code;
  String? bgColor;
  String? fontColor;

  TrColor({this.code, this.bgColor, this.fontColor});

  TrColor.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    bgColor = json['bg_color'];
    fontColor = json['font_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['bg_color'] = this.bgColor;
    data['font_color'] = this.fontColor;
    return data;
  }
}

// Home Notice Model

class homeNoticeDataModel {
  int? id;
  String? content;
  dynamic url;

  String? image;

  homeNoticeDataModel({this.id, this.content, this.url, this.image});

  homeNoticeDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    url = json['url'];

    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['url'] = this.url;

    data['image'] = this.image;
    return data;
  }
}

class accountManagerModel {
  String? name;
  String? phone;
  String? avatar;

  accountManagerModel({this.name, this.phone, this.avatar});

  accountManagerModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    return data;
  }
}
