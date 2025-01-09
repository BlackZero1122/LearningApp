import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';

part '../g/answer_list.g.dart';

@HiveType(typeId: 6)
class AnswerList extends IHiveBaseModel<AnswerList> {
  @HiveField(0)
    String? id;
     @HiveField(1)
    String? answer;
     @HiveField(2)
    String? image;
     @HiveField(3)
    bool? isCorrect;
    @HiveField(4)
    String? description;
    @HiveField(5)
    String? tts_description;

  dynamic keyId;
  @override
  bool selected=false;

    AnswerList({
        this.id,
        this.answer,
        this.image,
        this.isCorrect, this.description, this.tts_description,
    });

    factory AnswerList.fromJson(Map<String, dynamic> json) => AnswerList(
      description: json["description"],
        tts_description: json["tts_description"],
        id: json["Id"],
        answer: json["Answer"],
        image: json["Image"],
        isCorrect: json["IsCorrect"],
    );

@override
  AnswerList fromJson(Map<String, dynamic> json) => AnswerList.fromJson(json);

@override
    Map<String, dynamic> toJson() => {
      "description": description,
      "tts_description": tts_description,
        "Id": id,
        "Answer": answer,
        "Image": image,
        "IsCorrect": isCorrect,
    };
}