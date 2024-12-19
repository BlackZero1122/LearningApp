import 'package:flutter/material.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/views/activity_page.dart';
import 'package:learning_app/views/home_page.dart';
import 'package:learning_app/views/lesson_page.dart';
import 'package:learning_app/views/login_page.dart';
import 'package:learning_app/views/not_supported_page.dart';
import 'package:learning_app/views/notifications_page.dart';
import 'package:learning_app/views/setting_page.dart';
import 'package:learning_app/views/signup_page.dart';
import 'package:learning_app/views/startup_page.dart';
import 'package:learning_app/views/walkthrough_page.dart';

class Routes {
  Routes._();

  static const String startup = "/";
  static const String home = "home";
  static const String login = "login";
  static const String signup = "signup";
  static const String settings = "settings";
  static const String notifications = "notifications";
  static const String walkthrough = "walkthrough";
  static const String lessonDetail = "lessonDetail";
  static const String activityDetail = "activityDetail";
  static const String notSupported = "notSupported";
}

class NavigationService {
  // ************************** **************************

  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "navigator");
  GlobalService get _globalService => locator<GlobalService>();

  // ************************** **************************

  Future popWithResult({required dynamic result}) async {
    if (navigatorKey.currentState?.canPop() == true) {
      _globalService.log('Go Back with Result');
      return navigatorKey.currentState?.pop(result);
    } else {
      _globalService.log('No page to pop with result');
      // Handle the case when there's no page to pop to
      // e.g., show a message or disable the button
      debugPrint("No page to pop to");
    }
  }

  Future popDialog({required dynamic result}) async {
    if (navigatorKey.currentState?.canPop() == true) {
      _globalService.log('Close Dialog');
      return navigatorKey.currentState?.pop(result);
    } else {
      _globalService.log('No page to pop with dialog');
      // Handle the case when there's no page to pop to
      // e.g., show a message or disable the button
      debugPrint("No page to pop to");
    }
  }

  Future pop() async {
    if (navigatorKey.currentState?.canPop() == true) {
      _globalService.log('Go Back');
      return navigatorKey.currentState?.pop();
    } else {
      _globalService.log('No page to pop to');
      // Handle the case when there's no page to pop to
      // e.g., show a message or disable the button
      debugPrint("No page to pop to");
    }
  }

  Future pushNamed(String path,
      {required dynamic data, required TransitionType args}) async {
    _globalService.log('Go to {$path}\' Page');
    return await navigatorKey.currentState?.pushNamed(
      path,
      arguments: [args, data],
    );
  }

  Future pushReplacementNamed(String path,
      {required TransitionType args}) async {
    _globalService.log('Go to {$path}\' Page');
    return await navigatorKey.currentState?.pushReplacementNamed(
      path,
      arguments: [args],
    );
  }

  // ignore: prefer_function_declarations_over_variables
  final removeAllOldRoutes = (Route<dynamic> route) => false;

  Future navigateToReset(String path, {required TransitionType args}) async {
    _globalService.log('Go to {$path}\' Page');
    return await navigatorKey.currentState?.pushNamedAndRemoveUntil(
      path,
      removeAllOldRoutes,
      arguments: [args],
    );
  }

  Future pushNamedAndRemoveUntil(String path,
      {required TransitionType args}) async {
    _globalService.log('Go to {$path}\' Page');
    return await navigatorKey.currentState?.pushNamedAndRemoveUntil(
      path,
      removeAllOldRoutes,
      arguments: [args],
    );
  }
}

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              "An error occurred.",
              textAlign: TextAlign.center,
              // style: Theme.of(context).textTheme.display1.copyWith(
              //       color: const Color.fromARGB(255, 255, 255, 255),
              //     ),
            ),
          ],
        ),
      ),
    );
  }
}

class RouteManager {
  RouteManager._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    TransitionType transition;
    dynamic data;
    if (settings.arguments != null) {
      var args = settings.arguments as List<dynamic>;
      transition = args[0] as TransitionType;
      if (args.length > 1) {
        data = args[1];
      }
    } else {
      transition = TransitionType.fade;
    }

    switch (settings.name) {
      case Routes.notSupported:
        {
          return PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return NotSupportedPage();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return _transitionsBuilder(transition, animation, child);
            },
          );
        }
      case Routes.signup:
        {
          return PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return SignUpPage();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return _transitionsBuilder(transition, animation, child);
            },
          );
        }
      case Routes.settings:
        {
          return PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return SettingPage();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return _transitionsBuilder(transition, animation, child);
            },
          );
        }
      case Routes.notifications:
        {
          return PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return NotificationsPage();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return _transitionsBuilder(transition, animation, child);
            },
          );
        }
      case Routes.login:
        {
          return PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return LoginPage();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return _transitionsBuilder(transition, animation, child);
            },
          );
        }
      case Routes.lessonDetail:
        {
          return PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return LessonPage();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return _transitionsBuilder(transition, animation, child);
            },
          );
        }
      case Routes.activityDetail:
        {
          return PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return ActivityPage();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return _transitionsBuilder(transition, animation, child);
            },
          );
        }
      case Routes.walkthrough:
        {
          return PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return WalkthroughPage();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return _transitionsBuilder(transition, animation, child);
            },
          );
        }
      case Routes.startup:
        {
          return PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return StartupPage();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return _transitionsBuilder(transition, animation, child);
            },
          );
        }
      case Routes.home:
        {
          return PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return HomePage();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return _transitionsBuilder(transition, animation, child);
            },
          );
        }
      default:
        {
          return _errorPage();
        }
    }
  }

  static Widget _transitionsBuilder(
      TransitionType type, Animation<double> animation, Widget child) {
    switch (type) {
      case TransitionType.slideRight:
        {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          );
        }
      case TransitionType.slideLeft:
        {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }
      case TransitionType.slideTop:
        {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }
      case TransitionType.slideBottom:
        {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }
      case TransitionType.fade:
        {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      case TransitionType.scale:
        {
          return ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation),
            child: child,
          );
        }
      case TransitionType.rotate:
        {
          return RotationTransition(
            turns: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation),
            child: child,
          );
        }
      case TransitionType.size:
        {
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
            ),
          );
        }
      case TransitionType.scaleRotate:
        {
          return ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: RotationTransition(
              turns: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.linear,
                ),
              ),
              child: child,
            ),
          );
        }
      default:
        {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          );
        }
    }
  }

  static Route<dynamic> _errorPage() {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Navigation Error',
            ),
          ),
          body: const Center(
            child: Text(
              'Navigation Error',
            ),
          ),
        );
      },
    );
  }
}

enum TransitionType {
  slideRight,
  slideLeft,
  slideTop,
  slideBottom,
  fade,
  scale,
  rotate,
  size,
  scaleRotate,
}
