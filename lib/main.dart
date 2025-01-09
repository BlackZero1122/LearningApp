import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:learning_app/custom_widgets/session_listener.dart';
import 'package:learning_app/firebase_options.dart';
import 'package:learning_app/helpers/app_localizations.dart';
import 'package:learning_app/helpers/life_cycle_observer.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/helpers/provider.dart';
import 'package:learning_app/models/hive_models/api_queue.dart';
import 'package:learning_app/models/hive_models/progress.dart';
import 'package:learning_app/models/hive_models/subject.dart';
import 'package:learning_app/models/hive_models/todo.dart';
import 'package:learning_app/models/hive_models/user.dart';
import 'package:learning_app/models/hive_models/version_info.dart';
import 'package:learning_app/services/app_language_service.dart';
import 'package:learning_app/services/db_service.dart';
import 'package:learning_app/services/error_reporting_service.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/services/logging_service.dart';
import 'package:learning_app/services/navigation_service.dart';
import 'package:learning_app/services/pref_service.dart';
import 'package:learning_app/services/schedule_service.dart';
import 'package:learning_app/themes/primarytheme.dart';
import 'package:learning_app/view_models/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  runZonedGuarded(
    () async {
      BindingBase.debugZoneErrorsAreFatal = true;
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
      EasyLoading.instance
        ..displayDuration = const Duration(milliseconds: 2000)
        ..indicatorType = EasyLoadingIndicatorType.pulse
        ..loadingStyle = EasyLoadingStyle.dark
        ..indicatorSize = 45.0
        ..radius = 10.0
        ..progressColor = Colors.yellow
        ..backgroundColor = Colors.green
        ..indicatorColor = Colors.yellow
        ..textColor = Colors.yellow
        ..maskColor = Colors.blue.withOpacity(0.5)
        ..userInteractions = false
        ..maskType = EasyLoadingMaskType.black
        ..dismissOnTap = false;
      await LocatorInjector.setupLocator();
      HttpOverrides.global = CustomHttpOverrides();
      await Hive.initFlutter();
      await configSettings();
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.dumpErrorToConsole(details);
        debugPrint(details.exception.toString());
        // locator<LoggingService>()
        //     .logError('Uncaught app exception', details.exception, details.stack);
      };
      PlatformDispatcher.instance.onError = (error, stack) {
        return true;
      };
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky).then(
          (value) => SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
              ]).then((value) => runApp(const LifecycleObserver(child: MyApp()))));
    },
    (Object error, StackTrace stack) {
      debugPrint(error.toString());
      // locator<LoggingService>()
      //     .logError('Uncaught app exception', error, stack);
    },
  );
}

Future configSettings() async {
  // Init Services
  await locator<PrefService>().init();
  await locator<GlobalService>().init();
  await locator<ScheduleService>().init();
  await locator<IErrorReportingService>().initErrors();
  await locator<AppLanguageService>().fetchLocale();
  await locator<LoggingService>().init();
  // Init Viewmodels
  
  // Init Repos
  if(!kIsWeb){
    final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init("${appDocumentDirectory.path}/learning_app");
  }
  await locator<IHiveService<Todo>>().init();
  await locator<IHiveService<User>>().init();
  await locator<IHiveService<Subject>>().init();
  await locator<IHiveService<Progress>>().init();
  await locator<IHiveService<VersionInfo>>().init();
  await locator<IHiveService<APIQueue>>().init();
  locator<GlobalService>().log('-----------------------------------------');
  locator<GlobalService>().log('---------------- App Start --------------');
  locator<GlobalService>().log('-----------------------------------------');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SessionListener(
      onTimeOut: () async {
        await locator<HomeViewModel>().logout(confirm: false);
      },

      child: MultiProvider(
          providers: ProviderInjector.providers,
          child: Consumer<AppLanguageService>(builder: (context, model, child) {
            return MaterialApp(
              title: 'Learning App',
              debugShowCheckedModeBanner: false,
              theme: primaryTheme,
              supportedLocales: const [Locale('en'), Locale('fr')],
              locale: model.appLocal,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              builder: EasyLoading.init(),
              initialRoute: Routes.startup,
              navigatorKey: locator<NavigationService>().navigatorKey,
              onGenerateRoute: RouteManager.generateRoute,
            );
          })),
    );
  }
}

class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
