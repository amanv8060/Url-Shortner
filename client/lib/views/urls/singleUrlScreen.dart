/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:flutter/material.dart';
import 'package:urlshortnerclient/models/urlModel.dart';
import 'package:urlshortnerclient/views/urls/editUrlView.dart';

class SingleUrlScreen extends StatefulWidget {
  final bool full;
  final UrlModel url;
  SingleUrlScreen({Key? key, required this.full, required this.url})
      : super(key: key);

  @override
  _SingleUrlScreenState createState() => _SingleUrlScreenState();
}

class _SingleUrlScreenState extends State<SingleUrlScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Single URL View"),
        ),
        body: widget.full
            ? _singleUrlDesktop(context)
            : _singleUrlMobile(context));
  }

  Widget _singleUrlDesktop(BuildContext context) {
    return Column(
      children: [],
    );
  }

  Widget _singleUrlMobile(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("Edit/Delete this URL"),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditUrlScreen(urlModel: widget.url)));
          },
        ),
      ],
    );
  }
}
