class ParcelDetailsModel {
  Parcel? parcel;
  Customer? customer;
  Merchant? merchant;
  List<Cash>? cash;
  Rider? rider;
  List<Tracking>? tracking;

  ParcelDetailsModel(
      {this.parcel,
      this.customer,
      this.merchant,
      this.cash,
      this.rider,
      this.tracking});

  ParcelDetailsModel.fromJson(Map<String, dynamic> json) {
    parcel =
        json['parcel'] != null ? new Parcel.fromJson(json['parcel']) : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    merchant = json['merchant'] != null
        ? new Merchant.fromJson(json['merchant'])
        : null;
    if (json['cash'] != null) {
      cash = <Cash>[];
      json['cash'].forEach((v) {
        cash!.add(new Cash.fromJson(v));
      });
    }
    rider = json['rider'] != null ? new Rider.fromJson(json['rider']) : null;
    if (json['tracking'] != null) {
      tracking = <Tracking>[];
      json['tracking'].forEach((v) {
        tracking!.add(new Tracking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.parcel != null) {
      data['parcel'] = this.parcel!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.merchant != null) {
      data['merchant'] = this.merchant!.toJson();
    }
    if (this.cash != null) {
      data['cash'] = this.cash!.map((v) => v.toJson()).toList();
    }
    if (this.rider != null) {
      data['rider'] = this.rider!.toJson();
    }
    if (this.tracking != null) {
      data['tracking'] = this.tracking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Parcel {
  int? id;
  dynamic tracking;
  dynamic type;
  dynamic weight;
  dynamic merchantReference;
  dynamic note;
  dynamic createdAt;
  bool? hasexchange;
  Status? status;

  Parcel(
      {this.id,
      this.tracking,
      this.type,
      this.weight,
      this.merchantReference,
      this.note,
      this.createdAt,
      this.status});

  Parcel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hasexchange = json['has_exchange'];
    tracking = json['tracking'];
    type = json['type'];
    weight = json['weight'];
    merchantReference = json['merchant_reference'];
    note = json['note'];
    createdAt = json['created_at'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tracking'] = this.tracking;
    data['type'] = this.type;
    data['weight'] = this.weight;
    data['merchant_reference'] = this.merchantReference;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
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

class Merchant {
  int? id;
  String? name;
  String? phone;
  String? company;
  String? address;

  Merchant({this.id, this.name, this.phone, this.company, this.address});

  Merchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    company = json['company'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['company'] = this.company;
    data['address'] = this.address;
    return data;
  }
}

class Cash {
  String? label;
  dynamic value;

  Cash({this.label, this.value});

  Cash.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}

class Rider {
  dynamic name;
  dynamic phone;

  Rider({this.name, this.phone});

  Rider.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}

class Tracking {
  String? time;
  String? date;
  String? message;

  Tracking({this.time, this.date, this.message});

  Tracking.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    date = json['date'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['date'] = this.date;
    data['message'] = this.message;
    return data;
  }
}
