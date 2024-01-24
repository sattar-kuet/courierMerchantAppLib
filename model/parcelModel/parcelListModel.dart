class ParcelListModel {
  int? id;
  String? tracking;
  String? created_at;
  Customer? customer;
  Status? status;

  ParcelListModel({this.id, this.tracking, this.customer, this.status});

  ParcelListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created_at = json['created_at'];
    tracking = json['tracking'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tracking'] = this.tracking;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    return data;
  }
}

class Customer {
  dynamic name;
  dynamic phone;
  dynamic address;

  Customer({this.name, this.phone, this.address});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}

class Status {
  String? label;
  Icon? icon;

  Status({this.label, this.icon});

  Status.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    icon = json['icon'] != null ? new Icon.fromJson(json['icon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    if (this.icon != null) {
      data['icon'] = this.icon!.toJson();
    }
    return data;
  }
}

class Icon {
  String? code;
  String? bgColor;
  String? fontColor;

  Icon({this.code, this.bgColor, this.fontColor});

  Icon.fromJson(Map<String, dynamic> json) {
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
