/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:urlshortnerclient/models/userModel.dart';

///[SessionAuth] is a Singleton class that is used to store [authToken]
/// for a entire lifecycle of the app
class SessionAuth {
  static final SessionAuth _singleton = SessionAuth._internal();
  factory SessionAuth() => _singleton;
  SessionAuth._internal();

  ///getter to get the class instance
  static SessionAuth get shared => _singleton;

  ///[user] is used to store the 
  ///data that we get from [SharedPreferences]
  UserModel? user;
}