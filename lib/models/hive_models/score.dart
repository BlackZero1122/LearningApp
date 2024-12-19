import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';

part '../g/score.g.dart';

@HiveType(typeId: 15)
class Score extends IHiveBaseModel<Score> {
  @HiveField(0)
    num? min;
     @HiveField(1)
    num? max;
     @HiveField(2)
    num? raw;
     @HiveField(3)
    num? scaled;

  dynamic keyId;

    Score({
        this.min,
        this.max,
        this.raw,
        this.scaled
    });

    factory Score.fromJson(Map<String, dynamic> json) => Score(
        min: json["min"],
        max: json["max"],
        raw: json["raw"],
        scaled: json["scaled"]
    );

@override
  Score fromJson(Map<String, dynamic> json) => Score.fromJson(json);

@override
    Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
        "raw": raw,
        "scaled": scaled
    };
}