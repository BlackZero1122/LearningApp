import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_app/helpers/extractthumbnailyoutube.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/models/hive_models/activity.dart';
import 'package:learning_app/models/hive_models/answer_list.dart';
import 'package:learning_app/models/hive_models/assessment.dart';
import 'package:learning_app/models/hive_models/lesson.dart';
import 'package:learning_app/models/hive_models/quiz.dart';
import 'package:learning_app/models/hive_models/rules.dart';
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
            await getSubjects();
             
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
  
  Future<void> getSubjects() async {
    try {
      // var response =
      //     await rootBundle.loadString('assets/json/subject.json');
      // Iterable l = json.decode(response);
      // var sub = List<Subject>.from(l.map((x) => Subject.fromJson(x)));
      // await locator<IHiveService<Subject>>().addOrUpdateRange(sub);
       var engSubject = Subject(
            id: "001",
            name: "Early Learning",
            code: "001",
            thumbnail: "",
            title: "First Journey",
            subject: "education",
            courseId: "001",
            tts_description: "English",
            courseName: "English 101",
            lessons: [
              
              Lesson(
                  tts_description: "Lets study english alphabets",
                  title: 'Fun with Alphbets',
                  subjectId: "001",
                  id: "001001",
                  topicId: "001001",
                  sequence: 0,
                  enable: true,
                  thumbnail: "",
                  completePercent: 100,
                  totalActivities: 0,
                  activities: [
                    Activity(
                        activityId: "activity_1",
                        id: "activity_1",
                        subjectId: "001",
                        lessonId: "001001",
                        title: "The Alphabet Song",
                        topic: "Alphabets",
                        activityTypeString: "YouTubeVideo",
                        activityType: 8,
                        content: "https://www.youtube.com/watch?v=75p-N9YKqNo",
                        grade: 0,
                        subject: 0,
                        semester: 0,
                        session: 2023,
                        thumbnail:
                            "https://img.youtube.com/vi/75p-N9YKqNo/hqdefault.jpg",
                        sequence: 1,
                        readCount: 0,
                        completePercent: 0,
                        assessment: null,
                        rules:
                            Rules(maxReadCount: 1, trackActivityProgress: true),
                        description:
                            "A sing-along video teaching the English alphabet.",
                        tts_description:
                            "Let's sing the alphabet song together! Listen carefully and repeat the letters as they are sung. It's fun to sing along!",
                        skill: "Listening"),
                    Activity(
                        activityId: "activity_2",
                        id: "activity_2",
                        subjectId: "001",
                        lessonId: "lesson_1",
                        title: "Phonics Sounds of Alphabets",
                        topic: "Alphabets",
                        activityTypeString: "YouTubeVideo",
                        activityType: 8,
                        content: "https://www.youtube.com/watch?v=Ypz3bsr6SZc",
                        grade: 0,
                        subject: 0,
                        semester: 0,
                        session: 2023,
                        thumbnail:
                            "https://img.youtube.com/vi/Ypz3bsr6SZc/hqdefault.jpg",
                        sequence: 2,
                        readCount: 0,
                        completePercent: 0,
                        assessment: null,
                        rules:
                            Rules(maxReadCount: 1, trackActivityProgress: true),
                        description:
                            "A fun video introducing the phonics sounds of each letter in the alphabet.",
                        tts_description:
                            "Let's learn the sounds of the alphabet. Each letter has a sound, and this video will help you listen and repeat them. Are you ready?",
                        skill: "Cognitive"),
                    Activity(
                        activityId: "activity_3",
                        id: "activity_3",
                        subjectId: "001",
                        lessonId: "lesson_1",
                        title: "Learn ABC Alphabet with Animals",
                        topic: "Alphabets",
                        activityTypeString: "YouTubeVideo",
                        activityType: 8,
                        content: "https://www.youtube.com/watch?v=csbbViClPp0",
                        grade: 0,
                        subject: 0,
                        semester: 0,
                        session: 2023,
                        thumbnail:
                            "https://img.youtube.com/vi/csbbViClPp0/hqdefault.jpg",
                        sequence: 3,
                        readCount: 0,
                        completePercent: 0,
                        assessment: null,
                        rules:
                            Rules(maxReadCount: 1, trackActivityProgress: true),
                        description:
                            "A video connecting letters of the alphabet to animals (e.g., A for Alligator, B for Bear).",
                        tts_description:
                            "Let's meet animals whose names start with the letters of the alphabet. Listen to the names and repeat them with me!",
                        skill: "Vocabulary"),
                                      Activity(
                        tts_description: "Activity 2",
                        activityId: "001001002",
                        id: "001001002",
                        lessonId: "001001",
                        subjectId: "001",
                        title: "Activity 2",
                        topic: "Topic 1",
                        activityType: 7,
                        activityTypeString: "Quiz",
                        content: "",
                        grade: 0,
                        subject: 0,
                        semester: 0,
                        session: 0,
                        thumbnail: "",
                        sequence: 0,
                        readCount: 0,
                        assessment: Assessment(
                            noOfQuizToAsk: 3,
                            correctNoOfQuizToPass: 1,
                            isRequired: true,
                            maxTryAttempts: 3,
                            quizzes: [
                              Quiz(
                                  tts_description: "What is 8 + 9 - 2?",
                                  quizType: "MultipleChoice",
                                  id: "0010010021",
                                  image:
                                      "https://shama.nrschools.net/core/upload/quiz/1725263030Number1-5.jpg",
                                  question: "What is 8 + 9 - 2 =",
                                  answerList: [
                                    AnswerList(
                                        id: "00100100211",
                                        tts_description: "14",
                                        answer: "14",
                                        image:
                                            "https://shama.nrschools.net/core/upload/quiz/17272794821_img7.jpg",
                                        isCorrect: false),
                                    AnswerList(
                                        id: "00100100212",
                                        tts_description: "15",
                                        answer: "15",
                                        image:
                                            "https://shama.nrschools.net/core/upload/quiz/17272794822_img9.jpg",
                                        isCorrect: true),
                                    AnswerList(
                                        id: "00100100213",
                                        tts_description: "13",
                                        answer: "13",
                                        image:
                                            "https://shama.nrschools.net/core/upload/quiz/17272794823_img6.jpg",
                                        isCorrect: false),
                                    AnswerList(
                                        id: "00100100214",
                                        tts_description: "16",
                                        answer: "16",
                                        image:
                                            "https://shama.nrschools.net/core/upload/quiz/17272794824_img5.jpg",
                                        isCorrect: false)
                                  ],
                                  questionList: []),
                              Quiz(
                                  quizType: "FillInBlank",
                                  id: "0010010022",
                                  image:
                                      "https://shama.nrschools.net/core/upload/quiz/1723659737Untitled design (54).png",
                                  question: "8 + 9 - 2 = ______",
                                  answerList: [
                                    AnswerList(
                                        id: "00100100221",
                                        answer: "15",
                                        image: "",
                                        isCorrect: true)
                                  ],
                                  questionList: []),
                              Quiz(
                                  quizType: "ShortAnswer",
                                  id: "0010010022",
                                  image:
                                      "https://shama.nrschools.net/core/upload/quiz/1723659737Untitled design (54).png",
                                  question: "8 + 9 - 2 = ______",
                                  answerList: [
                                    AnswerList(
                                        id: "00100100221",
                                        answer: "15",
                                        image: "",
                                        isCorrect: true)
                                  ],
                                  questionList: []),
                              Quiz(
                                  quizType: "TrueFalse",
                                  id: "0010010023",
                                  image:
                                      "https://shama.nrschools.net/core/upload/quiz/1724393752Untitled design (12).png",
                                  question: "98 - 90 + 2 + 7 = 20.",
                                  answerList: [
                                    AnswerList(
                                        id: "00100100231",
                                        tts_description: "Yes",
                                        answer: "Yes",
                                        image: "",
                                        isCorrect: false),
                                    AnswerList(
                                        id: "00100100232",
                                        tts_description: "No",
                                        answer: "No",
                                        image: "",
                                        isCorrect: true)
                                  ],
                                  questionList: []),
                            ]),
                        rules: Rules(
                            maxReadCount: 1, trackActivityProgress: true)),
                    Activity(
                        tts_description: "Activity 3",
                        activityId: "001001003",
                        id: "001001003",
                        lessonId: "001001",
                        subjectId: "001",
                        title: "Activity 3",
                        topic: "Topic 1",
                        activityType: 8,
                        activityTypeString: "YouTubeVideo",
                        content: "https://www.youtube.com/watch?v=BBAyRBTfsOU",
                        grade: 0,
                        subject: 0,
                        semester: 0,
                        session: 0,
                        thumbnail: "",
                        sequence: 0,
                        readCount: 0,
                        assessment: null,
                        rules: Rules(
                            maxReadCount: 1, trackActivityProgress: true)),
                  ]),
            Lesson(
title: "Lets learn new worlds",
      subjectId: "001",
      id: "001002:",
      topicId: "001002",
      sequence: 0,
      enable: true,
      description:"Learning new words is fun",
      tts_description:"We will know new words ",
      completePercent: 0,
      skill:"Vocabulary",
      thumbnail: "",
      lessonEnable: "true",
      activities: [
        Activity(
            activityId: "activity_1",
            id: "activity_1",
            subjectId: "001",
            lessonId: "001002",
            title: "Useful Phrases",
            topic: "Useful Phrases",
            activityTypeString: "YouTubeVideo",
            activityType: 8,
            content: "https://www.youtube.com/watch?v=7HUW_aukApo",
            grade: 0,
            subject: 0,
            semester: 0,
            session: 2023,
            thumbnail:
                null,
            sequence: 1,
            readCount: 1,
            completePercent: 0,
            assessment: null,
            rules:
                Rules(maxReadCount: 1, trackActivityProgress: true),
            description:
                "Learn new phrases.",
            tts_description:
                "we will learn new phares and words",
            skill: "Vacabulary"),
        Activity(
            activityId: "activity_2",
            id: "activity_2",
            subjectId: "001",
            lessonId: "001002",
            title: "Daily use action words",
            topic: "Alphabets",
            activityTypeString: "YouTubeVideo",
            activityType: 8,
            content: "https://www.youtube.com/watch?v=krpkQhdkyKw",
            grade: 0,
            subject: 0,
            semester: 0,
            session: 2023,
            thumbnail:
                null,
            sequence: 2,
            readCount: 0,
            completePercent: 0,
            assessment: null,
            rules:
                Rules(maxReadCount: 1, trackActivityProgress: true),
            description:
                "Daily Use action words",
            tts_description:
                "Let's learn how to use different words when doing some actions"),
        Activity(
            activityId: "activity_3",
            id: "activity_3",
            subjectId: "001",
            lessonId: "001002",
            title: "Fruits and Vegetables Names",
            topic: "Fruits and Vegetables Names",
            activityTypeString: "YouTubeVideo",
            activityType: 8,
            content: "https://www.youtube.com/watch?v=UcGm_PM2IwY",
            grade: 0,
            subject: 0,
            semester: 0,
            session: 2023,
            thumbnail:
                null,
            sequence: 3,
            readCount: 0,
            completePercent: 0,
            assessment: null,
            rules:
                Rules(maxReadCount: 1, trackActivityProgress: true),
            description:
                "Lets learn about fruits and vegtables",
            tts_description:
                "Lets learn about fruits and vegtables",
            skill: "Vocabulary")
      ])]);
        await locator<IHiveService<Subject>>().addOrUpdate(engSubject);
        _navigationService.pushNamedAndRemoveUntil(
          Routes.home,
          args: TransitionType.fade,
        );
      }
 catch (e, s) {
      _globalService.logError(
          "Error Occured on Startup Logic", e.toString(), s);
      debugPrint(e.toString());
    }
  }
}
