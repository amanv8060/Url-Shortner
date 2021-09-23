/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:http/http.dart' as http;

class BaseService {
  static const String BASE_URL = "https://url.ophilia.in";
  static final Map<String, String> headers = {
    "Content-Type": "application/json"
  };

  Future<http.Response> makeRequest(String url,
      {String method = 'POST',
      body,
      mergeDefaultHeader = true,
      Map<String, String>? extraHeaders}) async {
    Uri uri = Uri.parse(BASE_URL + url);
    try {
      extraHeaders ??= {};
      var sentHeaders =
          mergeDefaultHeader ? {...headers, ...extraHeaders} : extraHeaders;

      switch (method) {
        case 'POST':
          body ??= {};
          return http.post(uri, headers: sentHeaders, body: body);

        case 'GET':
          return http.get(uri, headers: sentHeaders);

        case 'PUT':
          return http.put(uri, headers: sentHeaders, body: body);

        case 'DELETE':
          return http.delete(uri, headers: sentHeaders , body:body);

        default:
          return http.post(uri, headers: sentHeaders, body: body);
      }
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
