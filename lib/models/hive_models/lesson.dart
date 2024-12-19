import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';
import 'package:learning_app/models/hive_models/activity.dart';

part '../g/lesson.g.dart';

@HiveType(typeId: 9)
class Lesson extends IHiveBaseModel<Lesson> {
  @HiveField(0)
    String? title;
    @HiveField(1)
    String? subjectId;
    @HiveField(2)
    String? id;
    @HiveField(3)
    String? topicId;
    @HiveField(4)
    num? sequence;
    @HiveField(5)
    bool? enable;
    @HiveField(6)
    num? completePercent;
    @HiveField(7)
    String? thumbnail;
    @HiveField(8)
    String? lessonEnable;
    @HiveField(9)
    List<Activity>? activities;
    @HiveField(10)
    num? totalActivities;

    dynamic keyId;
    @override
      bool selected=false;
    bool lock=false;
    bool get completed => !activities!.isNotEmpty || activities!.every((element) => element.completed);
    double get completeRatio{
      return activities!.where((x)=>x.completed).length / activities!.length;
    }
    String get completeString{
      return "  ${activities!.where((x)=>x.completed).length.toString()} / ${activities!.length.toString()}";
    }
    bool get locked{
      if(lock && !completed){
        return true;
      }
      return false;
    }

    Lesson({
        this.title,
        this.subjectId,
        this.id,
        this.topicId,
        this.sequence,
        this.enable,
        this.completePercent,
        this.thumbnail,
        this.lessonEnable,
        this.activities,
        this.totalActivities,
    });

    factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        title: json["title"],
        subjectId: json["subjectId"],
        id: json["id"],
        topicId: json["topicId"],
        sequence: json["sequence"],
        enable: json["enable"],
        completePercent: json["completePercent"],
        thumbnail: json["thumbnail"],
        lessonEnable: json["lessonEnable"],
        activities: json["activities"]!=null? List<Activity>.from(json["activities"].map((x) => Activity.fromJson(x))):null,
        totalActivities: json["totalActivities"],
    );

@override
  Lesson fromJson(Map<String, dynamic> json) => Lesson.fromJson(json);

@override
    Map<String, dynamic> toJson() => {
        "title": title,
        "subjectId": subjectId,
        "id": id,
        "topicId": topicId,
        "sequence": sequence,
        "enable": enable,
        "completePercent": completePercent,
        "thumbnail": thumbnail,
        "lessonEnable": lessonEnable,
        "activities": List<dynamic>.from(activities!.map((x) => x.toJson())),
        "totalActivities": totalActivities,
    };
}