// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grievance_category_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GrievanceCategoryHiveDataAdapter
    extends TypeAdapter<GrievanceCategoryHiveData> {
  @override
  final int typeId = 9;

  @override
  GrievanceCategoryHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GrievanceCategoryHiveData(
      grievancekcategory: fields[0] as String?,
      grievancekcategoryid: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GrievanceCategoryHiveData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.grievancekcategory)
      ..writeByte(1)
      ..write(obj.grievancekcategoryid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GrievanceCategoryHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
