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
      description: fields[4] as String?,
      tts_description: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AnswerList obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.answer)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.isCorrect)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.tts_description);
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
