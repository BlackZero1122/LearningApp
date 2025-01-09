import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/models/hive_models/api_queue.dart';
import 'package:learning_app/services/api_service.dart';
import 'package:learning_app/services/db_service.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/services/pref_service.dart';
import 'package:learning_app/view_models/app_status_bar_view_model.dart';
import 'package:learning_app/view_models/home_view_model.dart';
import 'package:learning_app/view_models/user_view_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

class ScheduleService {
  UserViewModel get _userViewModel => locator<UserViewModel>();
  IAPIService get _apiService => locator<IAPIService>();
  PrefService get _prefService => locator<PrefService>();
  GlobalService get _globalService => locator<GlobalService>();
  AppStatusBarViewModel get _appStatusBarViewModel =>
      locator<AppStatusBarViewModel>();
  HomeViewModel get _homeViewModel => locator<HomeViewModel>();
  final StreamController<APIQueue> _queue = StreamController<APIQueue>();
  int counter = 0;
  List<String> currentQueue = [];

  init() async {
    startQueue();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) async {
      if (await _prefService.getBool(PrefKey.isLoggedIn) &&
          await _prefService.getBool(PrefKey.isSetupComplete)) {
        await checkInternetConnection();
        if (counter > 30) {
          startSyncProcess();
          counter = 0;
        }
      }
      counter = counter + 1;
    });
  }

  Future<void> startSyncProcess() async {
    var datas = await locator<IHiveService<APIQueue>>().getAll();
    for (var data in datas) {
      data.keyId = data.key;
      await addToQueue(data);
    }
  }

   bool checkInternetConnectionInProgress = false;
  Future<void> checkInternetConnection() async {
    if (checkInternetConnectionInProgress) {
      return;
    }
    try {
      checkInternetConnectionInProgress = true;
      Map map = {};
      map['val0'] = RootIsolateToken.instance!;
      var data = await compute(_checkInternetConnectionInBackground, map);
      if (data['val0'] != null) {
        if(data['val0']){
          if(!_globalService.connectedToInternet){
            _globalService.log("Connected To Internet");
            _globalService.setConnectedToInternet(true);
            _appStatusBarViewModel.setConnectedToInternet(true);
          }
        }
        else{
          if(_globalService.connectedToInternet){
            _globalService.log("Disconnect From Internet");
            _globalService.setConnectedToInternet(false);
            _appStatusBarViewModel.setConnectedToInternet(false);
          }
        }
      }
    } catch (e, s) {
      _globalService.logError("Error Occured When Check for Internet Connection", e.toString(), s);
      debugPrint(e.toString());
    } finally {
      checkInternetConnectionInProgress = false;
    }
  }

  Future<void> startQueue() async {
    // Spin up a Future to consume the StreamController
    Future<void> t2 = Future(() async {
      // Consume consume the StreamController
      await for (final data in _queue.stream) {
        await process(data);
        currentQueue.remove(data.id);
      }
    });

    await Future.wait([t2]);
  }

  Future<void> addToQueue(APIQueue data) async {
    try {
      var inQueue = currentQueue.where((x) => x == data.id).firstOrNull;
      if (inQueue == null) {
        currentQueue.add(data.id);
        _queue.add(APIQueue(
            param: data.param,
            id: data.id,
            data: data.data,
            type: data.type,
            keyId: data.keyId,
            printed: data.printed));
      }
    } catch (e, s) {
      _globalService.logError("Error Occured While Adding data to Queue", e.toString(), s);
      debugPrint(e.toString());
    }
  }

  Future<void> process(APIQueue data) async {
    try {
      switch (data.type) {
        case 0: 
          {
            
          }
          break;
        default:
      }
    } catch (e, s) {
      _globalService.logError("Error Occured When Process Queue data", e.toString(), s);
      debugPrint(e.toString());
    }
  }

}

// ISOLATES

Future<Map<String, dynamic>> _checkInternetConnectionInBackground(
    Map map) async {
  var isolateToken = map['val0'];
  BackgroundIsolateBinaryMessenger.ensureInitialized(isolateToken);
  Map<String, dynamic> sendMap = {};
  sendMap['val0'] = false;

  sendMap['val0'] = await SimpleConnectionChecker.isConnectedToInternet();

  return sendMap;
}

// ISOLATES