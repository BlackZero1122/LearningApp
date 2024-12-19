import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';
import 'package:learning_app/models/hive_models/task_config.dart';

part '../g/todo.g.dart';

@HiveType(typeId: 2)
class Todo extends IHiveBaseModel<Todo> {
  @HiveField(0)
  String id;
  @HiveField(1)
  String user;
  @HiveField(2)
  String task;
  @HiveField(3)
  String description;
  @HiveField(4)
  bool completed;
  @HiveField(5)
  List<String> users;
  @HiveField(6)
  TaskConfig configs;

  dynamic keyId;

  Todo(this.id, this.user, this.task, this.description, this.completed, this.users, this.configs);

@override
Todo fromJson(Map<String, dynamic> json) => Todo.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "task": task,
    "description": description,
    "completed": completed,
    "users": users,
    "configs": configs,
  };
  
  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    json["id"],
    json["user"],
    json["task"],
    json["description"],
    json["completed"],
    json["users"],
    json["configs"],
  );
}