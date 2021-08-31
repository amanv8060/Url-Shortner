/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:flutter/material.dart';
import 'package:urlshortnerclient/models/urlModel.dart';
import 'package:urlshortnerclient/services/urlService.dart';
import 'package:urlshortnerclient/widgets/listViewUrlWidget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UrlService urlService = UrlService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    urlService.getAllUrls();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          appBar: AppBar(),
          body: (constraints.maxWidth > 800)
              ? GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: _height / 125,
                  children: List.generate(
                      10,
                      (index) => ListViewUrlWidget(
                            url: UrlModel(
                                longUrl: "test ", shortUrl: "test", clicks: 10),
                            index: index,
                            full: true,
                          )))
              : ListViewUrlWidget(
                  url: UrlModel(longUrl: "test ", shortUrl: "test", clicks: 10),
                  index: 0,
                  full: false,
                ));
    });
  }
}
