// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResultAdapter extends TypeAdapter<Result> {
  @override
  final int typeId = 13;

  @override
  Result read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Result(
      force: fields[6] as bool?,
      score: fields[0] as Score?,
      completion: fields[1] as bool?,
      success: fields[2] as bool?,
      duration: fields[3] as String?,
      response: fields[4] as String?,
      student_answers: (fields[5] as List?)?.cast<StudentAnswer>(),
    );
  }

  @override
  void write(BinaryWriter writer, Result obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.score)
      ..writeByte(1)
      ..write(obj.completion)
      ..writeByte(2)
      ..write(obj.success)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.response)
      ..writeByte(5)
      ..write(obj.student_answers)
      ..writeByte(6)
      ..write(obj.force);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
