import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/models/tab.dart';
import 'package:learning_app/services/api_service.dart';
import 'package:learning_app/services/dialog_service.dart';
import 'package:learning_app/services/error_reporting_service.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/services/navigation_service.dart';
import 'package:learning_app/view_models/app_status_bar_view_model.dart';
import 'package:learning_app/view_models/base_view_model.dart';
import 'package:learning_app/view_models/user_view_model.dart';

class SettingViewModel extends BaseViewModel {
  IErrorReportingService get _errorReportingService =>
      locator<IErrorReportingService>();
  IDialogService get _dialogService => locator<IDialogService>();
  IAPIService get _apiService => locator<IAPIService>();
  UserViewModel get _userViewModel => locator<UserViewModel>();
  GlobalService get _globalService => locator<GlobalService>();
  AppStatusBarViewModel get _appStatusBarViewModel => locator<AppStatusBarViewModel>();
  NavigationService get _navigationService => locator<NavigationService>();

  List<Tab> tabs = [];
  int? selectedMainTabIndex;
  int? selectedSubTabIndex;

  List<Tab> get getTabs => tabs;

  SettingViewModel() {
    tabs = [
      Tab(text: "Business", icon: 'work_outline_outlined', index: 0),
      Tab(text: "Location", icon: 'location_city_outlined', index: 1),
      Tab(text: "Register", icon: 'computer_outlined', index: 2),
      Tab(text: "Configuration", icon: 'settings', index: 3, subTabs: [
        Tab(text: "Invoice", icon: 'receipt', index: 0),
        Tab(text: "Tax", icon: 'list_outlined', index: 1),
        Tab(text: "Printing", icon: 'printing', index: 2),
        Tab(text: "Cash Drawer", icon: 'credit_card_outlined', index: 3),
        Tab(text: "Cash Drop", icon: 'money_outlined', index: 4),
        Tab(text: "Security", icon: 'lock', index: 5),
        Tab(text: "Tender", icon: 'people_alt_outlined', index: 6),
        Tab(text: "Electronic Tender", icon: 'trip_origin', index: 7),
        Tab(text: "Time Tracking", icon: 'time', index: 8),
        Tab(text: "Reporting", icon: 'warning_amber', index: 9),
      ]),
      Tab(text: "User Security", icon: 'security', index: 4),
    ];

    // Set the first tab as selected initially
    selectedMainTabIndex = 0;
    tabs[selectedMainTabIndex!].setSelected(true);
    notifyListeners();
  }

  void selectMainTab(int mainTabIndex) async {
    try {
      if (selectedMainTabIndex != null) {
        tabs[selectedMainTabIndex!].setSelected(false);
        for (var subTab in tabs[selectedMainTabIndex!]
              .subTabs) {
          subTab.setSelected(false);
        }
      }

      selectedMainTabIndex = mainTabIndex;
      tabs[selectedMainTabIndex!].setSelected(true);
      selectedSubTabIndex = null; // Reset sub-tab selection
      await getSettings();
    } catch (e,s) {
      _globalService.logError("Error Occured When Select Tab", e.toString(), s);
    }
    finally{
      notifyListeners();
    }
  }

  void selectSubTab(int mainTabIndex, int subTabIndex) async {
    try {
      if (selectedMainTabIndex != mainTabIndex) {
        selectMainTab(
            mainTabIndex); // Select the main tab if not already selected
      }

      if (selectedSubTabIndex != null) {
        tabs[mainTabIndex].subTabs[selectedSubTabIndex!].setSelected(false);
      }

      selectedSubTabIndex = subTabIndex;
      tabs[mainTabIndex].subTabs[selectedSubTabIndex!].setSelected(true);
      await getSettings();
    } catch (e,s) {
      _globalService.logError("Error Occured When Select Tab", e.toString(), s);
    }
    finally{
      notifyListeners();
    }
  }

  Future getSettings() async {
    try {
      
    } catch (e,s) {
      _globalService.logError("Error Occured When Get Settings", e.toString(), s);
    }
  }
  
}
