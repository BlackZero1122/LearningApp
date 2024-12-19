// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';
import 'package:learning_app/models/hive_models/score.dart';
import 'package:learning_app/models/hive_models/student_answer.dart';

part '../g/result.g.dart';

@HiveType(typeId: 13)
class Result extends IHiveBaseModel<Result> {
  @HiveField(0)
    Score? score;
     @HiveField(1)
    bool? completion;
     @HiveField(2)
    bool? success;
     @HiveField(3)
    String? duration;
      @HiveField(4)
    String? response;
    @HiveField(5)
    List<StudentAnswer>? student_answers;
    @HiveField(6)
    bool? force;

  dynamic keyId;

    Result({ this.force,
        this.score,
        this.completion,
        this.success,
        this.duration,
         this.response,
         this.student_answers
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        score: json["score"]!=null ? Score.fromJson(json["score"]):null,
        completion: json["completion"],
        success: json["success"],
        duration: json["duration"],
        response: json["response"],
        force: json["force"],
        student_answers: json["student_answers"]!=null? List<StudentAnswer>.from(json["student_answers"].map((x) => StudentAnswer.fromJson(x))):null,
    );

@override
  Result fromJson(Map<String, dynamic> json) => Result.fromJson(json);

@override
    Map<String, dynamic> toJson() => {
        "score": score!.toJson(),
        "completion": completion,
        "success": success,
        "duration": duration,
         "response": response,
         "force": force,
         "student_answers": student_answers!=null ? List<dynamic>.from(student_answers!.map((x) => x.toJson())):null,
    };
}