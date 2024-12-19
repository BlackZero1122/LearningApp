// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/subject_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectListAdapter extends TypeAdapter<SubjectList> {
  @override
  final int typeId = 17;

  @override
  SubjectList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectList(
      id: fields[0] as String?,
      name: fields[1] as String?,
      code: fields[2] as String?,
      completePercent: fields[3] as num?,
      thumbnail: fields[4] as String?,
      courseId: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectList obj) {
    writer
      ..writeByte(6)
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
      ..write(obj.courseId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
