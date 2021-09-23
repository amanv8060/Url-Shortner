/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urlshortnerclient/models/urlModel.dart';
import 'package:urlshortnerclient/services/service_locator.dart';
import 'package:urlshortnerclient/viewModels/urlViewModel.dart';
import 'package:urlshortnerclient/widgets/listViewUrlWidget.dart';

class AllUrlsScreen extends StatefulWidget {
  AllUrlsScreen({Key? key}) : super(key: key);

  @override
  _AllUrlsScreenState createState() => _AllUrlsScreenState();
}

class _AllUrlsScreenState extends State<AllUrlsScreen> {
  UrlViewModel _urlViewModel = serviceLocator<UrlViewModel>();

  @override
  void initState() {
    _urlViewModel.loadData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ChangeNotifierProvider<UrlViewModel>(
          create: (context) => _urlViewModel,
          child:
              Consumer<UrlViewModel>(builder: (context, urlViewModel, child) {
            return Scaffold(
              appBar: AppBar(),
              body: _getWidget(constraints, context, urlViewModel),
              floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {},
                  label: Row(
                    children: [Icon(Icons.add), Text("Short a new url")],
                  )),
            );
          }));
    });
  }

  Widget _getWidget(BoxConstraints constraints, BuildContext context,
      UrlViewModel urlViewModel) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    if (urlViewModel.processing)
      return Center(
        child: CircularProgressIndicator(),
      );
    else if (urlViewModel.isError) {
      return Center(
        child: Text(urlViewModel.errorMessage),
      );
    } else {
      print(urlViewModel.urls);
      return (constraints.maxWidth > 800)
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
            );
    }
  }
}
