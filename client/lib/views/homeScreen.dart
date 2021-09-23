/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urlshortnerclient/services/service_locator.dart';
import 'package:urlshortnerclient/viewModels/sessionViewModel.dart';
import 'package:urlshortnerclient/views/urls/allUrlsView.dart';
import 'package:urlshortnerclient/views/auth/authScreen.dart';
import 'package:urlshortnerclient/views/splashScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SessionViewModel _sessionViewModel = serviceLocator<SessionViewModel>();

  @override
  void initState() {
    super.initState();
    _sessionViewModel.verifyToken();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SessionViewModel>(
      create: (context) => _sessionViewModel,
      child: Consumer<SessionViewModel>(
        builder: (context, model, child) {
          if (model.isError) {
            print(model.errorMessage);
          }
          if (model.processing) {
            return SplashScreen();
          } else {
            if (model.user != null) {
              print(model.user!.token); 
              return AllUrlsScreen();
            } else {
              return AuthScreen();
            }
          }
        },
      ),
    );
  }
}
