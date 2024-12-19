// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/assessment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssessmentAdapter extends TypeAdapter<Assessment> {
  @override
  final int typeId = 7;

  @override
  Assessment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Assessment(
      noOfQuizToAsk: fields[0] as num?,
      correctNoOfQuizToPass: fields[1] as num?,
      isRequired: fields[2] as bool?,
      maxTryAttempts: fields[3] as num?,
      quizzes: (fields[4] as List?)?.cast<Quiz>(),
    );
  }

  @override
  void write(BinaryWriter writer, Assessment obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.noOfQuizToAsk)
      ..writeByte(1)
      ..write(obj.correctNoOfQuizToPass)
      ..writeByte(2)
      ..write(obj.isRequired)
      ..writeByte(3)
      ..write(obj.maxTryAttempts)
      ..writeByte(4)
      ..write(obj.quizzes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssessmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
