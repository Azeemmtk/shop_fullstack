class AuthenticationModel {
  String? username;
  String? password;
  String? name;
  String? email;
  String? sId;
  int? iV;
  String? phone;

  AuthenticationModel(
      {this.username,
      this.password,
      this.name,
      this.email,
      this.sId,
      this.iV,
      this.phone});

  AuthenticationModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;

    return data;
  }
}
