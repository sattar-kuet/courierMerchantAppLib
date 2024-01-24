import 'package:equatable/equatable.dart';

class userExistModel extends Equatable {
  bool? wrongUserType;
  bool? status;
  int? statusCode;
  String? newPassword;
  String? login;
  String? phone;

  userExistModel(
      {this.wrongUserType,
      this.status,
      this.statusCode,
      this.newPassword,
      this.login,
      this.phone});

  userExistModel.fromJson(Map<String, dynamic> json) {
    wrongUserType = json['wrong_user_type'];
    status = json['status'];
    statusCode = json['status_code'];
    newPassword = json['new_password'];
    login = json['login'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wrong_user_type'] = this.wrongUserType;
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['new_password'] = this.newPassword;
    data['login'] = this.login;
    data['phone'] = this.phone;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [this.login, this.newPassword, this.phone, this.status, this.statusCode];
}
