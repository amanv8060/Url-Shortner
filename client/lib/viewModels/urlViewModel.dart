/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:flutter/foundation.dart';
import 'package:urlshortnerclient/services/service_locator.dart';
import 'package:urlshortnerclient/services/urlService.dart';
import 'package:urlshortnerclient/viewModels/sessionViewModel.dart';

class UrlViewModel extends ChangeNotifier {
  final UrlService _urlService = serviceLocator<UrlService>();

  final SessionViewModel _sessionViewModel = serviceLocator<SessionViewModel>();

  bool _processing = false;
  bool _isError = false;
  String _errorMessage = "";
  bool _success = false;

  //getters
  String get errorMessage => _errorMessage;
  bool get isError => _isError;
  bool get success => _success;
  bool get processing => _processing;

  Future<void> createUrl(String longUrl, String alias) async {
    _processing = true;
    _errorMessage = "";
    _isError = false;
    notifyListeners();
    try {
      await _urlService.createUrl(
          longUrl, alias, _sessionViewModel.user!.token);
      _success = true;
    } catch (error) {
      _isError = true;
      _errorMessage = error.toString();
    }
    _processing = false;
    notifyListeners();
  }

  Future<void> editUrl(String longUrl, String id) async {
    _processing = true;
    _errorMessage = "";
    _isError = false;
    notifyListeners();
    try {
      await _urlService.editUrl(longUrl, id, _sessionViewModel.user!.token);
      _success = true;
    } catch (error) {
      _isError = true;
      _errorMessage = error.toString();
    }
    _processing = false;
    notifyListeners();
  }

  Future<void> deleteUrl(String id) async {
    _processing = true;
    _errorMessage = "";
    _isError = false;
    notifyListeners();
    try {
      await _urlService.delete(id, _sessionViewModel.user!.token);
      _success = true;
    } catch (error) {
      _isError = true;
      _errorMessage = error.toString();
    }
    _processing = false;
    notifyListeners();
  }
}
