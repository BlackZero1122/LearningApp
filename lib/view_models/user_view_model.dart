import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/models/hive_models/user.dart';
import 'package:learning_app/services/api_service.dart';
import 'package:learning_app/services/dialog_service.dart';
import 'package:learning_app/services/error_reporting_service.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/services/navigation_service.dart';
import 'package:learning_app/services/pref_service.dart';
import 'package:learning_app/view_models/authentication_view_model.dart';
import 'package:learning_app/view_models/base_view_model.dart';

class UserViewModel extends BaseViewModel {
  IAPIService get _apiService => locator<IAPIService>();
  PrefService get _prefService => locator<PrefService>();
  GlobalService get _globalService => locator<GlobalService>();
  IErrorReportingService get _errorReportingService =>
      locator<IErrorReportingService>();
  IDialogService get _dialogService => locator<IDialogService>();
  AuthenticationViewModel get _authenticationViewModel =>
      locator<AuthenticationViewModel>();
  NavigationService get _navigationService => locator<NavigationService>();

  User? _user;
  User? get user => _user;
  setUser(User user) async {
    _user = user;
  }

  Future getDataFromLocal() async {
    try {
      
    } catch (e,s) {
      _globalService.logError("Error Occured When get Data From Local", e.toString(), s);
    }
  }
  
}
