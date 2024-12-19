import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';

part '../g/subject_list.g.dart';

@HiveType(typeId: 17)
class SubjectList extends IHiveBaseModel<SubjectList> {
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
    String? courseId;

dynamic keyId;

    SubjectList({
        this.id,
        this.name,
        this.code,
        this.completePercent,
        this.thumbnail,
         this.courseId,
    });

    factory SubjectList.fromJson(Map<String, dynamic> json) => SubjectList(
        id: json["Id"],
        name: json["Name"],
        code: json["Code"],
        completePercent: json["CompletePercent"],
        thumbnail: json["Thumbnail"],
        courseId: json["CourseId"],
    );

    @override
  SubjectList fromJson(Map<String, dynamic> json) => SubjectList.fromJson(json);

@override
    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Code": code,
        "CompletePercent": completePercent,
        "Thumbnail": thumbnail,
        "CourseId": courseId,
    };
}