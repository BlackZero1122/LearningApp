import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';
import 'package:learning_app/models/hive_models/answer_list.dart';
import 'package:learning_app/models/hive_models/question_list.dart';

part '../g/quiz.g.dart';

@HiveType(typeId: 12)
class Quiz extends IHiveBaseModel<Quiz> {
  @HiveField(0)
    String? quizType;
    @HiveField(1)
    String? id;
    @HiveField(2)
    String? image;
    @HiveField(3)
    String? question;
    @HiveField(4)
    List<AnswerList>? answerList;
    @HiveField(5)
    List<QuestionList>? questionList;
    @HiveField(6)
    String? answer;
    @HiveField(7)
    String? description;
    @HiveField(8)
    String? tts_description;

  dynamic keyId;

    Quiz({
        this.quizType,
        this.id,
        this.image,
        this.question,
        this.answerList,
        this.questionList,
        this.answer, this.description, this.tts_description,
    });

    String get questionFull {
      if(quizType!.toLowerCase() == "mathquestion"){
        return "${questionList![0].question!} ${question!} ${questionList![1].question!} = ";
      }
      return question??"";
    }

    bool get correctAnswered {
      if(quizType!.toLowerCase() == "shortanswer"){
        return true;
      }
      else if(quizType!.toLowerCase() == "fillinblank" || quizType!.toLowerCase() == "mathquestion"){
        if(answer!=null && answer!.isNotEmpty){
          return answerList!.any((x)=>x.answer!.toLowerCase().trim()== answer!.toLowerCase().trim());
        }
      }
      else if(answerList!.any((x)=>x.selected)) {
        if(answerList?.firstWhereOrNull((x)=>x.selected)?.isCorrect??null != null){
          return true;
        }
      }
      return false;
    }

    String get correctAnswer {
      String ans = "";
      if(answerList!=null && answerList!.isNotEmpty){
        for (var item in answerList!.where((x)=>x.isCorrect!))
        {
            ans += "${item.answer!}, ";
        }
        if (ans.endsWith(", "))
        {
            ans = ans.substring(0, ans.length - 2);
        }
      }
      return ans;
    }

    bool get answered {
      if(quizType!.toLowerCase() == "shortanswer"){
        return true;
      }
      else if(quizType!.toLowerCase() == "fillinblank" || quizType!.toLowerCase() == "mathquestion"){
        if(answer!=null && answer!.isNotEmpty){
          return true;
        }
      }
      else if(answerList!.any((x)=>x.selected)) {
        return true;
      }
      return false;
    }

    factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
      description: json["description"],
        tts_description: json["tts_description"],
        quizType: json["QuizType"],
        id: json["Id"],
        image: json["Image"],
        answer: json["answer"],
        question: json["Question"],
        answerList: json["AnswerList"]!=null? List<AnswerList>.from(json["AnswerList"].map((x) => AnswerList.fromJson(x))):null,
        questionList: json["questionList"]!=null? List<QuestionList>.from(json["questionList"].map((x) => QuestionList.fromJson(x))):null,
    );

@override
  Quiz fromJson(Map<String, dynamic> json) => Quiz.fromJson(json);

@override
    Map<String, dynamic> toJson() => {
      "description": description,
      "tts_description": tts_description,
        "QuizType": quizType,
        "Id": id,
        "answer": answer,
        "Image": image,
        "Question": question,
        "AnswerList": List<dynamic>.from(answerList!.map((x) => x.toJson())),
        "questionList": List<dynamic>.from(questionList!.map((x) => x.toJson())),
    };
}