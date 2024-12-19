import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';
import 'package:learning_app/models/hive_models/assessment.dart';
import 'package:learning_app/models/hive_models/rules.dart';
part '../g/activity.g.dart';

@HiveType(typeId: 5)
class Activity extends IHiveBaseModel<Activity> {
   @HiveField(0)
    String? activityId;
     @HiveField(1)
    String? id;
     @HiveField(2)
    String? lessonId;
     @HiveField(3)
    String? subjectId;
     @HiveField(4)
    String? title;
     @HiveField(5)
    String? topic;
     @HiveField(6)
    String? activityTypeString;
     @HiveField(7)
    num? activityType;
     @HiveField(8)
    String? content;
     @HiveField(9)
    num? grade;
     @HiveField(10)
    num? subject;
     @HiveField(11)
    num? semester;
     @HiveField(12)
    num? session;
     @HiveField(13)
    String? thumbnail;
     @HiveField(14)
    num? sequence;
     @HiveField(15)
    num? readCount;
     @HiveField(16)
    num? completePercent;
     @HiveField(17)
    Assessment? assessment;
     @HiveField(18)
    Rules? rules;

   dynamic keyId;
   @override
     bool selected=false;
   bool lock=false;
   String? subId;
   String? lsnId;


   bool get completed => (readCount! >= (rules?.maxReadCount??1) || !(rules?.trackActivityProgress??true));
   bool get locked{
      if(lock && !completed){
        return true;
      }
      return false;
    }
    String get getCompleteString{
      return "$readCount/${rules?.maxReadCount??1}";
    }

    IconData get icon{
      switch (activityTypeString!.toLowerCase()) {
        case 'quiz':
          return Icons.help_center;
        case 'video':
          return Icons.smart_display;
        case 'image':
          return Icons.panorama;
        case 'pdf':
          return Icons.description;
        default:
      }
      return Icons.smart_display;
    }

    Activity({
        this.activityId,
        this.id,
        this.lessonId,
        this.subjectId,
        this.title,
        this.topic,
        this.activityTypeString,
        this.activityType,
        this.content,
        this.grade,
        this.subject,
        this.semester,
        this.session,
        this.thumbnail,
        this.sequence,
        this.readCount,
        this.completePercent,
        this.assessment,
        this.rules,
    });

    // Copy constructor
    Activity.copy(Activity other)
        : activityId = other.activityId,
          id = other.id,
          lessonId = other.lessonId,
          subjectId = other.subjectId,
          title = other.title,
          topic = other.topic,
          activityTypeString = other.activityTypeString,
          activityType = other.activityType,
          content = other.content,
          grade = other.grade,
          subject = other.subject,
          semester = other.semester,
          session = other.session,
          thumbnail = other.thumbnail,
          sequence = other.sequence,
          readCount = other.readCount,
          completePercent = other.completePercent,
          assessment = other.assessment,
          rules = other.rules;

    factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        activityId: json["activityId"],
        id: json["id"],
        lessonId: json["lessonId"],
        subjectId: json["subjectId"],
        title: json["title"],
        topic: json["topic"],
        activityTypeString: json["activityTypeString"],
        activityType: json["activityType"],
        content: json["content"],
        grade: json["grade"],
        subject: json["subject"],
        semester: json["semester"],
        session: json["session"],
        thumbnail: json["thumbnail"],
        sequence: json["sequence"],
        readCount: json["ReadCount"],
        completePercent: json["CompletePercent"],
        assessment: json["Assessment"]!=null ? Assessment.fromJson(json["Assessment"]):null,
        rules: json["Rules"]!=null? Rules.fromJson(json["Rules"]):null,
    );

@override
  Activity fromJson(Map<String, dynamic> json) => Activity.fromJson(json);

@override
    Map<String, dynamic> toJson() => {
        "activityId": activityId,
        "id": id,
        "lessonId": lessonId,
        "subjectId": subjectId,
        "title": title,
        "topic": topic,
        "activityTypeString": activityTypeString,
        "activityType": activityType,
        "content": content,
        "grade": grade,
        "subject": subject,
        "semester": semester,
        "session": session,
        "thumbnail": thumbnail,
        "sequence": sequence,
        "ReadCount": readCount,
        "CompletePercent": completePercent,
        "Assessment": assessment!.toJson(),
        "Rules": rules!.toJson(),
    };
}