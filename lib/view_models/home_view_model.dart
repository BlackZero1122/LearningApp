import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/models/hive_models/subject.dart';
import 'package:learning_app/models/hive_models/user.dart';
import 'package:learning_app/models/message.dart';
import 'package:learning_app/services/api_service.dart';
import 'package:learning_app/services/db_service.dart';
import 'package:learning_app/services/dialog_service.dart';
import 'package:learning_app/services/error_reporting_service.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/services/navigation_service.dart';
import 'package:learning_app/services/pref_service.dart';
import 'package:learning_app/view_models/base_view_model.dart';
import 'package:learning_app/view_models/side_drawer_view_model.dart';
import 'package:learning_app/view_models/user_view_model.dart';

class HomeViewModel extends BaseViewModel {
  IErrorReportingService get _errorReportingService =>
      locator<IErrorReportingService>();
  IDialogService get _dialogService => locator<IDialogService>();
  IAPIService get _apiService => locator<IAPIService>();
  UserViewModel get _userViewModel => locator<UserViewModel>();
  GlobalService get _globalService => locator<GlobalService>();
  PrefService get _prefService => locator<PrefService>();
  NavigationService get _navigationService => locator<NavigationService>();
  SideDrawerViewModel get _sideDrawerViewModel =>
      locator<SideDrawerViewModel>();

List<Subject> _subjects = [];

  List<Subject> get subjects => _subjects;

  setSubjects(List<Subject> subjects) async {
    _subjects = subjects;
  }

  int _currentSubjectIndex = 0;

  int get currentSubjectIndex => _currentSubjectIndex;

  setCurrentSubjectIndex(int currentSubjectIndex) async {
    _currentSubjectIndex = currentSubjectIndex;
  }

    int _currentLessonIndex = 0;

  int get currentLessonIndex => _currentLessonIndex;

  setCurrentLessonIndex(int currentLessonIndex) async {
    _currentLessonIndex = currentLessonIndex;
  }

  int _currentActivityIndex = 0;

  int get currentActivityIndex => _currentActivityIndex;

  setCurrentActivityIndex(int currentActivityIndex) async {
    _currentActivityIndex = currentActivityIndex;
  }

  Future<bool> logout({bool confirm = true}) async {
    try {
      if (confirm) {
        var res = await _dialogService.showPrompt(Message(
          description: "You sure want to logout?",
          okText: "Yes",
          cancelText: "No",
        ));
        if (!res) {
          return false;
        }
      }
      await loading(true);
      FirebaseAuth.instance.signOut();
      GoogleSignIn().signOut();
      await _prefService.setBool(PrefKey.isLoggedIn, false);
      await _prefService.setString(PrefKey.token, "");
      await _prefService.setString(PrefKey.tokenExpiresIn, "");
      await _prefService.setString(PrefKey.tokenStartTime, "");
      //await locator<IHiveService<User>>().deleteAll();
      await locator<IHiveService<Subject>>().deleteAll();
      _sideDrawerViewModel.reset();
      _navigationService.pushNamedAndRemoveUntil(
        Routes.startup,
        args: TransitionType.fade,
      );
    } catch (e, s) {
      _globalService.logError("Error Occured When Logout", e.toString(), s);
      debugPrint(e.toString());
    } finally {
      await loading(false);
    }
    return true;
  }

  Future<void> getData() async {
    try {
      await setSpinner(true);
      await Future.delayed(Duration(seconds: 3));
      var subjects = await locator<IHiveService<Subject>>().getAll();
      setSubjects(subjects);
      selectSubject(0);
    } catch (e, s) {
      _globalService.logError("Error Occured When Logout", e.toString(), s);
      debugPrint(e.toString());
    } finally {
      await setSpinner(false);
    }
  }

  void selectSubject(int index) async {
    try {
      setCurrentSubjectIndex(index);
      for (var x in subjects) {x.selected=false;}
      subjects[index].selected=true;
      await setListSpinner(true);
      await Future.delayed(Duration(seconds: 1));
    } catch (e, s) {
      _globalService.logError("Error Occured When Logout", e.toString(), s);
      debugPrint(e.toString());
    } finally {
      await setListSpinner(false);
    }
  }

  void selectLesson(int index) async {
    try {
      setCurrentLessonIndex(index);
      for (var x in subjects[currentSubjectIndex].lessons!) {x.selected=false;}
      subjects[currentSubjectIndex].lessons![index].selected=true;
      locator<NavigationService>().pushNamed(
                          Routes.lessonDetail,
                          data: null,
                          args: TransitionType.fade,
                        );
      await setListSpinner(true);
      await Future.delayed(Duration(seconds: 1));
    } catch (e, s) {
      _globalService.logError("Error Occured When Logout", e.toString(), s);
      debugPrint(e.toString());
    } finally {
      await setListSpinner(false);
    }
  }

  void selectActivity(int index) async {
    try {
      setCurrentActivityIndex(index);
      for (var x in subjects[currentSubjectIndex].lessons![currentLessonIndex].activities!) {x.selected=false;}
      subjects[currentSubjectIndex].lessons![currentLessonIndex].activities![index].selected=true;
      locator<NavigationService>().pushNamed(
                          Routes.activityDetail,
                          data: null,
                          args: TransitionType.fade,
                        );
      await setListSpinner(true);
      await Future.delayed(Duration(seconds: 1));
    } catch (e, s) {
      _globalService.logError("Error Occured When Logout", e.toString(), s);
      debugPrint(e.toString());
    } finally {
      await setListSpinner(false);
    }
  }

}
