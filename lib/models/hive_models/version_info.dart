import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';

part '../g/version_info.g.dart';

@HiveType(typeId: 4)
class VersionInfo extends IHiveBaseModel<VersionInfo> {
  @HiveField(0)
  String? id;
  @HiveField(1)
  num? dataItem;
  @HiveField(2)
  num? version;
  @HiveField(3)
  DateTime? lastUpdated;
  @HiveField(4)
  bool? synced;

  dynamic keyId;

  VersionInfo({
    this.id,
    this.dataItem,
    this.version,
    this.lastUpdated,
    this.synced
  });

  factory VersionInfo.fromJson(Map<String, dynamic> json) => VersionInfo(
        id: json["id"],
        dataItem: json["dataItem"],
        version: json["version"],
        lastUpdated: DateTime.parse(json["lastUpdated"]),
        synced: json["synced"],
      );

  @override
  VersionInfo fromJson(Map<String, dynamic> json) => VersionInfo.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "dataItem": dataItem,
        "version": version,
        "lastUpdated": lastUpdated,
        "synced": synced,
      };
}
