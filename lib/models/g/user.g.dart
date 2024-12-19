// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 3;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      isFingerPrint: fields[0] as bool?,
      isFingerPrintBi: fields[1] as bool?,
      isUserCard: fields[2] as bool?,
      isQrCode: fields[3] as bool?,
      isUserPin: fields[4] as bool?,
      photo: fields[5] as String?,
      userId: fields[6] as String?,
      displayName: fields[7] as String?,
      firstName: fields[8] as String?,
      lastName: fields[9] as String?,
      email: fields[10] as String?,
      username: fields[11] as String?,
      password: fields[12] as String?,
      companyName: fields[13] as String?,
      method: fields[14] as String?,
      plan: fields[15] as String?,
      role: (fields[16] as List?)?.cast<String>(),
      street: fields[17] as String?,
      city: fields[18] as String?,
      state: fields[19] as String?,
      country: fields[20] as String?,
      postalCode: fields[21] as String?,
      phone: fields[22] as String?,
      businessPhone: (fields[23] as List?)?.cast<String>(),
      officeLocation: fields[24] as String?,
      parentId: fields[25] as String?,
      userLocations: (fields[26] as List?)?.cast<String>(),
      userRights: (fields[28] as List?)?.cast<String>(),
      type: fields[29] as String?,
      age: fields[30] as num?,
      gender: fields[31] as String?,
      isBusinessSetup: fields[32] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(32)
      ..writeByte(0)
      ..write(obj.isFingerPrint)
      ..writeByte(1)
      ..write(obj.isFingerPrintBi)
      ..writeByte(2)
      ..write(obj.isUserCard)
      ..writeByte(3)
      ..write(obj.isQrCode)
      ..writeByte(4)
      ..write(obj.isUserPin)
      ..writeByte(5)
      ..write(obj.photo)
      ..writeByte(6)
      ..write(obj.userId)
      ..writeByte(7)
      ..write(obj.displayName)
      ..writeByte(8)
      ..write(obj.firstName)
      ..writeByte(9)
      ..write(obj.lastName)
      ..writeByte(10)
      ..write(obj.email)
      ..writeByte(11)
      ..write(obj.username)
      ..writeByte(12)
      ..write(obj.password)
      ..writeByte(13)
      ..write(obj.companyName)
      ..writeByte(14)
      ..write(obj.method)
      ..writeByte(15)
      ..write(obj.plan)
      ..writeByte(16)
      ..write(obj.role)
      ..writeByte(17)
      ..write(obj.street)
      ..writeByte(18)
      ..write(obj.city)
      ..writeByte(19)
      ..write(obj.state)
      ..writeByte(20)
      ..write(obj.country)
      ..writeByte(21)
      ..write(obj.postalCode)
      ..writeByte(22)
      ..write(obj.phone)
      ..writeByte(23)
      ..write(obj.businessPhone)
      ..writeByte(24)
      ..write(obj.officeLocation)
      ..writeByte(25)
      ..write(obj.parentId)
      ..writeByte(26)
      ..write(obj.userLocations)
      ..writeByte(28)
      ..write(obj.userRights)
      ..writeByte(29)
      ..write(obj.type)
      ..writeByte(30)
      ..write(obj.age)
      ..writeByte(31)
      ..write(obj.gender)
      ..writeByte(32)
      ..write(obj.isBusinessSetup);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
