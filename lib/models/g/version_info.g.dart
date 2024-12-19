// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_models/version_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VersionInfoAdapter extends TypeAdapter<VersionInfo> {
  @override
  final int typeId = 4;

  @override
  VersionInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VersionInfo(
      id: fields[0] as String?,
      dataItem: fields[1] as num?,
      version: fields[2] as num?,
      lastUpdated: fields[3] as DateTime?,
      synced: fields[4] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, VersionInfo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dataItem)
      ..writeByte(2)
      ..write(obj.version)
      ..writeByte(3)
      ..write(obj.lastUpdated)
      ..writeByte(4)
      ..write(obj.synced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VersionInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
