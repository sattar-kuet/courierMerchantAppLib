import 'package:objectbox/objectbox.dart';

@Entity()
class deliverySpeedModel {
  int? id;
  int? idspeed;
  String? label;

  deliverySpeedModel({this.id, this.idspeed, this.label});

  deliverySpeedModel.fromJson(Map<String, dynamic> json) {
    idspeed = json['id'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idspeedd'] = this.idspeed;
    data['label'] = this.label;
    return data;
  }
}
