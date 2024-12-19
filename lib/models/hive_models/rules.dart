import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';

part '../g/rules.g.dart';

@HiveType(typeId: 14)
class Rules extends IHiveBaseModel<Rules> {
  @HiveField(0)
    num maxReadCount;
    @HiveField(1)
    bool trackActivityProgress;
    @HiveField(2)
    num percentToComplete;
    @HiveField(3)
    bool allowBackwardSeek;
     @HiveField(4)
    bool allowForwardSeek;
    @HiveField(5)
    num seekDurationInSeconds;

       dynamic keyId;

    Rules({ this.seekDurationInSeconds=5, this.allowForwardSeek=false, this.percentToComplete=100, this.allowBackwardSeek=true,
        this.maxReadCount=1,
        this.trackActivityProgress=true,
    });

    factory Rules.fromJson(Map<String, dynamic> json) => Rules(
        maxReadCount: json["MaxReadCount"] ?? 1,
        trackActivityProgress: json["TrackActivityProgress"] ?? true,
        percentToComplete: json["PercentToComplete"] ?? 100,
        allowBackwardSeek: json["AllowBackwardSeek"] ?? true,
        allowForwardSeek: json["AllowForwardSeek"] ?? false,
        seekDurationInSeconds: json["SeekDurationInSeconds"] ?? 10,
    );

@override
  Rules fromJson(Map<String, dynamic> json) => Rules.fromJson(json);

@override
    Map<String, dynamic> toJson() => {
        "MaxReadCount": maxReadCount,
        "TrackActivityProgress": trackActivityProgress,
        "PercentToComplete": percentToComplete,
        "AllowBackwardSeek": allowBackwardSeek,
        "AllowForwardSeek": allowForwardSeek,
        "SeekDurationInSeconds": seekDurationInSeconds,
    };
}