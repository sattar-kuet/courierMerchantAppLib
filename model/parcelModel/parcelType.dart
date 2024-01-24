import 'package:objectbox/objectbox.dart';

@Entity()
class parcelTypeModel {
  int? id;
  int? parcelID;
  String? parcelType;

  parcelTypeModel({this.id, this.parcelID, this.parcelType});

  parcelTypeModel.fromJson(Map<String, dynamic> json) {
    parcelID = json['parcelID'];
    parcelType = json['parcel_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parcelID'] = this.parcelID;
    data['parcel_type'] = this.parcelType;
    return data;
  }
}
