// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grievance_type_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GrievanceTypeHiveDataAdapter extends TypeAdapter<GrievanceTypeHiveData> {
  @override
  final int typeId = 11;

  @override
  GrievanceTypeHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GrievanceTypeHiveData(
      grievancetype: fields[0] as String?,
      grievancetypeid: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GrievanceTypeHiveData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.grievancetype)
      ..writeByte(1)
      ..write(obj.grievancetypeid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GrievanceTypeHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
