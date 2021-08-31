/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:flutter/material.dart';
import 'package:urlshortnerclient/models/urlModel.dart';

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
      onTap: (){
        
      },
    );
  }

  Widget _urlWidgetMobile(BuildContext context) {
    return Container(child: Text("Half"));
  }
}
