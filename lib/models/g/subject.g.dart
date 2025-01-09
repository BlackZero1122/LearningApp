// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/subject.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectAdapter extends TypeAdapter<Subject> {
  @override
  final int typeId = 19;

  @override
  Subject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Subject(
      id: fields[0] as String?,
      name: fields[1] as String?,
      code: fields[2] as String?,
      completePercent: fields[3] as num?,
      thumbnail: fields[4] as String?,
      title: fields[5] as String?,
      subject: fields[6] as String?,
      lessons: (fields[7] as List?)?.cast<Lesson>(),
      courseId: fields[8] as String?,
      courseName: fields[9] as String?,
      description: fields[10] as String?,
      tts_description: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Subject obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.completePercent)
      ..writeByte(4)
      ..write(obj.thumbnail)
      ..writeByte(5)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.subject)
      ..writeByte(7)
      ..write(obj.lessons)
      ..writeByte(8)
      ..write(obj.courseId)
      ..writeByte(9)
      ..write(obj.courseName)
      ..writeByte(10)
      ..write(obj.description)
      ..writeByte(11)
      ..write(obj.tts_description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
