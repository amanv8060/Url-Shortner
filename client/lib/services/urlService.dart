/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:urlshortnerclient/models/urlModel.dart';
import 'package:urlshortnerclient/services/baseService.dart';

class UrlService extends BaseService {
  static const String baseUrl = "http://127.0.0.1:3000";

  Future<List<UrlModel>> getAllUrls() async {
    http.Response response;
    try {
      response = await super.makeRequest('/api/v1/all', method: 'GET');
    } catch (er) {
      throw er;
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = json.decode(response.body);
        if (responseMap['urls'] == null || responseMap['urls'].length == 0) {
        return List.empty();
      }
      return responseMap['urls'].map((url) => UrlModel.fromJson(url)).toList();
    } else {
      throw Exception('Failed to get all urls');
    }
  }

  
}
