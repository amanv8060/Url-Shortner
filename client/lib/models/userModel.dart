/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

class UserModel {
  String email;
  String? jwt;
  String name;

  UserModel({required this.email, required this.name, this.jwt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      jwt: json['jwt'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'jwt': jwt,
      };
}
