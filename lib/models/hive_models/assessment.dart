import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';
import 'package:learning_app/models/hive_models/quiz.dart';

part '../g/assessment.g.dart';

@HiveType(typeId: 7)
class Assessment extends IHiveBaseModel<Assessment> {
  @HiveField(0)
    num? noOfQuizToAsk;
     @HiveField(1)
    num? correctNoOfQuizToPass;
     @HiveField(2)
    bool? isRequired;
     @HiveField(3)
    num? maxTryAttempts;
     @HiveField(4)
    List<Quiz>? quizzes;

  dynamic keyId;

  bool get isPass{
      return quizzes!.where((x)=>x.correctAnswered).length >= correctNoOfQuizToPass!;
    }

    Assessment({
        this.noOfQuizToAsk,
        this.correctNoOfQuizToPass,
        this.isRequired,
        this.maxTryAttempts,
        this.quizzes,
    });

    factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
        noOfQuizToAsk: json["NoOfQuizToAsk"],
        correctNoOfQuizToPass: json["CorrectNoOfQuizToPass"],
        isRequired: json["IsRequired"],
        maxTryAttempts: json["MaxTryAttempts"],
        quizzes: json["Quizzes"]!=null? List<Quiz>.from(json["Quizzes"].map((x) => Quiz.fromJson(x))):null,
    );

@override
  Assessment fromJson(Map<String, dynamic> json) => Assessment.fromJson(json);

@override
    Map<String, dynamic> toJson() => {
        "NoOfQuizToAsk": noOfQuizToAsk,
        "CorrectNoOfQuizToPass": correctNoOfQuizToPass,
        "IsRequired": isRequired,
        "MaxTryAttempts": maxTryAttempts,
        "Quizzes": List<dynamic>.from(quizzes!.map((x) => x.toJson())),
    };
}