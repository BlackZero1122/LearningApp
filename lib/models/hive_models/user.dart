import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';

part '../g/user.g.dart';

@HiveType(typeId: 3)
class User extends IHiveBaseModel<User> {
  @HiveField(0)
  bool? isFingerPrint;
  @HiveField(1)
  bool? isFingerPrintBi;
  @HiveField(2)
  bool? isUserCard;
  @HiveField(3)
  bool? isQrCode;
  @HiveField(4)
  bool? isUserPin;
  @HiveField(5)
  String? photo;
  @HiveField(6)
  String? userId;
  @HiveField(7)
  String? displayName;
  @HiveField(8)
  String? firstName;
  @HiveField(9)
  String? lastName;
  @HiveField(10)
  String? email;
  @HiveField(11)
  String? username;
  @HiveField(12)
  String? password;
  @HiveField(13)
  String? companyName;
  @HiveField(14)
  String? method;
  @HiveField(15)
  String? plan;
  @HiveField(16)
  List<String>? role;
  @HiveField(17)
  String? street;
  @HiveField(18)
  String? city;
  @HiveField(19)
  String? state;
  @HiveField(20)
  String? country;
  @HiveField(21)
  String? postalCode;
  @HiveField(22)
  String? phone;
  @HiveField(23)
  List<String>? businessPhone;
  @HiveField(24)
  String? officeLocation;
  @HiveField(25)
  String? parentId;
  @HiveField(26)
  List<String>? userLocations;
  @HiveField(28)
  List<String>? userRights;
  @HiveField(29)
  String? type;
  @HiveField(30)
  num? age;
  @HiveField(31)
  String? gender;
  @HiveField(32)
  bool? isBusinessSetup;

  dynamic keyId;
  String roles;

  User({ this.roles="N/A",
    this.isFingerPrint,
    this.isFingerPrintBi,
    this.isUserCard,
    this.isQrCode,
    this.isUserPin,
    this.photo,
    this.userId,
    this.displayName,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.password,
    this.companyName,
    this.method,
    this.plan,
    this.role,
    this.street,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.phone,
    this.businessPhone,
    this.officeLocation,
    this.parentId,
    this.userLocations,
    this.userRights,
    this.type,
    this.age,
    this.gender,
    this.isBusinessSetup,
  });

  @override
  User fromJson(Map<String, dynamic> json) => User.fromJson(json);

  factory User.fromJson(Map<String, dynamic> json) => User(
        isFingerPrint: json["isFingerPrint"],
        isFingerPrintBi: json["isFingerPrintBI"],
        isUserCard: json["isUserCard"],
        isQrCode: json["isQRCode"],
        isUserPin: json["isUserPin"],
        photo: json["photo"],
        userId: json["userID"],
        displayName: json["displayName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        companyName: json["companyName"],
        method: json["method"],
        plan: json["plan"],
        role: List<String>.from(json["role"].map((x) => x)),
        street: json["street"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postalCode"],
        phone: json["phone"],
        businessPhone: List<String>.from(json["businessPhone"].map((x) => x)),
        officeLocation: json["officeLocation"],
        parentId: json["parentID"],
        userLocations: List<String>.from(json["userLocations"].map((x) => x)),
        userRights: List<String>.from(json["userRights"].map((x) => x)),
        type: json["type"],
        age: json["age"],
        gender: json["gender"],
        isBusinessSetup: json["isBusinessSetup"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "isFingerPrint": isFingerPrint,
        "isFingerPrintBI": isFingerPrintBi,
        "isUserCard": isUserCard,
        "isQRCode": isQrCode,
        "isUserPin": isUserPin,
        "photo": photo,
        "userID": userId,
        "displayName": displayName,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "username": username,
        "password": password,
        "companyName": companyName,
        "method": method,
        "plan": plan,
        "role": List<dynamic>.from(role!.map((x) => x)),
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "postalCode": postalCode,
        "phone": phone,
        "businessPhone": List<dynamic>.from(businessPhone!.map((x) => x)),
        "officeLocation": officeLocation,
        "parentID": parentId,
        "userLocations": List<dynamic>.from(userLocations!.map((x) => x)),
        "userRights": List<dynamic>.from(userRights!.map((x) => x)),
        "type": type,
        "age": age,
        "gender": gender,
        "isBusinessSetup": isBusinessSetup,
      };
}
