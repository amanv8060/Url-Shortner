/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

class UserModel {
  String email;
  String token;
  String name;

  UserModel({required this.email, required this.name, required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'token': token,
      };
  @override
  String toString() {
    return "${email},${token},${name}";
  }

 factory UserModel.fromString(String str) {
    List<String> strs = str.split(',');

    return UserModel(email: strs[0], name: strs[2], token: strs[1]);
  }
}
