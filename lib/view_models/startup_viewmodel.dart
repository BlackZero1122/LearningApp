import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/models/hive_models/activity.dart';
import 'package:learning_app/models/hive_models/lesson.dart';
import 'package:learning_app/models/hive_models/subject.dart';
import 'package:learning_app/services/api_service.dart';
import 'package:learning_app/services/db_service.dart';
import 'package:learning_app/services/device_info_service.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/services/navigation_service.dart';
import 'package:learning_app/services/pref_service.dart';
import 'package:learning_app/services/schedule_service.dart';
import 'package:learning_app/view_models/base_view_model.dart';
import 'package:learning_app/view_models/user_view_model.dart';

class StartupViewModel extends BaseViewModel {
  PrefService get _prefService => locator<PrefService>();
  NavigationService get _navigationService => locator<NavigationService>();
  IAPIService get _apiService => locator<IAPIService>();
  ScheduleService get _scheduleService => locator<ScheduleService>();
  UserViewModel get _userViewModel => locator<UserViewModel>();
  GlobalService get _globalService => locator<GlobalService>();
  IDeviceInfoService get _deviceInfoService => locator<IDeviceInfoService>();

  bool checkVersion = true;

  Future doStartupLogic(BuildContext context) async {
    try {
      //var deviceType = await _deviceInfoService.deviceType(context);
      // if(deviceType == 0){
      //   _navigationService.pushNamedAndRemoveUntil(
      //     Routes.notSupported,
      //     args: TransitionType.fade,
      //   );
      // }
      // else{
        await _userViewModel.getDataFromLocal();
        await Future.delayed(const Duration(milliseconds: 100));
        await loading(true);
        await Future.delayed(const Duration(milliseconds: 100));
        //await _prefService.clear();
        if (!await _prefService.getBool(PrefKey.isLoggedIn) || FirebaseAuth.instance.currentUser==null) {
          _navigationService.pushNamedAndRemoveUntil(
            Routes.login,
            args: TransitionType.fade,
          );
        } else {

              var engSubject = Subject(
                id:"001",
                name: "English 101",
                code: "001",
                thumbnail: "",
                title: "English 101",
                subject: "English",
                courseId: "001",
                courseName: "English 101",
                lessons: [
                  Lesson(title: 'Lesson 1', subjectId: "001", id:"001001", topicId: "001001", sequence: 0, enable: true, thumbnail: "", totalActivities: 0, activities: [
                    Activity(activityId: "001001001", id: "001001001", lessonId: "001001", subjectId: "001", title: "Activity 1", topic: "Topic 1", activityType: 0, activityTypeString: "video", content: "", grade: 0, subject: 0, semester: 0, session: 0, thumbnail: "", sequence: 0, readCount: 0, assessment: null, rules: null)
                  ]),
                  Lesson(title: 'Lesson 2', subjectId: "001", id:"002001", topicId: "002001", sequence: 1, enable: true, thumbnail: "", totalActivities: 0, activities: []),
                  Lesson(title: 'Lesson 3', subjectId: "001", id:"003001", topicId: "003001", sequence: 2, enable: true, thumbnail: "", totalActivities: 0, activities: [])
                ]
              );
              var mathSubject = Subject(
                id:"002",
                name: "Math 101",
                code: "002",
                thumbnail: "",
                title: "Math 101",
                subject: "Math",
                courseId: "002",
                courseName: "Math 101",
                lessons: []
              );
              var sciSubject = Subject(
                id:"003",
                name: "Science 101",
                code: "003",
                thumbnail: "",
                title: "Science 101",
                subject: "Science",
                courseId: "003",
                courseName: "Science 101",
                lessons: []
              );
              await locator<IHiveService<Subject>>().addOrUpdate(engSubject);
              await locator<IHiveService<Subject>>().addOrUpdate(mathSubject);
              await locator<IHiveService<Subject>>().addOrUpdate(sciSubject);
          _navigationService.pushNamedAndRemoveUntil(
                Routes.home,
                args: TransitionType.fade,
              );
        }
      //}
    } catch (e,s) {
      _globalService.logError("Error Occured on Startup Logic", e.toString(), s);
      debugPrint(e.toString());
    } finally {
      await loading(false);
    }
  }
}
