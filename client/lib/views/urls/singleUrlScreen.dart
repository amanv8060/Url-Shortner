/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urlshortnerclient/models/urlModel.dart';
import 'package:urlshortnerclient/services/baseService.dart';
import 'package:urlshortnerclient/views/urls/editUrlView.dart';

class SingleUrlScreen extends StatefulWidget {
  final bool full;
  final UrlModel url;
  SingleUrlScreen({Key? key, required this.full, required this.url})
      : super(key: key);

  @override
  _SingleUrlScreenState createState() => _SingleUrlScreenState();
}

class _SingleUrlScreenState extends State<SingleUrlScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Single URL View"),
        ),
        body: _singleUrlMobile(context));
  }

  //Todo : Uncomment this when the graph is  ready

  // Widget _singleUrlDesktop(BuildContext context) {
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           Text(
  //             "Long Url : ",
  //             style: GoogleFonts.lato(
  //                 fontSize: Theme.of(context).textTheme.headline5!.fontSize),
  //           ),
  //           Text(widget.url.longUrl)
  //         ],
  //       ),
  //       Row(
  //         children: [
  //           Text("Shortened Url : "),
  //           Text(BaseService.BASE_URL + "/" + widget.url.shortUrl)
  //         ],
  //       ),
  //       Center(
  //         child: ElevatedButton(
  //             onPressed: () {
  //               Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) =>
  //                           EditUrlScreen(urlModel: widget.url)));
  //             },
  //             child: Text("Edit/Delete this URL")),
  //       )
  //     ],
  //   );
  // }

  Widget _singleUrlMobile(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
              title: Text(
                "Long Url : ",
                style: GoogleFonts.lato(
                    fontSize: Theme.of(context).textTheme.headline6!.fontSize),
              ),
              subtitle: Text(widget.url.longUrl,
                  style: GoogleFonts.lato(
                      fontSize:
                          Theme.of(context).textTheme.headline6!.fontSize))),
        ),
        Card(
          child: ListTile(
              title: Text(
                "Shortened Url : : ",
                style: GoogleFonts.lato(
                    fontSize: Theme.of(context).textTheme.headline6!.fontSize),
              ),
              subtitle: Text(BaseService.BASE_URL + "/" + widget.url.shortUrl,
                  style: GoogleFonts.lato(
                      fontSize:
                          Theme.of(context).textTheme.headline6!.fontSize))),
        ),
        SizedBox(
          height: 120,
        ),
        Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditUrlScreen(urlModel: widget.url)));
              },
              child: Text("Edit/Delete this URL")),
        )
      ],
    );
  }
}
