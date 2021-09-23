/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urlshortnerclient/models/userModel.dart';
import 'package:urlshortnerclient/services/authService.dart';
import 'package:urlshortnerclient/services/service_locator.dart';
import 'package:urlshortnerclient/utils/sessionAuth.dart';

class AuthViewModel extends ChangeNotifier {
  AuthService _authService = serviceLocator<AuthService>();

  SessionAuth _sessionAuth = SessionAuth.shared;

  bool _processing = false;
  bool _isError = false;
  bool _signUpSuccess = false;
  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  bool get isError => _isError;

  bool get processing => _processing;

  bool get signUpSuccess => _signUpSuccess;

  UserModel? get user => _sessionAuth.user;

  Future<void> signUp(String email, String password, String name) async {
    _processing = true;
    _errorMessage = "";
    _isError = false;

    _signUpSuccess = false;
    notifyListeners();
    try {
      _signUpSuccess = await _authService.signUp(name, email, password);
    } catch (error) {
      _isError = true;
      _signUpSuccess = false;
      _errorMessage = error.toString();
    }

    _processing = false;
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    _processing = true;
    _errorMessage = "";
    _isError = false;
    notifyListeners();
    try {
      _sessionAuth.user = await _authService.signIn(email, password);
    } catch (error) {
      _isError = true;
      _sessionAuth.user = null;
      _errorMessage = error.toString();
    }

    final _instance = await SharedPreferences.getInstance();
    if (_sessionAuth.user != null) {
      await _instance.setString("user", _sessionAuth.user.toString());
    }
    _processing = false;
    notifyListeners();
  }

  Future<void> logout() async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.remove("user");
    return;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty)
      return "Please Enter password";
    else if (value.length < 8) {
      return "Please Enter Valid Password";
    }
  }

  String? validateEmail(String? value) {
    RegExp regExp = RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    if (value == null || value.length == 0) {
      return 'Please enter Email Address';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid email Address';
    }
    return null;
  }
}
