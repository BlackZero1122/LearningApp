// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/question_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionListAdapter extends TypeAdapter<QuestionList> {
  @override
  final int typeId = 11;

  @override
  QuestionList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionList(
      id: fields[0] as String?,
      question: fields[1] as String?,
      image: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionList obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
