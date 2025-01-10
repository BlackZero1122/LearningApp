import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';
import 'package:learning_app/models/hive_models/lesson.dart';

part '../g/subject.g.dart';

@HiveType(typeId: 19)
class Subject extends IHiveBaseModel<Subject> {
  @HiveField(0)
    String? id;
     @HiveField(1)
    String? name;
     @HiveField(2)
    String? code;
     @HiveField(3)
    num? completePercent;
     @HiveField(4)
    String? thumbnail;
     @HiveField(5)
    String? title;
     @HiveField(6)
    String? subject;
     @HiveField(7)
    List<Lesson>? lessons;
     @HiveField(8)
    String? courseId;
     @HiveField(9)
    String? courseName;
    @HiveField(10)
    String? description;
    @HiveField(11)
    String? tts_description;

    dynamic keyId;
    @override
      bool selected=false;
    bool get completed => !lessons!.isNotEmpty || lessons!.every((element) => element.completed);

    Subject({
        this.id,
        this.name,
        this.code,
        this.completePercent,
        this.thumbnail,
        this.title,
        this.subject,
        this.lessons,
        this.courseId,
        this.courseName, this.description, this.tts_description
    });

    double get completeRatio{
      return lessons!.where((x)=>x.completed).length / lessons!.length;
    }
    double get completeListenRatio{
      return lessons!.where((x)=>x.skill=="Listening").isEmpty ? 0 : lessons!.where((x)=>x.skill=="Listening" && x.completed).length / lessons!.where((x)=>x.skill=="Listening").length;
    }
    double get completeCogniRatio{
      return lessons!.where((x)=>x.skill=="Cognitive").isEmpty ? 0 : lessons!.where((x)=>x.skill=="Cognitive" && x.completed).length / lessons!.where((x)=>x.skill=="Cognitive").length;
    }
    double get completeVocabRatio{
      return lessons!.where((x)=>x.skill=="Vocabulary").isEmpty ? 0 : lessons!.where((x)=>x.skill=="Vocabulary" && x.completed).length / lessons!.where((x)=>x.skill=="Vocabulary").length;
    }
    double get completeSociRatio{
      return lessons!.where((x)=>x.skill=="Social").isEmpty ? 0 : lessons!.where((x)=>x.skill=="Social" && x.completed).length / lessons!.where((x)=>x.skill=="Social").length;
    }
    String get completeString{
      return "  ${lessons!.where((x)=>x.completed).length.toString()} / ${lessons!.length.toString()}";
    }

    factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        description: json["description"],
        tts_description: json["tts_description"],
        id: json["id"],
        name: json["name"],
        code: json["code"],
        completePercent: json["completePercent"],
        thumbnail: json["thumbnail"],
        title: json["title"],
        subject: json["subject"],
        lessons: json["lessons"]!=null? List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))):null,
        courseId: json["courseId"],
        courseName: json["courseName"],
    );

    @override
  Subject fromJson(Map<String, dynamic> json) => Subject.fromJson(json);

@override
    Map<String, dynamic> toJson() => {
      "description": description,
      "tts_description": tts_description,
        "Id": id,
        "Name": name,
        "Code": code,
        "CompletePercent": completePercent??"",
        "Thumbnail": thumbnail,
        "title": title,
        "subject": subject,
        "lessons": List<dynamic>.from(lessons!.map((x) => x.toJson())),
        "courseId": courseId,
        "courseName": courseName,
    };
}