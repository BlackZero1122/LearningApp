// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/activity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityAdapter extends TypeAdapter<Activity> {
  @override
  final int typeId = 5;

  @override
  Activity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Activity(
      activityId: fields[0] as String?,
      id: fields[1] as String?,
      lessonId: fields[2] as String?,
      subjectId: fields[3] as String?,
      title: fields[4] as String?,
      topic: fields[5] as String?,
      activityTypeString: fields[6] as String?,
      activityType: fields[7] as num?,
      content: fields[8] as String?,
      grade: fields[9] as num?,
      subject: fields[10] as num?,
      semester: fields[11] as num?,
      session: fields[12] as num?,
      thumbnail: fields[13] as String?,
      sequence: fields[14] as num?,
      readCount: fields[15] as num?,
      completePercent: fields[16] as num?,
      assessment: fields[17] as Assessment?,
      rules: fields[18] as Rules?,
    );
  }

  @override
  void write(BinaryWriter writer, Activity obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.activityId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.lessonId)
      ..writeByte(3)
      ..write(obj.subjectId)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.topic)
      ..writeByte(6)
      ..write(obj.activityTypeString)
      ..writeByte(7)
      ..write(obj.activityType)
      ..writeByte(8)
      ..write(obj.content)
      ..writeByte(9)
      ..write(obj.grade)
      ..writeByte(10)
      ..write(obj.subject)
      ..writeByte(11)
      ..write(obj.semester)
      ..writeByte(12)
      ..write(obj.session)
      ..writeByte(13)
      ..write(obj.thumbnail)
      ..writeByte(14)
      ..write(obj.sequence)
      ..writeByte(15)
      ..write(obj.readCount)
      ..writeByte(16)
      ..write(obj.completePercent)
      ..writeByte(17)
      ..write(obj.assessment)
      ..writeByte(18)
      ..write(obj.rules);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
