// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProgressAdapter extends TypeAdapter<Progress> {
  @override
  final int typeId = 10;

  @override
  Progress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Progress(
      activityId: fields[0] as num?,
      activityTypeString: fields[1] as String?,
      studentId: fields[2] as num?,
      readDate: fields[3] as DateTime?,
      readCount: fields[4] as num?,
      lessonCompleted: fields[5] as bool?,
      result: fields[6] as Result?,
      topic: fields[7] as String?,
      topicId: fields[8] as num?,
      day: fields[9] as num?,
      totalActivities: fields[10] as num?,
      activityName: fields[11] as String?,
      url: fields[12] as String?,
      id: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Progress obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.activityId)
      ..writeByte(1)
      ..write(obj.activityTypeString)
      ..writeByte(2)
      ..write(obj.studentId)
      ..writeByte(3)
      ..write(obj.readDate)
      ..writeByte(4)
      ..write(obj.readCount)
      ..writeByte(5)
      ..write(obj.lessonCompleted)
      ..writeByte(6)
      ..write(obj.result)
      ..writeByte(7)
      ..write(obj.topic)
      ..writeByte(8)
      ..write(obj.topicId)
      ..writeByte(9)
      ..write(obj.day)
      ..writeByte(10)
      ..write(obj.totalActivities)
      ..writeByte(11)
      ..write(obj.activityName)
      ..writeByte(12)
      ..write(obj.url)
      ..writeByte(13)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
