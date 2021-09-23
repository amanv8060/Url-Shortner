/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:urlshortnerclient/utils/appTheme.dart';
import 'package:urlshortnerclient/views/auth/signInView.dart';
import 'package:urlshortnerclient/views/auth/signUpView.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _signIn = true;
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1024) {
        return Stack(children: <Widget>[
          Row(children: <Widget>[
            Container(
              width: 0.35 * _width,
              decoration: BoxDecoration(
                color: AppTheme.black,
              ),
            ),
            Container(
              width: 0.65 * _width,
              decoration: BoxDecoration(
                color: AppTheme.blue,
              ),
            )
          ]),
          _getDesktopView(_height, _width)
        ]);
      } else {
        return _getMobileView(_height, _width);
      }
    }));
  }

  void _switch() {
    setState(() {
      _signIn = !_signIn;
    });
  }

  void _update(bool val) {
    setState(() {
      _signIn = val;
    });
  }

  Widget _getDesktopView(
    double _height,
    double _width,
  ) {
    return Container(
      height: _height,
      width: _width,
      padding: EdgeInsets.symmetric(
          vertical: _height * 0.1, horizontal: _width * 0.1),
      child: Row(
        children: [
          Container(
            width: _width * 0.25,
            decoration: BoxDecoration(
              color: AppTheme.mediumTurquoise,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Lottie.asset('assets/animations/logoAnimated.json',
                      fit: BoxFit.contain),
                ),
                Center(
                  child: Text("Url Shortner",
                      style: GoogleFonts.lato(
                          fontSize: _width * 0.02,
                          fontWeight: FontWeight.bold)),
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: _switch,
                        child: _signIn ? Text("Sign Up") : Text("Sign in")))
              ],
            ),
          ),
          _signIn
              ? SignInView(
                  full: true,
                )
              : SignUpView(
                  full: true,
                  onPressed: _update,
                ),
        ],
      ),
    );
  }

  Widget _getMobileView(double _height, double _width) {
    return Container(
      height: _height,
      width: _width,
      child: Container(
        width: _width,
        decoration: BoxDecoration(
          color: AppTheme.mediumTurquoise,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _signIn
                ? SignInView(
                    full: false,
                  )
                : SignUpView(
                    full: false,
                    onPressed: _update,
                  ),
            Center(
                child: ElevatedButton(
                    onPressed: _switch,
                    child: _signIn ? Text("Sign Up") : Text("Sign in")))
          ],
        ),
      ),
    );
  }
}
