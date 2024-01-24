import 'package:equatable/equatable.dart';

class PickupPointModel extends Equatable {
  int? id;
  dynamic? title;
  dynamic? name;
  int? districtId;
  String? district;
  int? upazillaId;
  String? upazilla;
  String? address;
  dynamic? lat;
  dynamic? lng;

  PickupPointModel(
      {this.id,
      this.title,
      this.name,
      this.districtId,
      this.district,
      this.upazillaId,
      this.upazilla,
      this.address,
      this.lat,
      this.lng});

  PickupPointModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    name = json['name'];
    districtId = json['district_id'];
    district = json['district'];
    upazillaId = json['upazilla_id'];
    upazilla = json['upazilla'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['name'] = this.name;
    data['district_id'] = this.districtId;
    data['district'] = this.district;
    data['upazilla_id'] = this.upazillaId;
    data['upazilla'] = this.upazilla;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.name,
        this.title,
        this.address,
        this.district,
        this.districtId,
        this.id,
        this.lat,
        this.lng,
        this.upazilla,
        this.upazillaId,
        this.address
      ];
}

class profileBankModel {
  int? id;
  int? bankId;
  String? bankName;
  String? accountName;
  String? accountNumber;
  String? branch;
  String? mobileNumber;
  String? mobileBankAccountType;
  String? selectedBankType;

  profileBankModel(
      {this.id,
      this.bankId,
      this.accountName,
      this.accountNumber,
      this.branch,
      this.bankName,
      this.mobileNumber,
      this.mobileBankAccountType,
      this.selectedBankType});

  profileBankModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bankId = json['bank_id'];
    accountName = json['account_name'].toString();
    accountNumber = json['account_number'].toString();
    branch = json['branch'].toString();
    bankName = json['bank_name'].toString();
    mobileNumber = json['mobile_number'].toString();
    mobileBankAccountType = json['mobile_bank_account_type'].toString();
    selectedBankType = json['selected_bank_type'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bank_id'] = this.bankId;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['branch'] = this.branch;
    data['mobile_number'] = this.mobileNumber;
    data['mobile_bank_account_type'] = this.mobileBankAccountType;
    data['selected_bank_type'] = this.selectedBankType;
    data['bank_name'] = this.bankName;
    return data;
  }
}
