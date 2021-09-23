/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'dart:convert';

import 'package:urlshortnerclient/models/userModel.dart';
import 'package:http/http.dart' as http;
import 'package:urlshortnerclient/services/baseService.dart';

class AuthService extends BaseService {
  Future<bool> signUp(String name, String email, String password) async {
    http.Response response;

    try {
      response = await super.makeRequest('/api/v1/signup',
          method: 'PUT',
          body:
              jsonEncode({"name": name, "email": email, "password": password}));
    } catch (er) {
      throw er;
    }
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.body);
    }
  }

  Future<UserModel> signIn(String email, String password) async {
    http.Response response;

    try {
      response = await super.makeRequest('/api/v1/login',
          method: 'POST',
          body: jsonEncode({"email": email, "password": password}));
    } catch (er) {
      throw er;
    }
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  }

  Future<bool> verifyToken(String token) async {
    http.Response response;

    try {
      response = await super.makeRequest('/api/v1/verify',
          method: 'GET', extraHeaders: {"authorization": token});
    } catch (er) {
      throw er;
    }
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.body);
    }
  }
}
