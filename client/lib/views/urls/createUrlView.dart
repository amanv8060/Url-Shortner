/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:flutter/material.dart';

class CreateUrlScreen extends StatefulWidget {
  CreateUrlScreen({Key? key}) : super(key: key);

  @override
  _CreateUrlScreenState createState() => _CreateUrlScreenState();
}

class _CreateUrlScreenState extends State<CreateUrlScreen> {
  late TextEditingController _longUrlController;

  late TextEditingController _aliasController;


  @override
  void initState() {
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Url"),
      ),
      body: Container(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
