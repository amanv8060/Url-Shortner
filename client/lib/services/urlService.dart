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
  Future<List<UrlModel>> getAllUrls(String token) async {
    http.Response response;
    try {
      response = await super.makeRequest('/api/v1/getUserUrls',
          method: 'GET', extraHeaders: {"authorization": token});
    } catch (er) {
      throw er;
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = json.decode(response.body);
      if (responseMap['urls'] == null || responseMap['urls'].length == 0) {
        return List.empty();
      }
      List<UrlModel> temp = responseMap['urls']
          .map<UrlModel>((url) => UrlModel.fromJson(url))
          .toList();
      return temp;
    } else {
      throw Exception(response.body);
    }
  }

  Future<UrlModel> createUrl(String longUrl, String alias, String token) async {
    http.Response response;
    try {
      response = await super.makeRequest('/api/v1/createUrl',
          method: 'PUT',
          extraHeaders: {"authorization": token},
          body: jsonEncode({"shortUrl": alias, "longUrl": longUrl}));
    } catch (er) {
      throw er;
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = json.decode(response.body);
      return UrlModel.fromJson(responseMap);
    } else {
      throw Exception(response.body);
    }
  }

  Future<UrlModel> editUrl(String longUrl, String id, String token) async {
    http.Response response;
    try {
      response = await super.makeRequest('/api/v1/editUrl',
          method: 'POST',
          extraHeaders: {"authorization": token},
          body: jsonEncode({"id": id, "longUrl": longUrl}));
    } catch (er) {
      throw er;
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = json.decode(response.body);
      return UrlModel.fromJson(responseMap);
    } else {
      throw Exception(response.body);
    }
  }

  Future<UrlModel> delete(String id, String token) async {
    http.Response response;
    print(id);
    try {
      response = await super.makeRequest('/api/v1/deleteUrl',
          method: 'DELETE',
          extraHeaders: {"authorization": token},
          body: jsonEncode({"id": id}));
    } catch (er) {
      throw er;
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = json.decode(response.body);
      return UrlModel.fromJson(responseMap);
    } else {
      throw Exception(response.body);
    }
  }
}
