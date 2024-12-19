// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/lesson_req.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LessonRequestAdapter extends TypeAdapter<LessonRequest> {
  @override
  final int typeId = 8;

  @override
  LessonRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LessonRequest(
      gradeId: fields[0] as num,
      subjectId: fields[1] as num,
      semester: fields[2] as num,
      sessionId: fields[3] as num,
      studentId: fields[4] as num,
      schoolId: fields[5] as num,
    );
  }

  @override
  void write(BinaryWriter writer, LessonRequest obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.gradeId)
      ..writeByte(1)
      ..write(obj.subjectId)
      ..writeByte(2)
      ..write(obj.semester)
      ..writeByte(3)
      ..write(obj.sessionId)
      ..writeByte(4)
      ..write(obj.studentId)
      ..writeByte(5)
      ..write(obj.schoolId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
