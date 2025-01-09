
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/models/hive_models/activity.dart';
import 'package:learning_app/models/hive_models/answer_list.dart';
import 'package:learning_app/models/hive_models/api_queue.dart';
import 'package:learning_app/models/hive_models/assessment.dart';
import 'package:learning_app/models/hive_models/progress.dart';
import 'package:learning_app/models/hive_models/quiz.dart';
import 'package:learning_app/models/hive_models/result.dart';
import 'package:learning_app/models/hive_models/score.dart';
import 'package:learning_app/models/hive_models/student_answer.dart';
import 'package:learning_app/models/hive_models/subject.dart';
import 'package:learning_app/services/db_service.dart';
import 'package:learning_app/services/dialog_service.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/services/schedule_service.dart';
import 'package:learning_app/view_models/base_view_model.dart';
import 'package:learning_app/view_models/home_view_model.dart';

class ActivityViewModel extends BaseViewModel {

  GlobalService get _globalService => locator<GlobalService>();
  HomeViewModel get _homeViewModel => locator<HomeViewModel>();
  IDialogService get _dialogService => locator<IDialogService>();
  ScheduleService get _scheduleService => locator<ScheduleService>();

  bool _quizLoading=false;
  bool get quizLoading => _quizLoading;
  setQuizLoading(bool quizLoading) async {
    _quizLoading = quizLoading;
    notifyListeners();
  }

  bool _showResult = false;

  bool get showResult => _showResult;

  setShowResult(bool showResult) async {
    _showResult = showResult;
  }

  Assessment _currentAssessment = Assessment();

  Assessment get currentAssessment => _currentAssessment;

  setCurrentAssessment(Assessment currentAssessment) async {
    _currentAssessment = currentAssessment;
  }

  Activity? _currentActivity;

  Activity? get currentActivity => _currentActivity;

  setCurrentActivity(Activity? currentActivity) async {
    _currentActivity = currentActivity;
    notifyListeners();
  }

  Quiz _currentQuiz = Quiz();

  Quiz get currentQuiz => _currentQuiz;

  setCurrentQuiz(Quiz currentQuiz) async {
    _currentQuiz = currentQuiz;
  }

 int _quizIndex = 0;

  int get quizIndex => _quizIndex;

  setQuizIndex(int quizIndex) async {
    _quizIndex = quizIndex;
  }

  bool get isFirstActivity => _homeViewModel.isFirstActivity;

  bool get isLastActivity => _homeViewModel.isLastActivity;

