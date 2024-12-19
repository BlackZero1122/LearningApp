import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';

part '../g/question_list.g.dart';

@HiveType(typeId: 11)
class QuestionList extends IHiveBaseModel<QuestionList> {
  @HiveField(0)
    String? id;
     @HiveField(1)
    String? question;
     @HiveField(2)
    String? image;

  dynamic keyId;
  @override
  bool selected=false;

    QuestionList({
        this.id,
        this.question,
        this.image,
    });

    factory QuestionList.fromJson(Map<String, dynamic> json) => QuestionList(
        id: json["Id"],
        question: json["question"],
        image: json["Image"],
    );

@override
  QuestionList fromJson(Map<String, dynamic> json) => QuestionList.fromJson(json);

@override
    Map<String, dynamic> toJson() => {
        "Id": id,
        "question": question,
        "Image": image,
    };
}