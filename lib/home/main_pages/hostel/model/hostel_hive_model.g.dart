// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hostel_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HostelHiveDataAdapter extends TypeAdapter<HostelHiveData> {
  @override
  final int typeId = 16;

  @override
  HostelHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HostelHiveData(
      hostelname: fields[0] as String?,
      hostelid: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HostelHiveData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.hostelname)
      ..writeByte(1)
      ..write(obj.hostelid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HostelHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
