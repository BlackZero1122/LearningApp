// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/models/hive_models/activity.dart';
import 'package:learning_app/models/hive_models/lesson.dart';
import 'package:learning_app/models/hive_models/rules.dart';
import 'package:learning_app/models/hive_models/subject.dart';
import 'package:learning_app/models/message.dart';
import 'package:learning_app/services/api_service.dart';
import 'package:learning_app/services/auth_service.dart';
import 'package:learning_app/services/db_service.dart';
import 'package:learning_app/services/dialog_service.dart';
import 'package:learning_app/services/error_reporting_service.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/services/navigation_service.dart';
import 'package:learning_app/services/pref_service.dart';
import 'package:learning_app/view_models/base_view_model.dart';

class AuthenticationViewModel extends BaseViewModel {
  PrefService get _prefService => locator<PrefService>();
  IAPIService get _apiService => locator<IAPIService>();
  IErrorReportingService get _errorReportingService =>
      locator<IErrorReportingService>();
  NavigationService get _navigationService => locator<NavigationService>();
  GlobalService get _globalService => locator<GlobalService>();
  IDialogService get _dialogService => locator<IDialogService>();


  String? _email = "";
  String? _password = "";
  bool _showPassword = false;
  bool _isProduction = false;
  bool _rememberMe = false;

  String? get getEmail => _email;
  String? get getPassword => _password;
  bool get getShowPassword => _showPassword;
  bool get isProduction => _isProduction;
  bool get rememberMe => _rememberMe;

  setIsProduction(bool isProduction) async {
    _isProduction = isProduction;
    notifyListeners();
  }

  setRememberMe(bool rememberMe) async {
    _rememberMe = rememberMe;
    notifyListeners();
  }

  setShowPassword(bool showPassword) async {
    _showPassword = showPassword;
    notifyListeners();
  }

  setEmail(String email) async {
    _email = email;
  }

  setPassword(String password) async {
    _password = password;
  }

  void login(String email, String password) async {
    try {
      await loading(true);
      var result = await _apiService.login(email, password);
            if (result.errorCode == "PA0004") {
              _prefService.setBool(PrefKey.isLoggedIn, true);
              locator<NavigationService>().pushNamedAndRemoveUntil(
                      Routes.startup,
                      args: TransitionType.fade,
                                          );
            } else {
              await _errorReportingService.showError(result);
            }
    } catch (e, s) {
      _globalService.logError(
          "Error Occured When Client ($email) Login", e.toString(), s);
      debugPrint(e.toString());
    } finally {
      await loading(false);
    }
  }

  void signup(String name, String email, String password, String gender) async {
    try {
      await loading(true);
      var result = await _apiService.signup(name, email, password, gender);
            if (result.errorCode == "PA0004") {
              _dialogService.showToast(Message(description: "Account Created Successfuly."));
              locator<NavigationService>().pushNamedAndRemoveUntil(
                      Routes.login,
                      args: TransitionType.fade,
                                          );
            } else {
              await _errorReportingService.showError(result);
            }
    } catch (e, s) {
      _globalService.logError(
          "Error Occured When Client ($email) Login", e.toString(), s);
      debugPrint(e.toString());
    } finally {
      await loading(false);
    }
  }

  void loginViaGoogle(BuildContext context) async {
    try {
      await loading(true);
      var user = await AuthMService().signInWithGoogle(context);
                                      if(user!=null){
                                        _prefService.setBool(PrefKey.isLoggedIn, true);
                                        locator<NavigationService>().pushNamedAndRemoveUntil(
                      Routes.startup,
                      args: TransitionType.fade,
                                          );
                                      }
    } catch (e, s) {
      debugPrint(e.toString());
    } finally {
      await loading(false);
    }
  }

  void loginViaApple() async {
    try {
      await loading(true);
      var user = await AuthMService().signInWithApple();
                                      if(user!=null){
                                        _prefService.setBool(PrefKey.isLoggedIn, true);
                                        locator<NavigationService>().pushNamedAndRemoveUntil(
                      Routes.startup,
                      args: TransitionType.fade,
                                          );
                                      }
    } catch (e, s) {
      debugPrint(e.toString());
    } finally {
      await loading(false);
    }
  }
}
