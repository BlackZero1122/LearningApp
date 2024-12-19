import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';

part '../g/lesson_req.g.dart';

@HiveType(typeId: 8)
class LessonRequest extends IHiveBaseModel<LessonRequest> {
  @HiveField(0)
    num gradeId;
    @HiveField(1)
    num subjectId;
    @HiveField(2)
    num semester;
    @HiveField(3)
    num sessionId;
    @HiveField(4)
    num studentId;
    @HiveField(5)
    num schoolId;

    LessonRequest({
        required this.gradeId,
        required this.subjectId,
        required this.semester,
        required this.sessionId,
        required this.studentId,
        required this.schoolId,
    });

    factory LessonRequest.fromJson(Map<String, dynamic> json) => LessonRequest(
        gradeId: json["grade_id"],
        subjectId: json["subject_id"],
        semester: json["semester"],
        sessionId: json["session_id"],
        studentId: json["student_id"],
        schoolId: json["school_id"],
    );

     @override
    LessonRequest fromJson(Map<String, dynamic> json) => LessonRequest.fromJson(json);

    @override
    Map<String, dynamic> toJson() => {
        "grade_id": gradeId,
        "subject_id": subjectId,
        "semester": semester,
        "session_id": sessionId,
        "student_id": studentId,
        "school_id": schoolId,
    };
}