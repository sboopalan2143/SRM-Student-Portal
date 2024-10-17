// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internal_mark_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InternalMarkHiveDataAdapter extends TypeAdapter<InternalMarkHiveData> {
  @override
  final int typeId = 6;

  @override
  InternalMarkHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InternalMarkHiveData(
      sumofmarks: fields[0] as String?,
      subjectcode: fields[1] as String?,
      sumofmaxmarks: fields[2] as String?,
      subjectdesc: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InternalMarkHiveData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.sumofmarks)
      ..writeByte(1)
      ..write(obj.subjectcode)
      ..writeByte(2)
      ..write(obj.sumofmaxmarks)
      ..writeByte(3)
      ..write(obj.subjectdesc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InternalMarkHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
