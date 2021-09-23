/*
MIT License

Copyright (c) 2019 Slah Layouni

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTI CULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 */

import 'package:flutter/material.dart';

class ScalingQuery {
  final _guidelineBaseWidth = 350;
  final _guidelineBaseHeight = 680;

  var _shortDimension;
  var _longDimension;

  ScalingQuery(context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    this._shortDimension = width < height ? width : height;
    this._longDimension = width < height ? height : width;
  }



  double scale(double size) {
    return this._shortDimension / this._guidelineBaseWidth * size;
  }

  double verticalScale(double size) {
    return this._longDimension / this._guidelineBaseHeight * size;
  }

  double moderateScale(double size, [double factor = 0.5]) {
    return size + (scale(size) - size) * factor;
  }

  double hp(size) {
    return (this._longDimension * size) / 100;
  }

  double wp(size) {
    return (this._shortDimension * size) / 100;
  }
}