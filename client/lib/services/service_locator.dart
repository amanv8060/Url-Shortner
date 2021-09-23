/*
Copyright 2021 Aman Verma. All rights reserved.
Use of this source code is governed by a MIT license that can be
found in the LICENSE file.
*/

import 'package:get_it/get_it.dart';
import 'package:urlshortnerclient/services/authService.dart';
import 'package:urlshortnerclient/services/urlService.dart';
import 'package:urlshortnerclient/viewModels/authViewModel.dart';
import 'package:urlshortnerclient/viewModels/urlViewModel.dart';
import 'package:urlshortnerclient/viewModels/sessionViewModel.dart';
import 'package:urlshortnerclient/viewModels/urlsViewModel.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<UrlService>(() => UrlService());
  serviceLocator.registerLazySingleton<AuthService>(() => AuthService());


  serviceLocator.registerFactory<UrlViewModel>(() => UrlViewModel());
  serviceLocator.registerFactory<UrlsViewModel>(() => UrlsViewModel());
  serviceLocator.registerFactory<AuthViewModel>(() => AuthViewModel());
  serviceLocator.registerFactory<SessionViewModel>(() => SessionViewModel());
}
