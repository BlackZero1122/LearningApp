
import 'package:learning_app/models/base_model.dart';

class ManagerOverridenRequest extends IBaseModel<ManagerOverridenRequest> {
  String? locationId;
  String? overrideCode;
  String? rightId;
  num? managerOverrideBy;
  String? locationName;
  String? registerId;
  String? registerName;
  String? userId;
  String? username;
  String? rightName;

  ManagerOverridenRequest({this.locationId, this.overrideCode, this.rightId, this.managerOverrideBy, this.locationName, this.registerName, this.registerId, this.userId, this.username, this.rightName});

@override
ManagerOverridenRequest fromJson(Map<String, dynamic> json) => ManagerOverridenRequest.fromJson(json);

  factory ManagerOverridenRequest.fromJson(Map<String, dynamic> json) => ManagerOverridenRequest(
        locationId: json['locationId'] as String?,
        overrideCode: json['override'] as String?,
        rightId: json['rightId'] as String?,
        managerOverrideBy: json['managerOverrideBy'] as num?,
        locationName: json['locationName'] as String?,
        registerId: json['registerId'] as String?,
        registerName: json['registerName'] as String?,
        userId: json['userId'] as String?,
        username: json['username'] as String?,
        rightName: json['rightName'] as String?,
      );

  @override
  Map<String, dynamic> toJson() => {
        'locationId': locationId,
        'override': overrideCode,
        'rightId': rightId,
        'managerOverrideBy': managerOverrideBy,
        'locationName': locationName,
        'registerId': registerId,
        'registerName': registerName,
        'userId': userId,
        'username': username,
        'rightName': rightName,
      };
}