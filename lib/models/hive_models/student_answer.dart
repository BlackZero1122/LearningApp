// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';

part '../g/student_answer.g.dart';

@HiveType(typeId: 16)
class StudentAnswer extends IHiveBaseModel<StudentAnswer> {
  @HiveField(0)
    String? question_id;
     @HiveField(1)
    String? answer;
     @HiveField(2)
    String? question;
     @HiveField(3)
    String? correct_answer;
    @HiveField(4)
    bool? is_correct;

  dynamic keyId;

    StudentAnswer({
        this.question_id,
        this.answer,
        this.question,
        this.correct_answer,
        this.is_correct,
    });

    factory StudentAnswer.fromJson(Map<String, dynamic> json) => StudentAnswer(
        question_id: json["question_id"],
        answer: json["answer"],
        question: json["question"],
        correct_answer: json["correct_answer"],
        is_correct: json["is_correct"],
    );

@override
  StudentAnswer fromJson(Map<String, dynamic> json) => StudentAnswer.fromJson(json);

@override
    Map<String, dynamic> toJson() => {
        "question_id": question_id,
        "answer": answer,
        "question": question,
        "correct_answer": correct_answer,
        "is_correct": is_correct,
    };
}