/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

class UrlModel {
  String longUrl;
  String shortUrl;
  int clicks;
  String? id;

  UrlModel(
      {required this.longUrl, required this.shortUrl, int clicks = 0, this.id})
      : this.clicks = clicks;

  factory UrlModel.fromJson(Map<String, dynamic> json) {
    return UrlModel(
      longUrl: json['longUrl'],
      shortUrl: json['shortUrl'],
      clicks: json['clicks'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'longUrl': longUrl,
        'shortUrl': shortUrl,
        'clicks': clicks,
        '_id': id,
      };

}
