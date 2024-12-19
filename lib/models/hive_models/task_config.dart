import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';

part '../g/task_config.g.dart';

@HiveType(typeId: 1)
class TaskConfig extends IHiveBaseModel<TaskConfig> {
  @HiveField(0)
  String id;
  @HiveField(1)
  bool enable;
  @HiveField(2)
  num limit;

  TaskConfig(
    this.id,
    this.enable,
    this.limit,
  );

  @override
  TaskConfig fromJson(Map<String, dynamic> json) => TaskConfig.fromJson(json);

  factory TaskConfig.fromJson(Map<String, dynamic> json) => TaskConfig(
        json["id"],
        json["enable"],
        json["limit"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "enable": enable,
        "limit": limit,
      };
}
