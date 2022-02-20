// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlarmDataModelAdapter extends TypeAdapter<AlarmDataModel> {
  @override
  final int typeId = 0;

  @override
  AlarmDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlarmDataModel(
      id: fields[0] as int,
      time: fields[1] as DateTime,
      weekdays: (fields[2] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, AlarmDataModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.weekdays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
