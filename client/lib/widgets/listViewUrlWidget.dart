/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:flutter/material.dart';
import 'package:urlshortnerclient/models/urlModel.dart';
import 'package:urlshortnerclient/views/urls/editUrlView.dart';

class ListViewUrlWidget extends StatelessWidget {
  final UrlModel url;
  final bool full;
  final int index;

  const ListViewUrlWidget({required url, required index, required full})
      : this.url = url,
        this.index = index,
        this.full = full;

  @override
  Widget build(BuildContext context) {
    return full ? _urlWidgetDesktop(context) : _urlWidgetMobile(context);
  }

  Widget _urlWidgetDesktop(BuildContext context) {
    return ListTile(
      leading: Text(index.toString()),
      title: Text(url.shortUrl),
      subtitle: Text(url.longUrl),
      trailing: Text(url.clicks.toString() + " Clicks"),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditUrlScreen(urlModel: url)));
      },
    );
  }

  Widget _urlWidgetMobile(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Text(index.toString()),
        title: Text(url.shortUrl),
        subtitle: Text(url.longUrl),
        trailing: Text(url.clicks.toString() + " Clicks"),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditUrlScreen(urlModel: url)));
        },
      ),
    );
  }
}
