/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:urlshortnerclient/services/service_locator.dart';
import 'package:urlshortnerclient/utils/appTheme.dart';
import 'package:urlshortnerclient/viewModels/authViewModel.dart';
import 'package:urlshortnerclient/views/homeScreen.dart';

class SignInView extends StatefulWidget {
  final bool full;
  SignInView({
    Key? key,
    this.full = true,
  }) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final AuthViewModel _authViewModel = serviceLocator<AuthViewModel>();

  late GlobalKey<FormState> _formKey;
  bool _visible = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _formKey = new GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<AuthViewModel>(
      create: (context) => _authViewModel,
      child: Consumer<AuthViewModel>(
        builder: (context, model, child) {
          return widget.full
              ? _signInViewDesktop(model, _height, _width)
              : _signInViewMobile(model, _height, _width);
        },
      ),
    );
  }

  Widget _signInViewDesktop(
    AuthViewModel model,
    double _height,
    double _width,
  ) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: _width * 0.1, vertical: _height * 0.1),
        width: _width * 0.55,
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Stack(children: [
          _getForm(model, _height, _width),
          model.processing
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox()
        ]));
  }

  Widget _signInViewMobile(
    AuthViewModel model,
    double _height,
    double _width,
  ) {
    return Container(
        height: _height * 0.75,
        padding: EdgeInsets.symmetric(
            horizontal: _width * 0.1, vertical: _height * 0.05),
        width: _width * 0.95,
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Stack(children: [
          _getForm(model, _height, _width),
          model.processing
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox()
        ]));
  }

  Widget _getForm(AuthViewModel model, double _height, double _width) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            "Welcome Back",
            style: GoogleFonts.lato(
                fontSize: _height * 0.05, fontWeight: FontWeight.bold),
          )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Email",
                style: GoogleFonts.lato(),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _emailController,
                validator: model.validateEmail,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Password",
                style: GoogleFonts.lato(),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: !_visible,
                validator: model.validatePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  suffixIcon: IconButton(
                    icon: _visible
                        ? Icon(Icons.remove_red_eye)
                        : Icon(Icons.remove_red_eye_outlined),
                    color: _visible ? Colors.red : Colors.blue,
                    onPressed: () {
                      setState(() {
                        _visible = !_visible;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Center(
              child: ElevatedButton(
                  onPressed: model.processing
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await model.signIn(
                              _emailController.text,
                              _passwordController.text,
                            );
                            if (model.user != null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Sign In Success"),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Error Occurred"),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please Enter Valid Data"),
                              ),
                            );
                          }
                        },
                  child: Text(
                    "Continue",
                    style: GoogleFonts.lato(),
                  ))),
          _authViewModel.isError
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _authViewModel.errorMessage,
                      style: GoogleFonts.lato(
                        color: Colors.red,
                      ),
                      softWrap: true,
                    )
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
