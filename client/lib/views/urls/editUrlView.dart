/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urlshortnerclient/models/urlModel.dart';
import 'package:urlshortnerclient/services/baseService.dart';
import 'package:urlshortnerclient/services/service_locator.dart';
import 'package:urlshortnerclient/services/urlService.dart';
import 'package:urlshortnerclient/utils/scalingQuery.dart';
import 'package:urlshortnerclient/viewModels/sessionViewModel.dart';
import 'package:urlshortnerclient/viewModels/urlViewModel.dart';
import 'package:urlshortnerclient/views/homeScreen.dart';
import 'package:urlshortnerclient/views/urls/createUrlView.dart';

class EditUrlScreen extends StatefulWidget {
  final UrlModel urlModel;
  EditUrlScreen({Key? key, required this.urlModel}) : super(key: key);

  @override
  _EditUrlScreenState createState() => _EditUrlScreenState();
}

class _EditUrlScreenState extends State<EditUrlScreen> {
  final UrlViewModel _urlViewModel = serviceLocator<UrlViewModel>();

  late TextEditingController _longUrlController;

  late TextEditingController _aliasController;

  late GlobalKey<FormState> _formKey;

  late ScalingQuery _scalingQuery;
  int _isVisible = 0;
  bool _update = false;

  @override
  void initState() {
    super.initState();
    _formKey = new GlobalKey<FormState>();
    _longUrlController =
        new TextEditingController(text: widget.urlModel.longUrl);
    _aliasController =
        new TextEditingController(text: widget.urlModel.shortUrl);
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
            title: Text("Edit Url"),
          ),
          body: IndexedStack(
            index: _isVisible,
            children: [
              _getForm(_height, _width),
              Consumer<UrlViewModel>(builder: (context, model, child) {
                return Container(
                    color: Colors.blue[100], child: _getPopUps(context, model));
              })
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
                    readOnly: true,
                    controller: _aliasController,
                    decoration: InputDecoration(
                        prefixText: BaseService.BASE_URL + "/",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  )
                ],
              ),
              ElevatedButton(
                  child: Text("Update"),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isVisible = 1;
                        _update = true;
                      });
                      _formKey.currentState!.save();
                      _urlViewModel.editUrl(
                          _longUrlController.text, widget.urlModel.id!);
                    }
                  }),
              ElevatedButton(
                  child: Text("Delete"),
                  onPressed: () async {
                    setState(() {
                      _isVisible = 1;
                      _update = false;
                    });
                    _urlViewModel.deleteUrl(widget.urlModel.id!);
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
                          _isVisible = 0;
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
                    _update ? "Short Url Edited" : "Short Url Deleted",
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
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateUrlScreen()));
                        },
                        child: Text("Short New"),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (route) => false);
                          });
                        },
                        child: Text("Go Back to Home"),
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
