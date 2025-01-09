import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/services/app_language_service.dart';
import 'package:learning_app/view_models/activity_view_model.dart';
import 'package:learning_app/view_models/app_status_bar_view_model.dart';
import 'package:learning_app/view_models/authentication_view_model.dart';
import 'package:learning_app/view_models/home_view_model.dart';
import 'package:learning_app/view_models/setting_view_model.dart';
import 'package:learning_app/view_models/side_drawer_view_model.dart';
import 'package:learning_app/view_models/startup_viewmodel.dart';
import 'package:learning_app/view_models/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderInjector {
  static List<SingleChildWidget> providers = [
    ..._independentServices,
    ..._dependentServices,
    ..._consumableServices,
  ];

  static final List<SingleChildWidget> _independentServices = [
    // ViewModels
    ChangeNotifierProvider(create: (_) => locator<HomeViewModel>()),
    ChangeNotifierProvider(create: (_) => locator<StartupViewModel>()),
    ChangeNotifierProvider(create: (_) => locator<AuthenticationViewModel>()),
    ChangeNotifierProvider(create: (_) => locator<SettingViewModel>()),
    ChangeNotifierProvider(create: (_) => locator<UserViewModel>()),
    ChangeNotifierProvider(create: (_) => locator<SideDrawerViewModel>()),
    ChangeNotifierProvider(create: (_) => locator<AppStatusBarViewModel>()),
    ChangeNotifierProvider(create: (_) => locator<ActivityViewModel>()),

    // // Services
    ChangeNotifierProvider(create: (_) => locator<AppLanguageService>()),
  ];

  static final List<SingleChildWidget> _dependentServices = [];
  
  static final List<SingleChildWidget> _consumableServices = [];
}