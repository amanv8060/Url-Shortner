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

class SignUpView extends StatefulWidget {
  final bool full;
  final Function(bool val) onPressed;
  SignUpView({
    Key? key,
    this.full = true,
    required this.onPressed,
  }) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;

  late GlobalKey<FormState> _formKey;

  final AuthViewModel _authViewModel = serviceLocator<AuthViewModel>();
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _nameController = new TextEditingController();
    _passwordController = new TextEditingController();
    _emailController = new TextEditingController();
    _formKey = new GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<AuthViewModel>(
      create: (context) => _authViewModel,
      child: Consumer<AuthViewModel>(builder: (context, model, child) {
        return widget.full
            ? _signUpViewDesktop(model, _height, _width)
            : _signUpViewMobile(model, _height, _width);
      }),
    );
  }

  Widget _signUpViewDesktop(
      AuthViewModel model, double _height, double _width) {
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

  Widget _signUpViewMobile(AuthViewModel model, double _height, double _width) {
    return Container(
        height: _height * 0.75,
        padding: EdgeInsets.symmetric(
          horizontal: _width * 0.1,
        ),
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
    return Form(key: _formKey, child: _getFormElements(model, _height, _width));
  }

  Widget _getFormElements(AuthViewModel model, double _height, double _width) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
            child: Text(
          "Create an Account",
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Name",
              style: GoogleFonts.lato(),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _nameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Name";
                } else if (value.length < 3) {
                  "Please Enter Valid Name";
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
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

                          await model.signUp(_emailController.text,
                              _passwordController.text, _nameController.text);
                          if (model.signUpSuccess) {
                            widget.onPressed(true);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Sign Up success , please Sign In ")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error Occurred")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Please Enter Valid Data")));
                          // Fluttertoast.showToast(msg: "Please Enter Valid Data");
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
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
