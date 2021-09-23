/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urlshortnerclient/services/baseService.dart';
import 'package:urlshortnerclient/services/service_locator.dart';
import 'package:urlshortnerclient/utils/scalingQuery.dart';
import 'package:urlshortnerclient/viewModels/urlViewModel.dart';
import 'package:urlshortnerclient/views/homeScreen.dart';
import 'package:urlshortnerclient/views/urls/allUrlsView.dart';

class CreateUrlScreen extends StatefulWidget {
  CreateUrlScreen({Key? key}) : super(key: key);

  @override
  _CreateUrlScreenState createState() => _CreateUrlScreenState();
}

class _CreateUrlScreenState extends State<CreateUrlScreen> {
  final UrlViewModel _urlViewModel = serviceLocator<UrlViewModel>();

  late TextEditingController _longUrlController;

  late TextEditingController _aliasController;

  late GlobalKey<FormState> _formKey;

  late ScalingQuery _scalingQuery;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _formKey = new GlobalKey<FormState>();
    _longUrlController = new TextEditingController();
    _aliasController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    _scalingQuery = new ScalingQuery(context);

    return ChangeNotifierProvider<UrlViewModel>(
        create: (context) => _urlViewModel,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Create New Url"),
          ),
          body: Stack(
            children: [
              _getForm(_height, _width),
              _isVisible
                  ? Consumer<UrlViewModel>(builder: (context, model, child) {
                      return _getPopUps(context, model);
                    })
                  : SizedBox()
            ],
          ),
        ));
  }

  Widget _getForm(double _height, double _width) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _width * 0.05),
      child: Card(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Enter the url to shorten"),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _longUrlController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Enter alias"),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _aliasController,
                    decoration: InputDecoration(
                        prefixText: BaseService.BASE_URL + "/",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  )
                ],
              ),
              ElevatedButton(
                  child: Text("Short It"),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isVisible = true;
                      });
                      _formKey.currentState!.save();
                      _urlViewModel.createUrl(
                          _longUrlController.text, _aliasController.text);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPopUps(BuildContext context, UrlViewModel model) {
    if (model.processing) {
      return Center(
        child: Container(
          width: _scalingQuery.scale(200),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Please Wait",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          Theme.of(context).textTheme.headline6!.fontSize),
                ),
                LinearProgressIndicator()
              ],
            ),
          ),
        ),
      );
    } else {
      if (model.isError) {
        return Center(
          child: Container(
            width: _scalingQuery.scale(200),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Error Occurred",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            Theme.of(context).textTheme.headline5!.fontSize),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(model.errorMessage),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = false;
                        });
                      },
                      child: Text("OKAY"),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      } else {
        return Center(
          child: Container(
            width: _scalingQuery.scale(200),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Short Url Created",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            Theme.of(context).textTheme.headline5!.fontSize),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isVisible = false;
                          });
                        },
                        child: Text("Short New",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .fontSize)),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllUrlsScreen()),
                                (route) => false);
                          });
                        },
                        child: Text("Go Back to Home",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .fontSize)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    }
  }
}