  Future<void> init(Activity? act) async {
    try {
      _globalService.log("Starting Activity (${act?.title??''})");
      imagecomplete=false;
      pdfcomplete=false;
      if(act!=null){
        setShowResult(false);
        //setCurrentActivity(null);
        //await Future.delayed(const Duration(milliseconds: 500));
        setCurrentActivity(act);
        if(act.activityTypeString!.toLowerCase()=="quiz"){
          if(act.assessment!=null){
            // for (var quiz in act.assessment?.quizzes??[]) {
            //   for (var ans in quiz.answerList??[]) {
            //     if(ans.image!=null){
            //       ans.image=await _globalService.replaceContentServer(ans.image!);
            //     }
            //   }
            //   if(quiz.image!=null){
            //     quiz.image=await _globalService.replaceContentServer(quiz.image!);
            //   }
            // }
            await initAssessment(act.assessment!);
          }
          else{
            await initAssessment(Assessment());
          }
        }
        // if(act.activityTypeString!.toLowerCase()=="video"){
        //   if(act.content!=null){
        //     act.content=await _globalService.replaceContentServer(act.content!);
        //   }
        // }
        // if(act.activityTypeString!.toLowerCase()=="image"){
        //   if(act.content!=null){
        //     act.content=await _globalService.replaceContentServer(act.content!);
        //   }
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

  Future initAssessment(Assessment assessment) async {
    try {
      _globalService.log("Starting Assessment");
      setQuizIndex(0);
      assessment.quizzes?.forEach((element) { element.answer=""; element.answerList?.forEach((element) { element.selected=false; }); });
      setCurrentAssessment(assessment);
      for (var quiz in assessment.quizzes!) {
        quiz.answerList!.shuffle();
      }
      setCurrentQuiz(assessment.quizzes![_quizIndex]);
    } catch (e,s) {
      _globalService.logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
    finally{

    }
  }

  void setQuizAnswer(AnswerList index) {
    try {
      currentQuiz.answerList?.forEach((element) => element.selected=false);
      currentQuiz.answerList!.firstWhere((x)=>x.id==index.id).selected=true;
                                            currentQuiz.answer = currentQuiz.answerList!.firstWhere((x)=>x.id==index.id).answer;
    } catch (e,s) {
      _globalService.logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
    finally{
      notifyListeners();
    }
  }

  Future<void> setNextQuiz() async {
    try {
      setQuizLoading(true);
      await Future.delayed(const Duration(milliseconds: 500));
      _quizIndex=_quizIndex+1;
      setCurrentQuiz(currentAssessment.quizzes![_quizIndex]);
    } catch (e,s) {
      _globalService.logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
    finally{
      setQuizLoading(false);
    }
  }

  Future<void> setPreQuiz() async {
     try {
      setQuizLoading(true);
      await Future.delayed(const Duration(microseconds: 500));
      _quizIndex=_quizIndex-1;
    setCurrentQuiz(currentAssessment.quizzes![_quizIndex]);
    } catch (e,s) {
      _globalService.logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
    finally{
      setQuizLoading(false);
    }
  }

  void submitQuiz() {
    try {
      _globalService.log("Submit Assessment");
      setShowResult(true);
      List<StudentAnswer> stdAnswers = [];
      for (var item in currentAssessment.quizzes!) {
        stdAnswers.add(StudentAnswer(question_id: item.id, question: item.questionFull, answer: item.answer, correct_answer: item.correctAnswer, is_correct: item.correctAnswered ));
      }
      if((currentActivity!=null && (currentActivity!.rules?.trackActivityProgress??true))){
        markAsComplete(false, currentActivity!, Result(student_answers: stdAnswers, completion: true, duration: "", response: "", success: currentAssessment.isPass, score: Score(max: currentAssessment.quizzes!.length, min: 0, raw: currentAssessment.quizzes!.where((x)=>x.correctAnswered).length, scaled: 0)));
      }
    } catch (e,s) {
      _globalService.logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
    finally{
      notifyListeners();
    }
  }

  Future<void> markAsComplete(bool override, Activity activity, Result? result) async {
    try {
      // if(override){
      //   if(_globalService.user!.rights!.where((x)=>x.title!.toLowerCase()=="mark activity as read").firstOrNull == null){
      //     var res = await _dialogService.showOverride(Message(description: "you want to mark this activity as read"));
      //     if(!res){
      //       return;
      //     }
      //   }
      // }
      _globalService.log("Mark Activity As Complete");
      result ??= Result(
          force:override,
          completion: true,
          duration: "",
          response: "",
          success: true,
          score: Score(
            min: 0,
            max: 0,
            raw: 0,
            scaled: 0
          )
        );
      num rdCount=0;
        if(activity.activityTypeString!.toLowerCase() == "quiz"){
          if(result.success!){
            rdCount=activity.readCount!+1;
          }else{
            rdCount=activity.readCount!;
          }
          
        }else{
          rdCount=activity.readCount!+1;
        }
      saveProgressInQueue(Progress(
        activityName: activity.title,
        totalActivities : _homeViewModel.getSelectedLesson!.totalActivities,
        day:_homeViewModel.getSelectedLesson!.sequence,
        url : activity.content??"",
        topicId : num.parse(_homeViewModel.getSelectedLesson!.topicId!),
        topic: _homeViewModel.getSelectedLesson!.title,
        activityId: num.parse(activity.activityId!),
        activityTypeString:  activity.activityTypeString,
        readCount: rdCount,
        readDate:  DateTime.now(),
        lessonCompleted:  result.success,
        //studentId:  _globalService.user!.studentId,
        studentId: 0,
        result: result
      ));

      var sub = await locator<IHiveService<Subject>>().getFirst(activity.subId!);
      if(sub!=null){
        var lsn = sub.lessons!.where((x)=>x.topicId == activity.lsnId).firstOrNull;
        if(lsn!=null){
          var act = lsn.activities!.where((x)=>x.activityId == activity.activityId).firstOrNull;
          if(act!=null){
            act.readCount = rdCount;
            await locator<IHiveService<Subject>>().update(sub.key, sub);
            currentActivity!.readCount=act.readCount;
          }
        }
      }
      if(currentActivity!.readCount! >= (currentActivity?.rules?.maxReadCount??1)){
        await _homeViewModel.unlockNextActivity();
      }
    } catch (e,s) {
      _globalService.logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
    finally{
      notifyListeners();
    }
  }
  
  bool imagecomplete=false;
  bool pdfcomplete=false;

  nextActivity() async {
    try {
      await _homeViewModel.playNextActivity();
    } catch (e,s) {
      _globalService.logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
    finally{
      notifyListeners();
    }
  }

  preActivity() async {
    try {
      await _homeViewModel.playPreActivity();
    } catch (e,s) {
      _globalService.logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
    finally{
      notifyListeners();
    }
  }
  
  Future<void> saveProgressInQueue(Progress prog) async {
    try {
      var id = prog.topicId.toString()+prog.activityId.toString();
      await locator<IHiveService<APIQueue>>().add(APIQueue(
          printed: false,
          id: id,
          data: prog,
          type: 1));
      var api = await locator<IHiveService<APIQueue>>()
          .getFirst(id);
      if (api != null) {
        _globalService.log("Save Progress In Queue");
         api.keyId = api.key;
        await _scheduleService.addToQueue(api);
      }
    } catch (e,s) {
      _globalService.logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
  }
}