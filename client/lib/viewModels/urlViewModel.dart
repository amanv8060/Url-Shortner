/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:flutter/foundation.dart';
import 'package:urlshortnerclient/models/urlModel.dart';
import 'package:urlshortnerclient/services/service_locator.dart';
import 'package:urlshortnerclient/services/urlService.dart';

class UrlViewModel extends ChangeNotifier {
  final UrlService _urlService = serviceLocator<UrlService>();
  List<UrlModel> _urls = [];

  bool _processing = false;
  bool _isError = false;
  String _errorMessage = "";

  List<UrlModel> get urls => _urls;
  String get errorMessage => _errorMessage;

  bool get isError => _isError;

  bool get processing => _processing;

  //We load all the urls for the user ,
  void loadData() async {
    _processing = true;
    _errorMessage = "";
    _isError = false;
    notifyListeners();
    try {
      _urls = await _urlService.getAllUrls();
    } catch (error) {
      _isError = true;
      _errorMessage = error.toString();
    }
    _processing = false;
    notifyListeners();
  }
}