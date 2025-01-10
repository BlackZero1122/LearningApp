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
      if (!await _prefService.getBool(PrefKey.isLoggedIn) ||
          FirebaseAuth.instance.currentUser == null) {
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
    } catch (e, s) {
      _globalService.logError(
          "Error Occured on Startup Logic", e.toString(), s);
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
                skill: "Listening",
                tts_description: "Lets study english alphabets",
                title: 'Fun with Alphbets',
                subjectId: "001",
                id: "001001",
                topicId: "001001",
                sequence: 0,
                enable: true,
                thumbnail:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXtSyrpwKp4xWAyDhBNvjia8JDB0-xJTqsKg&s",
                completePercent: 100,
                totalActivities: 5,
                activities: [
                  Activity(
                      activityId: "001001001",
                      id: "001001001",
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
                      activityId: "001001002",
                      id: "001001002",
                      subjectId: "001",
                      lessonId: "001001",
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
                      activityId: "001001003",
                      id: "001001003",
                      subjectId: "001",
                      lessonId: "001001",
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
                      tts_description: "Activity",
                      activityId: "001001004",
                      id: "001001004",
                      lessonId: "001001",
                      subjectId: "001",
                      title: "Activity",
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
                                tts_description: "What comes after C?",
                                quizType: "MultipleChoice",
                                id: "0010010041",
                                image:
                                    "",
                                question: "What comes after C?",
                                answerList: [
                                  AnswerList(
                                      id: "00100100411",
                                      tts_description: "D",
                                      answer: "D",
                                      image:
                                          "https://www.shareicon.net/data/128x128/2016/10/20/846389_letter_512x512.png",
                                      isCorrect: true),
                                  AnswerList(
                                      id: "00100100412",
                                      tts_description: "F",
                                      answer: "F",
                                      image:
                                          "https://www.shareicon.net/data/128x128/2016/10/20/846422_blue_512x512.png",
                                      isCorrect: false),
                                  AnswerList(
                                      id: "00100100413",
                                      tts_description: "O",
                                      answer: "O",
                                      image:
                                          "https://www.shareicon.net/data/128x128/2016/10/20/846444_alphabet-letter-letters-o-red_512x512.png",
                                      isCorrect: false),
                                  AnswerList(
                                      id: "00100100414",
                                      tts_description: "K",
                                      answer: "K",
                                      image:
                                          "https://www.shareicon.net/data/128x128/2016/10/20/846421_blue_512x512.png",
                                      isCorrect: false)
                                ],
                                questionList: []),
                            Quiz(
                                tts_description: "What is the last alphabet in english?",
                                quizType: "MultipleChoice",
                                id: "0010010041",
                                image:
                                    "",
                                question: "What is the last alphabet in english?",
                                answerList: [
                                  AnswerList(
                                      id: "00100100411",
                                      tts_description: "Z",
                                      answer: "Z",
                                      image:
                                          "https://cdn3.iconfinder.com/data/icons/letters-and-numbers-1/32/letter_X_red-128.png",
                                      isCorrect: false),
                                  AnswerList(
                                      id: "00100100412",
                                      tts_description: "Y",
                                      answer: "Y",
                                      image:
                                          "https://cdn3.iconfinder.com/data/icons/letters-and-numbers-1/32/letter_Y_red-128.png",
                                      isCorrect: false),
                                  AnswerList(
                                      id: "00100100413",
                                      tts_description: "V",
                                      answer: "V",
                                      image:
                                          "https://cdn3.iconfinder.com/data/icons/letters-and-numbers-1/32/letter_V_blue-128.png",
                                      isCorrect: false),
                                  AnswerList(
                                      id: "00100100414",
                                      tts_description: "Z",
                                      answer: "Z",
                                      image:
                                          "https://cdn3.iconfinder.com/data/icons/letters-and-numbers-1/32/letter_Z_red-128.png",
                                      isCorrect: true)
                                ],
                                questionList: []),
                          ]),
                      rules:
                          Rules(maxReadCount: 1, trackActivityProgress: true)),
                ]),
            Lesson(
                title: "Lets learn new worlds",
                subjectId: "001",
                id: "001002",
                topicId: "001002",
                sequence: 0,
                enable: true,
                description: "Learning new words is fun",
                tts_description: "We will know new words ",
                completePercent: 0,
                skill: "Vocabulary",
                thumbnail:
                    "https://cdn.penguin.co.in/wp-content/uploads/2023/02/9780143445210.jpg",
                lessonEnable: "true",
                totalActivities: 3,
                activities: [
                  Activity(
                      activityId: "001002001",
                      id: "001002001",
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
                      thumbnail: null,
                      sequence: 1,
                      readCount: 1,
                      completePercent: 0,
                      assessment: null,
                      rules:
                          Rules(maxReadCount: 1, trackActivityProgress: true),
                      description: "Learn new phrases.",
                      tts_description: "we will learn new phares and words",
                      skill: "Vacabulary"),
                  Activity(
                      activityId: "001002002",
                      id: "001002002",
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
                      thumbnail: null,
                      sequence: 2,
                      readCount: 0,
                      completePercent: 0,
                      assessment: null,
                      rules:
                          Rules(maxReadCount: 1, trackActivityProgress: true),
                      description: "Daily Use action words",
                      tts_description:
                          "Let's learn how to use different words when doing some actions"),
                  Activity(
                      activityId: "001002003",
                      id: "001002003",
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
                      thumbnail: null,
                      sequence: 3,
                      readCount: 0,
                      completePercent: 0,
                      assessment: null,
                      rules:
                          Rules(maxReadCount: 1, trackActivityProgress: true),
                      description: "Lets learn about fruits and vegtables",
                      tts_description: "Lets learn about fruits and vegtables",
                      skill: "Vocabulary")
                ]),
            Lesson(
                skill: "Vocabulary",
                tts_description: "Lets study math",
                title: 'Fun with Math',
                subjectId: "001",
                id: "001003",
                topicId: "001003",
                sequence: 0,
                enable: true,
                thumbnail:
                    "https://cdn.vectorstock.com/i/500p/17/10/font-design-for-word-math-with-happy-kids-vector-19801710.jpg",
                completePercent: 100,
                totalActivities: 5,
                activities: [
                  Activity(
                      activityId: "001003001",
                      id: "001003001",
                      subjectId: "001",
                      lessonId: "001003",
                      title: "Counting 1 to 10",
                      topic: "Alphabets",
                      activityTypeString: "YouTubeVideo",
                      activityType: 8,
                      content: "https://www.youtube.com/watch?v=DR-cfDsHCGA",
                      grade: 0,
                      subject: 0,
                      semester: 0,
                      session: 2023,
                      thumbnail:
                          "",
                      sequence: 1,
                      readCount: 0,
                      completePercent: 0,
                      assessment: null,
                      rules:
                          Rules(maxReadCount: 1, trackActivityProgress: true),
                      description:
                          "Counting 1 to 10",
                      tts_description:
                          "Counting 1 to 10",
                      skill: "Listening"),
                  Activity(
                      activityId: "001003002",
                      id: "001003002",
                      subjectId: "001",
                      lessonId: "001003",
                      title: "How Many Fingers",
                      topic: "Alphabets",
                      activityTypeString: "YouTubeVideo",
                      activityType: 8,
                      content: "https://www.youtube.com/watch?v=xNw1SSz18Gg",
                      grade: 0,
                      subject: 0,
                      semester: 0,
                      session: 2023,
                      thumbnail:
                          "",
                      sequence: 2,
                      readCount: 0,
                      completePercent: 0,
                      assessment: null,
                      rules:
                          Rules(maxReadCount: 1, trackActivityProgress: true),
                      description:
                          "How Many Fingers",
                      tts_description:
                          "How Many Fingers",
                      skill: "Cognitive"),
                  Activity(
                      tts_description: "Activity",
                      activityId: "001003004",
                      id: "0001003004",
                      lessonId: "001003",
                      subjectId: "001",
                      title: "Activity",
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
                                tts_description: "How Many Fingers shown in the image?",
                                quizType: "MultipleChoice",
                                id: "0010030041",
                                image:
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGamBKU-3eKVTdklv35l2Yy5ZnPNYEFg7eNg&s",
                                question: "How Many Fingers shown in the image?",
                                answerList: [
                                  AnswerList(
                                      id: "00100300411",
                                      tts_description: "3",
                                      answer: "3",
                                      image:
                                          "",
                                      isCorrect: true),
                                  AnswerList(
                                      id: "00100300412",
                                      tts_description: "4",
                                      answer: "4",
                                      image:
                                          "",
                                      isCorrect: false),
                                  AnswerList(
                                      id: "00100300413",
                                      tts_description: "2",
                                      answer: "2",
                                      image:
                                          "",
                                      isCorrect: false),
                                  AnswerList(
                                      id: "00100300414",
                                      tts_description: "1",
                                      answer: "1",
                                      image:
                                          "",
                                      isCorrect: false)
                                ],
                                questionList: []),
                            Quiz(
                                tts_description: "Is there two bananas in the image",
                                quizType: "TrueFalse",
                                id: "0010030041",
                                image:
                                    "https://static.vecteezy.com/system/resources/thumbnails/024/734/340/small_2x/cartoon-illustration-of-two-bananas-vector.jpg",
                                question: "Is there two bananas in the image?",
                                answerList: [
                                  AnswerList(
                                      id: "00100300411",
                                      tts_description: "True",
                                      answer: "True",
                                      image:"",
                                      isCorrect: true),
                                  AnswerList(
                                      id: "00100300414",
                                      tts_description: "False",
                                      answer: "False",
                                      image:"",
                                      isCorrect: false)
                                ],
                                questionList: []),
                          ]),
                      rules:
                          Rules(maxReadCount: 1, trackActivityProgress: true)),
                ]),
          ]);
      await locator<IHiveService<Subject>>().addOrUpdate(engSubject);
      _navigationService.pushNamedAndRemoveUntil(
        Routes.home,
        args: TransitionType.fade,
      );
    } catch (e, s) {
      _globalService.logError(
          "Error Occured on Startup Logic", e.toString(), s);
      debugPrint(e.toString());
    }
  }
}
