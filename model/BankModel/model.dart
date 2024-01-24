class BankDetailsModel {
  int? id;
  String? name;
  bool? isMobileBanking;

  BankDetailsModel({this.id, this.name, this.isMobileBanking});

  BankDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isMobileBanking = json['is_mobile_banking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_mobile_banking'] = this.isMobileBanking;
    return data;
  }
}
