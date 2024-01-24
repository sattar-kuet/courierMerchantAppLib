import 'package:equatable/equatable.dart';

class TransactionListModel extends Equatable {
  List<TransactionItems>? items;
  TransactionColor? color;

  TransactionListModel({this.items, this.color});

  TransactionListModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <TransactionItems>[];
      json['items'].forEach((v) {
        items!.add(new TransactionItems.fromJson(v));
      });
    }
    color = json['color'] != null
        ? new TransactionColor.fromJson(json['color'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [this.items, color];
}

class TransactionItems {
  int? id;
  String? number;
  double? amount;
  String? date;

  TransactionItems({this.id, this.number, this.amount, this.date});

  TransactionItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    amount = json['amount'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['amount'] = this.amount;
    data['date'] = this.date;
    return data;
  }
}

class TransactionColor {
  String? code;
  String? bgColor;
  String? fontColor;

  TransactionColor({this.code, this.bgColor, this.fontColor});

  TransactionColor.fromJson(Map<String, dynamic> json) {
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

class TransactionDetailsModel {
  List<Items>? items;
  Invoice? invoice;

  TransactionDetailsModel({this.items, this.invoice});

  TransactionDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    invoice =
        json['invoice'] != null ? new Invoice.fromJson(json['invoice']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.invoice != null) {
      data['invoice'] = this.invoice!.toJson();
    }
    return data;
  }
}

class Items {
  int? id;
  String? tracking;
  dynamic cashCollection;
  dynamic codCharge;
  dynamic deliveryCharge;
  dynamic totalCharge;
  dynamic merchantAmount;

  Items(
      {this.id,
      this.tracking,
      this.cashCollection,
      this.codCharge,
      this.deliveryCharge,
      this.totalCharge,
      this.merchantAmount});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tracking = json['tracking'];
    cashCollection = json['cash_collection'];
    codCharge = json['cod_charge'];
    deliveryCharge = json['delivery_charge'];
    totalCharge = json['total_charge'];
    merchantAmount = json['merchant_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tracking'] = this.tracking;
    data['cash_collection'] = this.cashCollection;
    data['cod_charge'] = this.codCharge;
    data['delivery_charge'] = this.deliveryCharge;
    data['total_charge'] = this.totalCharge;
    data['merchant_amount'] = this.merchantAmount;
    return data;
  }
}

class Invoice {
  String? number;
  String? createdAt;
  dynamic amount;
  String? status;

  Invoice({this.number, this.createdAt, this.amount});

  Invoice.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    createdAt = json['created_at'];
    amount = json['amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['created_at'] = this.createdAt;
    data['amount'] = this.amount;
    return data;
  }
}

// Process Model
class TransactionProcessModel extends Equatable {
  List<ProcessItems>? items;
  String? recordType;
  ProcessColor? color;

  TransactionProcessModel({this.items, this.recordType, this.color});

  TransactionProcessModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <ProcessItems>[];
      json['items'].forEach((v) {
        items!.add(new ProcessItems.fromJson(v));
      });
    }
    recordType = json['record_type'];
    color =
        json['color'] != null ? new ProcessColor.fromJson(json['color']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['record_type'] = this.recordType;
    if (this.color != null) {
      data['color'] = this.color!.toJson();
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [this.color, this.items, this.recordType];
}

class ProcessItems extends Equatable {
  int? id;
  String? tracking;
  dynamic cashCollection;
  double? codCharge;
  dynamic deliveryCharge;
  double? totalCharge;
  double? merchantAmount;

  ProcessItems(
      {this.id,
      this.tracking,
      this.cashCollection,
      this.codCharge,
      this.deliveryCharge,
      this.totalCharge,
      this.merchantAmount});

  ProcessItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tracking = json['tracking'];
    cashCollection = json['cash_collection'];
    codCharge = json['cod_charge'];
    deliveryCharge = json['delivery_charge'];
    totalCharge = json['total_charge'];
    merchantAmount = json['merchant_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tracking'] = this.tracking;
    data['cash_collection'] = this.cashCollection;
    data['cod_charge'] = this.codCharge;
    data['delivery_charge'] = this.deliveryCharge;
    data['total_charge'] = this.totalCharge;
    data['merchant_amount'] = this.merchantAmount;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.cashCollection,
        this.codCharge,
        this.deliveryCharge,
        this.id,
        this.merchantAmount,
        this.totalCharge,
        this.tracking
      ];
}

class ProcessColor extends Equatable {
  String? code;
  String? bgColor;
  String? fontColor;

  ProcessColor({this.code, this.bgColor, this.fontColor});

  ProcessColor.fromJson(Map<String, dynamic> json) {
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

  @override
  // TODO: implement props
  List<Object?> get props => [this.bgColor, this.code, this.fontColor];
}
