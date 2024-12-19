import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class DeviceInfoService implements IDeviceInfoService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  @override
  Future<int> deviceType(BuildContext context) async {
    if (Platform.isAndroid) {
      if(context.mounted){
        bool isPhone= MediaQuery.of(context).size.shortestSide < 600;
        return isPhone ? 0 : 1;
      }
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      bool isTablet = iosInfo.model.toLowerCase().contains("ipad");
      return isTablet ? 1 : 0;
    }
    return 1;
  }

  @override
  Future<String> deviceModel() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      return iosInfo.model;
    }
    return 'Unknown Device';
  }
}

abstract class IDeviceInfoService {
  Future<int> deviceType(BuildContext context);
  Future<String> deviceModel();
}