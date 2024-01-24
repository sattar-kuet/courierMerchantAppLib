import 'package:equatable/equatable.dart';

class getCustomerModel extends Equatable {
  int? id;
  dynamic name;
  dynamic districtId;
  dynamic upazillaId;
  dynamic address;

  getCustomerModel(
      {this.name, this.districtId, this.upazillaId, this.address, this.id});

  getCustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    districtId = json['district_id'];
    upazillaId = json['upazilla_id'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['district_id'] = this.districtId;
    data['upazilla_id'] = this.upazillaId;
    data['address'] = this.address;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.address,
        this.districtId,
        this.name,
        this.upazillaId,
      ];
}
