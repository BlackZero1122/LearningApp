import 'package:flutter/cupertino.dart';
import 'package:learning_app/helpers/app_localizations.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/models/tab.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/services/navigation_service.dart';
import 'package:learning_app/view_models/base_view_model.dart';
import 'package:learning_app/view_models/home_view_model.dart';
import 'package:learning_app/view_models/setting_view_model.dart';

class SideDrawerViewModel extends BaseViewModel {

  NavigationService get _navigationService => locator<NavigationService>();
  SettingViewModel get _settingViewModel => locator<SettingViewModel>();
  GlobalService get _globalService => locator<GlobalService>();

  List<Tab>? _tabs = [];

  List<Tab>? get getTabs => _tabs;

  setTabs(List<Tab>? tabs) async {
    _tabs = tabs;
    notifyListeners();
  }

  SideDrawerViewModel() {
    _tabs = [
      Tab(
          text: AppLocalizations.instance.translate('home'),
          icon: 'home',
          index: 0,
          selectedTab: true),
      Tab(
          text: "Notifications",
          icon: 'notification',
          index: 1),
      Tab(
          text: AppLocalizations.instance.translate('settings'),
          icon: 'settings',
          index: 2),
          Tab(
          text: AppLocalizations.instance.translate('logout'),
          icon: 'logout',
          index: 3)
    ];
  }

  reset(){
    _tabs![0].selectedTab = true;
  }

  selectTab(int index) async {
    try {
      int? selectedIndex =
          _tabs!.where((element) => element.selectedTab).firstOrNull?.index??0;
      for (var element in _tabs!) {
        element.selectedTab = false;
      }
      if(index!=3){
        _tabs![index].selectedTab = true;
      }
      else{
        _tabs![selectedIndex].selectedTab = true;
      }
      if (selectedIndex != index) {
        switch (index) {
          case 0:
            {
              await _navigationService.pushNamedAndRemoveUntil(
                  Routes.home,
                  args: TransitionType.fade);
            }
            break;
          case 1:
            {
              await _navigationService.pushNamedAndRemoveUntil(
                  Routes.notifications,
                  args: TransitionType.fade);
            }
            break;
          case 2:
            {
              _settingViewModel.selectMainTab(0);
              await _navigationService.pushNamedAndRemoveUntil(
                  Routes.settings,
                  args: TransitionType.fade);
            }
            break;
            case 3:
            {
              await locator<HomeViewModel>().logout();
            }
            break;
          default:
        }
      }
      else{
        _navigationService.pop();
      }
    } catch (e,s) {
      _globalService.logError("Error Occured! When Select Navigation Tab", e.toString(), s);
      debugPrint(e.toString());
    }
  }
}
