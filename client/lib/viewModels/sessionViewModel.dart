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

class SessionViewModel extends ChangeNotifier {
  SessionAuth _sessionAuth = SessionAuth.shared;

  final AuthService _authService = serviceLocator<AuthService>();

  bool _processing = false;
  bool _isError = false;
  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  bool get isError => _isError;

  bool get processing => _processing;

  UserModel? get user => _sessionAuth.user;

  Future<void> _loadData() async {
    _processing = true;
    _errorMessage = "";
    _isError = false;
    notifyListeners();
    final _instance = await SharedPreferences.getInstance();
    try {
      String? user = await _instance.getString("user");
      if (user != null) {
        _sessionAuth.user = UserModel.fromString(user);
      } else {
        _sessionAuth.user = null;
      }
    } catch (error) {
      _sessionAuth.user = null;
    }
  }

  void verifyToken() async {
    await _loadData();

    //Verifying if the token present is actually valid
    if (_sessionAuth.user != null) {
      print("here");
      final _instance = await SharedPreferences.getInstance();
      bool temp = false;
      try {
        temp = await _authService.verifyToken(_sessionAuth.user!.token);
      } catch (error) {
        _isError = true;
        _errorMessage = error.toString();
      }
      if (!temp) {
        _sessionAuth.user = null;
        await _instance.remove("user");
      }
    }
    _processing = false;
    notifyListeners();
  }
}
