import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';
import 'package:learning_app/models/hive_models/result.dart';

part '../g/progress.g.dart';

@HiveType(typeId: 10)
class Progress extends IHiveBaseModel<Progress> {
  @HiveField(0)
    num? activityId;
     @HiveField(1)
    String? activityTypeString;
     @HiveField(2)
    num? studentId;
     @HiveField(3)
    DateTime? readDate;
      @HiveField(4)
    num? readCount;
     @HiveField(5)
    bool? lessonCompleted;
     @HiveField(6)
    Result? result;
     @HiveField(7)
    String? topic;
     @HiveField(8)
    num? topicId;
      @HiveField(9)
    num? day;
     @HiveField(10)
    num? totalActivities;
     @HiveField(11)
    String? activityName;
     @HiveField(12)
    String? url;
    @HiveField(13)
    String? id;

  dynamic keyId;

    Progress({
        this.activityId,
        this.activityTypeString,
        this.studentId,
        this.readDate,
         this.readCount,
        this.lessonCompleted,
        this.result,
        this.topic,
         this.topicId,
        this.day,
        this.totalActivities,
        this.activityName,
         this.url,
         this.id
    });

    factory Progress.fromJson(Map<String, dynamic> json) => Progress(
        activityId: json["ActivityId"],
        activityTypeString: json["ActivityTypeString"],
        studentId: json["StudentId"],
        readDate: DateTime.parse(json["ReadDate"]),
        readCount: json["ReadCount"],
        lessonCompleted: json["LessonCompleted"],
       result: json["result"]!=null ? Result.fromJson(json["result"]):null,
        topic: json["Topic"],
        topicId: json["TopicId"],
        day: json["Day"],
        totalActivities: json["TotalActivities"],
        activityName: json["ActivityName"],
        url: json["URL"],
         id: json["Id"],
    );

@override
  Progress fromJson(Map<String, dynamic> json) => Progress.fromJson(json);

@override
    Map<String, dynamic> toJson() => {
        "ActivityId": activityId,
        "ActivityTypeString": activityTypeString,
        "StudentId": studentId,
        "ReadDate": readDate!.toIso8601String(),
         "ReadCount": readCount,
        "LessonCompleted": lessonCompleted,
        "Result": result!.toJson(),
        "Topic": topic,
         "TopicId": topicId,
        "Day": day,
        "TotalActivities": totalActivities,
        "ActivityName": activityName,
        "URL": url,
    };
}