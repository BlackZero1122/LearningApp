import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/models/hive_models/activity.dart';
import 'package:learning_app/models/hive_models/lesson.dart';
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
import 'package:learning_app/view_models/activity_view_model.dart';
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
  ActivityViewModel get _activityViewModel => locator<ActivityViewModel>();

  Activity? get getSelectedActivity => activities.where((x)=>x.selected).firstOrNull;

  Subject? get getSelectedSubject => subjects.where((x)=>x.selected).firstOrNull;

  Lesson? get getSelectedLesson => lessons.where((x)=>x.selected).firstOrNull;

  bool get isFirstActivity{
    if(getSelectedActivity!=null){
      if(getSelectedSubject!.lessons!.first.activities!.first.activityId == getSelectedActivity!.activityId){
        return true;
      }
    }
    return false;
  }

  bool get isLastActivity{
     if(getSelectedActivity!=null){
      if(getSelectedSubject!.lessons!.last.activities!.last.activityId == getSelectedActivity!.activityId){
        return true;
      }
      if(!getSelectedActivity!.completed && _globalService.unlockActivities){
        return true;
      }
    }
    return false;
  }

  List<Subject> _subjects = [];

  List<Subject> get subjects => _subjects;

  setSubjects(List<Subject> subjects) async {
    _subjects = subjects;
  }

  List<Lesson> _lessons = [];

  List<Lesson> get lessons => _lessons;

  setLessons(List<Lesson> lessons) async {
    _lessons = lessons;
  }

  List<Activity> _activities = [];

  List<Activity> get activities => _activities;

  setActivities(List<Activity> activities) async {
    _activities = activities;
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

  Future<void> getData(int index) async {
    try {
      var subs = await locator<IHiveService<Subject>>().getAll();
      if(subs.isNotEmpty){
        setSubjects(subs);
        for (var element in subs) { element.selected=false; }
        subs[index].selected=true;
        var lessons = subs[index].lessons;
        if(lessons!=null && lessons.isNotEmpty){
          setLessons(lessons);
          for (var element in lessons) { element.selected=false; element.lock=true; }
          int lsnIndex = await getCurrentLesson();
          lessons[lsnIndex].selected=true;
          lessons[lsnIndex].lock=false;
          var activities = lessons[lsnIndex].activities;
          if(activities!=null && activities.isNotEmpty){
             setActivities(activities);
            for (var element in activities) { element.selected=false; element.lock=true; }
            int actIndex = await getCurrentActivity();
            activities[actIndex].selected=true;
            activities[actIndex].lock=false;
            activities[actIndex].lsnId=getSelectedLesson!.topicId;
            activities[actIndex].subId=getSelectedSubject!.courseId;
            await _activityViewModel.init(activities[actIndex]);
          }
        }
        else{
          // not found any lessons
          return;
        }
      }
      else{
        setActivities([]);
        setLessons([]);
        setSubjects([]);
      }
    } catch (e,s) {
      _globalService.logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<int> getCurrentLesson() async {
    int index = 0;
    try {
      var lsn = lessons.firstWhereOrNull((element) => !element.completed);
      if(lsn!=null){
        index =  lessons.indexOf(lsn);
      }
    } catch (e,s) {
      _globalService.logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
    return index;
  }
  
  Future<int> getCurrentActivity() async {
    int index = 0;
    try {
      var act = activities.firstWhereOrNull((element) => !element.completed);
      if(act!=null){
        index =  activities.indexOf(act);
      }
    } catch (e,s) {
      _globalService.logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
    return index;
  }

  void selectSubject(int index) {
    _globalService.log("Select Subject $index");
    getData(index);
  }

  Future<void> selectLesson(int index, bool? next) async {
    try {
      _globalService.log("Select Lesson $index");
      if(lessons.isNotEmpty){
          setLessons(lessons);
          for (var element in lessons) { element.selected=false; }
          lessons[index].selected=true;
          var activities = lessons[index].activities;
          if(activities!=null && activities.isNotEmpty){
             setActivities(activities);
            for (var element in activities) { element.selected=false; element.lock=true; }
            if(next!=null){
              if(next){
                activities[0].selected=true;
                activities[0].lock=false;
                activities[0].lsnId=getSelectedLesson!.topicId;
                activities[0].subId=getSelectedSubject!.courseId;
                await _activityViewModel.init(activities[0]);
              }
              else{
                activities[activities.length-1].selected=true;
                activities[activities.length-1].lock=false;
                activities[activities.length-1].lsnId=getSelectedLesson!.topicId;
                activities[activities.length-1].subId=getSelectedSubject!.courseId;
                await _activityViewModel.init(activities[activities.length-1]);
              }
            }else{
              int actIndex = await getCurrentActivity();
              activities[actIndex].selected=true;
              activities[actIndex].lock=false;
              activities[actIndex].lsnId=getSelectedLesson!.topicId;
              activities[actIndex].subId=getSelectedSubject!.courseId;
              await _activityViewModel.init(activities[actIndex]);
            }
          }
          await locator<NavigationService>().pushNamed(Routes.lessonDetail, data: null, args: TransitionType.fade);
        }
    } catch (e,s) {
      _globalService.logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
    finally{
      notifyListeners();
    }
  }

  Future<void> selectActivity(int index, {bool push = true}) async {
     try {
      _globalService.log("Select Activity $index");
       if(activities.isNotEmpty){
        for (var element in activities) { element.selected=false; }
        activities[index].selected=true;
        activities[index].lsnId=getSelectedLesson!.topicId;
        activities[index].subId=getSelectedSubject!.courseId;
        await _activityViewModel.init(activities[index]);
        if(push){
          await locator<NavigationService>().pushNamed(Routes.activityDetail, data: null, args: TransitionType.fade);
        }
      }
     } catch (e,s) {
      _globalService.logError("Error Occured!", e.toString(), s);
       debugPrint(e.toString());
     }
     finally{
      notifyListeners();
    }
  }

    unlockNextActivity() {
    try {
      _globalService.log("Unlock Next Activity");
      var a = getNextElement(activities, activities.firstWhere((x)=>x.selected));
      if(a!=null){
        activities[activities.indexOf(a)].lock=false;
      }
      else{
        var l = getNextElement(lessons, lessons.firstWhere((x)=>x.selected));
        if(l!=null){
          lessons[lessons.indexOf(l)].lock=false;
          activities[0].lock=false;
        }
      }
    } catch (e,s) {
      _globalService.logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
    finally{
      notifyListeners();
    }
  }

  T? getNextElement<T>(List<T> list, T element) {
    final index = list.indexOf(element);
    if (index != -1 && index + 1 < list.length) {
      return list[index + 1];
    }
    return null;
  }

  T? getPreviousElement<T>(List<T> list, T element) {
    final index = list.indexOf(element);
    if (index > 0) {
      return list[index - 1];
    }
    return null;
  }

  playPreActivity() {
    try {
      _globalService.log("Play Pre Activity");
      var a = getPreviousElement(activities, activities.firstWhere((x)=>x.selected));
      if(a!=null){
        selectActivity(activities.indexOf(a), push: false);
      }
      else{
        // var l = getPreviousElement(lessons, lessons.firstWhere((x)=>x.selected));
        // if(l!=null){
        //   selectLesson(lessons.indexOf(l),false);
        // }
      }
    } catch (e,s) {
      _globalService.logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
    finally{
      notifyListeners();
    }
  }

  playNextActivity() {
    try {
      _globalService.log("Play next Activity");
     var a = getNextElement(activities, activities.firstWhere((x)=>x.selected));
      if(a!=null){
        selectActivity(activities.indexOf(a), push: false);
      }
      else{
        // var l = getNextElement(lessons, lessons.firstWhere((x)=>x.selected));
        // if(l!=null){
        //   selectLesson(lessons.indexOf(l),true);
        // }
      }
    } catch (e,s) {
      _globalService.logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
    finally{
      notifyListeners();
    }
  }

}
