// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/quiz.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizAdapter extends TypeAdapter<Quiz> {
  @override
  final int typeId = 12;

  @override
  Quiz read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Quiz(
      quizType: fields[0] as String?,
      id: fields[1] as String?,
      image: fields[2] as String?,
      question: fields[3] as String?,
      answerList: (fields[4] as List?)?.cast<AnswerList>(),
      questionList: (fields[5] as List?)?.cast<QuestionList>(),
      answer: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Quiz obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.quizType)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.question)
      ..writeByte(4)
      ..write(obj.answerList)
      ..writeByte(5)
      ..write(obj.questionList)
      ..writeByte(6)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
