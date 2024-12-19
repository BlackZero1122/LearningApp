import 'package:flutter/material.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/models/hive_models/user.dart';
import 'package:learning_app/services/logging_service.dart';
import 'package:learning_app/services/pref_service.dart';

class GlobalService {
  PrefService get _prefService => locator<PrefService>();
  LoggingService get _loggingService => locator<LoggingService>();

  bool _isProduction = false;
  bool get isProduction => _isProduction;
  setIsProduction(bool isProduction) async {
    _isProduction = isProduction;
  }

  User? _user;

  User? get user => _user;

  setUser(User user) async {
    _user = user;
  }

  log(String message) {
    _loggingService.logInfo(message);
  }

  logError(String message, dynamic error, StackTrace? stack) {
    _loggingService.logError(message, error, stack);
  }

  logWarning(String message) {
    _loggingService.logWarning(message);
  }

  init() async {
    try {
      if (await _prefService.getBool(PrefKey.isProduction)) {
        setIsProduction(true);
      } else {
        setIsProduction(false);
      }
    } catch (e,s) {
      logError("Error Occured When Init Global Service", e.toString(), s);
      debugPrint(e.toString());
    }
  }

  Future<String> getHost() async {
    try {
      if (await _prefService.getBool(PrefKey.isProduction)) {
        return "https://connect360.azure-api.net";
      }
    } catch (e,s) {
      logError("Error Occured When get Host", e.toString(), s);
      debugPrint(e.toString());
    }
    return "https://connect360-stg.azure-api.net";
  }

}
