// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/rules.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RulesAdapter extends TypeAdapter<Rules> {
  @override
  final int typeId = 14;

  @override
  Rules read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Rules(
      seekDurationInSeconds: fields[5] as num,
      allowForwardSeek: fields[4] as bool,
      percentToComplete: fields[2] as num,
      allowBackwardSeek: fields[3] as bool,
      maxReadCount: fields[0] as num,
      trackActivityProgress: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Rules obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.maxReadCount)
      ..writeByte(1)
      ..write(obj.trackActivityProgress)
      ..writeByte(2)
      ..write(obj.percentToComplete)
      ..writeByte(3)
      ..write(obj.allowBackwardSeek)
      ..writeByte(4)
      ..write(obj.allowForwardSeek)
      ..writeByte(5)
      ..write(obj.seekDurationInSeconds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RulesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
