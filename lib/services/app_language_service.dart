import 'package:flutter/material.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/services/pref_service.dart';

class AppLanguageService extends ChangeNotifier {

  PrefService get _prefService => locator<PrefService>();

  Locale _appLocale = const Locale('en');

  Locale get appLocal => _appLocale;
  fetchLocale() async {
     var lang = await _prefService.getString(PrefKey.lang);
    if (lang == "") {
      _appLocale = const Locale('en');
      return Null;
    }
   
    _appLocale = Locale(lang);
    return Null;
  }


  void changeLanguage(Locale type) async {
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale("fr")) {
      _appLocale = const Locale("fr");
      await _prefService.setString(PrefKey.lang, 'fr');
    } else {
      _appLocale = const Locale("en");
      await _prefService.setString(PrefKey.lang, 'en');
    }
    notifyListeners();
  }
}