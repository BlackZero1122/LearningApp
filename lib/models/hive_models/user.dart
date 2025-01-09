import 'package:hive/hive.dart';
import 'package:learning_app/models/base_model.dart';

part '../g/user.g.dart';

@HiveType(typeId: 3)
class User extends IHiveBaseModel<User> {
  @HiveField(0)
  String? photo;
  @HiveField(1)
  String? userId;
  @HiveField(2)
  String? displayName;
  @HiveField(3)
  String? firstName;
  @HiveField(4)
  String? lastName;
  @HiveField(5)
  String? email;
  @HiveField(6)
  String? username;
  @HiveField(7)
  String? password;
  @HiveField(8)
  String? street;
  @HiveField(9)
  String? city;
  @HiveField(10)
  String? state;
  @HiveField(11)
  String? country;
  @HiveField(12)
  String? postalCode;
  @HiveField(13)
  String? phone;
  @HiveField(14)
  num? age;
  @HiveField(15)
  String? gender;

  dynamic keyId;

  User({
    this.photo,
    this.userId,
    this.displayName,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.password,
    this.street,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.phone,
    this.age,
    this.gender,
  });

  @override
  User fromJson(Map<String, dynamic> json) => User.fromJson(json);

  factory User.fromJson(Map<String, dynamic> json) => User(
        photo: json["photo"],
        userId: json["userID"],
        displayName: json["displayName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        street: json["street"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postalCode"],
        phone: json["phone"],
        age: json["age"],
        gender: json["gender"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "photo": photo,
        "userID": userId,
        "displayName": displayName,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "username": username,
        "password": password,
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "postalCode": postalCode,
        "phone": phone,
        "age": age,
        "gender": gender,
      };
}
