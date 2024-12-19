// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/task_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskConfigAdapter extends TypeAdapter<TaskConfig> {
  @override
  final int typeId = 1;

  @override
  TaskConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskConfig(
      fields[0] as String,
      fields[1] as bool,
      fields[2] as num,
    );
  }

  @override
  void write(BinaryWriter writer, TaskConfig obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.enable)
      ..writeByte(2)
      ..write(obj.limit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
