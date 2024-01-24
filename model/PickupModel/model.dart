import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class districtModel extends Equatable {
  @Id()
  int id = 0;
  int? idDistrict;
  String? name;

  districtModel({required this.id, this.idDistrict, this.name});

  districtModel.fromJson(Map<String, dynamic> json) {
    idDistrict = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.idDistrict;
    data['name'] = this.name;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [this.idDistrict, this.name];
}

@Entity()
class upazillaModel {
  int? id;
  int? upazillaID;
  int? districtId;
  String? name;

  upazillaModel({this.upazillaID, this.id, this.districtId, this.name});

  upazillaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtId = json['district_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['district_id'] = this.districtId;
    data['name'] = this.name;
    return data;
  }
}
