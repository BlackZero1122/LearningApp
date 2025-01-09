import 'package:get_it/get_it.dart';
import 'package:learning_app/models/hive_models/api_queue.dart';
import 'package:learning_app/models/hive_models/progress.dart';
import 'package:learning_app/models/hive_models/subject.dart';
import 'package:learning_app/models/hive_models/todo.dart';
import 'package:learning_app/models/hive_models/user.dart';
import 'package:learning_app/models/hive_models/version_info.dart';
import 'package:learning_app/repos/api_queue_repo.dart';
import 'package:learning_app/repos/progress_repo.dart';
import 'package:learning_app/repos/subject_repo.dart';
import 'package:learning_app/repos/todo_repo.dart';
import 'package:learning_app/repos/user_repo.dart';
import 'package:learning_app/repos/version_info_repo.dart';
import 'package:learning_app/services/api_service.dart';
import 'package:learning_app/services/app_language_service.dart';
import 'package:learning_app/services/db_service.dart';
import 'package:learning_app/services/device_info_service.dart';
import 'package:learning_app/services/dialog_service.dart';
import 'package:learning_app/services/error_reporting_service.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/services/http_service.dart';
import 'package:learning_app/services/logging_service.dart';
import 'package:learning_app/services/navigation_service.dart';
import 'package:learning_app/services/network_service.dart';
import 'package:learning_app/services/pref_service.dart';
import 'package:learning_app/services/schedule_service.dart';
import 'package:learning_app/services/tts_service.dart';
import 'package:learning_app/view_models/activity_view_model.dart';
import 'package:learning_app/view_models/app_status_bar_view_model.dart';
import 'package:learning_app/view_models/authentication_view_model.dart';
import 'package:learning_app/view_models/home_view_model.dart';
import 'package:learning_app/view_models/setting_view_model.dart';
import 'package:learning_app/view_models/side_drawer_view_model.dart';
import 'package:learning_app/view_models/startup_viewmodel.dart';
import 'package:learning_app/view_models/user_view_model.dart';

GetIt locator = GetIt.instance;

class LocatorInjector {
  static Future<void> setupLocator() async {
    // Services
    locator.registerLazySingleton(() => NavigationService());
    locator.registerLazySingleton(() => GlobalService());
    locator.registerLazySingleton(() => ScheduleService());
    locator.registerLazySingleton(() => PrefService());
    locator.registerLazySingleton(() => AppLanguageService());
    locator.registerLazySingleton(() => HttpService());
    locator.registerLazySingleton<INetworkService>(() => NetworkService());
    locator.registerLazySingleton<IAPIService>(() => APIService());
    locator.registerLazySingleton<IDialogService>(() => DialogService());
    locator.registerLazySingleton<IErrorReportingService>(
        () => ErrorReportingService());
    locator.registerLazySingleton(() => LoggingService());
    locator.registerLazySingleton(() => TTSService());
    locator.registerLazySingleton<IDeviceInfoService>(() => DeviceInfoService());

    // ViewModels
    locator.registerLazySingleton(() => HomeViewModel());
    locator.registerLazySingleton(() => StartupViewModel());
    locator.registerLazySingleton(() => AuthenticationViewModel());
    locator.registerLazySingleton(() => SettingViewModel());
    locator.registerLazySingleton(() => UserViewModel());
    locator.registerLazySingleton(() => SideDrawerViewModel());
    locator.registerLazySingleton(() => AppStatusBarViewModel());
    locator.registerLazySingleton(() => ActivityViewModel());

    // Repos
    locator.registerLazySingleton<IHiveService<Todo>>(() => TodoRepo());
    locator.registerLazySingleton<IHiveService<User>>(() => UserRepo());
    locator.registerLazySingleton<IHiveService<VersionInfo>>(() => VersionInfoRepo());
    locator.registerLazySingleton<IHiveService<APIQueue>>(() => APIQueueRepo());
    locator.registerLazySingleton<IHiveService<Subject>>(() => SubjectRepo());
    locator.registerLazySingleton<IHiveService<Progress>>(() => ProgressRepo());
  }
}