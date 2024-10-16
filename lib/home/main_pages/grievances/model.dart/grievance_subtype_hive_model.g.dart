// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grievance_subtype_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GrievanceSubTypeHiveDataAdapter
    extends TypeAdapter<GrievanceSubTypeHiveData> {
  @override
  final int typeId = 10;

  @override
  GrievanceSubTypeHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GrievanceSubTypeHiveData(
      grievancesubcategorydesc: fields[0] as String?,
      grievancesubcategoryid: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GrievanceSubTypeHiveData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.grievancesubcategorydesc)
      ..writeByte(1)
      ..write(obj.grievancesubcategoryid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GrievanceSubTypeHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
