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
      photo: fields[0] as String?,
      userId: fields[1] as String?,
      displayName: fields[2] as String?,
      firstName: fields[3] as String?,
      lastName: fields[4] as String?,
      email: fields[5] as String?,
      username: fields[6] as String?,
      password: fields[7] as String?,
      street: fields[8] as String?,
      city: fields[9] as String?,
      state: fields[10] as String?,
      country: fields[11] as String?,
      postalCode: fields[12] as String?,
      phone: fields[13] as String?,
      age: fields[14] as num?,
      gender: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.photo)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.displayName)
      ..writeByte(3)
      ..write(obj.firstName)
      ..writeByte(4)
      ..write(obj.lastName)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.username)
      ..writeByte(7)
      ..write(obj.password)
      ..writeByte(8)
      ..write(obj.street)
      ..writeByte(9)
      ..write(obj.city)
      ..writeByte(10)
      ..write(obj.state)
      ..writeByte(11)
      ..write(obj.country)
      ..writeByte(12)
      ..write(obj.postalCode)
      ..writeByte(13)
      ..write(obj.phone)
      ..writeByte(14)
      ..write(obj.age)
      ..writeByte(15)
      ..write(obj.gender);
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
