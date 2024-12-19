// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/answer_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnswerListAdapter extends TypeAdapter<AnswerList> {
  @override
  final int typeId = 6;

  @override
  AnswerList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnswerList(
      id: fields[0] as String?,
      answer: fields[1] as String?,
      image: fields[2] as String?,
      isCorrect: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, AnswerList obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.answer)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.isCorrect);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswerListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
