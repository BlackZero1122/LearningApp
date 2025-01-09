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
    @HiveField(3)
    String? description;
    @HiveField(4)
    String? tts_description;

  dynamic keyId;
  @override
  bool selected=false;

    QuestionList({
        this.id,
        this.question,
        this.image, this.description, this.tts_description,
    });

    factory QuestionList.fromJson(Map<String, dynamic> json) => QuestionList(
      description: json["description"],
        tts_description: json["tts_description"],
        id: json["Id"],
        question: json["question"],
        image: json["Image"],
    );

@override
  QuestionList fromJson(Map<String, dynamic> json) => QuestionList.fromJson(json);

@override
    Map<String, dynamic> toJson() => {
      "description": description,
      "tts_description": tts_description,
        "Id": id,
        "question": question,
        "Image": image,
    };
}