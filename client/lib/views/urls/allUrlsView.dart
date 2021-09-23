/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urlshortnerclient/services/service_locator.dart';
import 'package:urlshortnerclient/viewModels/urlsViewModel.dart';
import 'package:urlshortnerclient/views/urls/createUrlView.dart';
import 'package:urlshortnerclient/widgets/listViewUrlWidget.dart';

class AllUrlsScreen extends StatefulWidget {
  AllUrlsScreen({Key? key}) : super(key: key);

  @override
  _AllUrlsScreenState createState() => _AllUrlsScreenState();
}

class _AllUrlsScreenState extends State<AllUrlsScreen> {
  UrlsViewModel _urlViewModel = serviceLocator<UrlsViewModel>();

  @override
  void initState() {
    _urlViewModel.loadData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ChangeNotifierProvider<UrlsViewModel>(
          create: (context) => _urlViewModel,
          child:
              Consumer<UrlsViewModel>(builder: (context, urlViewModel, child) {
            return Scaffold(
              appBar: AppBar(),
              body: _getWidget(constraints, context, urlViewModel),
              floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateUrlScreen()));
                  },
                  label: Row(
                    children: [Icon(Icons.add), Text("Short a new url")],
                  )),
            );
          }));
    });
  }

  Widget _getWidget(
    BoxConstraints constraints,
    BuildContext context,
    UrlsViewModel urlViewModel,
  ) {
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
      if (urlViewModel.urls.length == 0) {
        return Container(
          width: _width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("You have no urls"),
              SizedBox(height: 10),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateUrlScreen()));
                  },
                  child: Text("Create one now"))
            ],
          ),
        );
      }
      return Column(
        children: [
          Center(
              child: Text(urlViewModel.urls.length.toString() +
                  " urls shortned so far")),
          (constraints.maxWidth > 1000)
              ? Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: _height / 125,
                      children: List.generate(
                          urlViewModel.urls.length,
                          (index) => ListViewUrlWidget(
                                url: urlViewModel.urls[index],
                                index: index,
                                full: true,
                              ))),
                )
              : Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListViewUrlWidget(
                        url: urlViewModel.urls[index],
                        index: index,
                        full: false,
                      );
                    },
                    itemCount: urlViewModel.urls.length,
                  ),
                )
        ],
      );
    }
  }
}
