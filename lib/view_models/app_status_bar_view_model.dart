

import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/view_models/base_view_model.dart';

class AppStatusBarViewModel extends BaseViewModel{

  GlobalService get _globalService => locator<GlobalService>();

  bool get isProduction => _globalService.isProduction;

  bool _connectedToInternet=true;
  bool get connectedToInternet => _connectedToInternet;
  setConnectedToInternet(bool connectedToInternet) async {
    _connectedToInternet = connectedToInternet;
    notifyListeners();
  }
}