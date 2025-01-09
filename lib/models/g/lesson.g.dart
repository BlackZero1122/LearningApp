// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/lesson.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LessonAdapter extends TypeAdapter<Lesson> {
  @override
  final int typeId = 9;

  @override
  Lesson read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lesson(
      title: fields[0] as String?,
      subjectId: fields[1] as String?,
      id: fields[2] as String?,
      topicId: fields[3] as String?,
      sequence: fields[4] as num?,
      enable: fields[5] as bool?,
      completePercent: fields[6] as num?,
      thumbnail: fields[7] as String?,
      lessonEnable: fields[8] as String?,
      activities: (fields[9] as List?)?.cast<Activity>(),
      totalActivities: fields[10] as num?,
      description: fields[11] as String?,
      tts_description: fields[12] as String?,
      skill: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Lesson obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subjectId)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.topicId)
      ..writeByte(4)
      ..write(obj.sequence)
      ..writeByte(5)
      ..write(obj.enable)
      ..writeByte(6)
      ..write(obj.completePercent)
      ..writeByte(7)
      ..write(obj.thumbnail)
      ..writeByte(8)
      ..write(obj.lessonEnable)
      ..writeByte(9)
      ..write(obj.activities)
      ..writeByte(10)
      ..write(obj.totalActivities)
      ..writeByte(11)
      ..write(obj.description)
      ..writeByte(12)
      ..write(obj.tts_description)
      ..writeByte(13)
      ..write(obj.skill);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
