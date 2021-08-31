/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 480) {
        return Stack(children: [
          Container(
              child: Lottie.asset('assets/animations/pageNotFoundDesktop.json',
                  fit: BoxFit.fill),
              height: _height,
              width: _width)
        ]);
      } else {
        return Container(
            child: Lottie.asset('assets/animations/pageNotFoundMobile.json',
                fit: BoxFit.fill),
            height: _height,
            width: _width);
      }
   }));
  }
}
