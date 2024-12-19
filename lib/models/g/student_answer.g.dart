// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/student_answer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentAnswerAdapter extends TypeAdapter<StudentAnswer> {
  @override
  final int typeId = 16;

  @override
  StudentAnswer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentAnswer(
      question_id: fields[0] as String?,
      answer: fields[1] as String?,
      question: fields[2] as String?,
      correct_answer: fields[3] as String?,
      is_correct: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, StudentAnswer obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.question_id)
      ..writeByte(1)
      ..write(obj.answer)
      ..writeByte(2)
      ..write(obj.question)
      ..writeByte(3)
      ..write(obj.correct_answer)
      ..writeByte(4)
      ..write(obj.is_correct);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAnswerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
