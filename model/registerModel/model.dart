class registerTojson {
  String? name;
  String? email;
  String? phone;
  String? password;
  String? company;

  registerTojson(
      {this.name, this.email, this.phone, this.password, this.company});

  registerTojson.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['company'] = this.company;
    return data;
  }
}
