// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hostel_details_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetHostelHiveDataAdapter extends TypeAdapter<GetHostelHiveData> {
  @override
  final int typeId = 15;

  @override
  GetHostelHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetHostelHiveData(
      hostelname: fields[0] as String?,
      roomname: fields[1] as String?,
      academicyear: fields[2] as String?,
      alloteddate: fields[3] as String?,
      roomtype: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GetHostelHiveData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.hostelname)
      ..writeByte(1)
      ..write(obj.roomname)
      ..writeByte(2)
      ..write(obj.academicyear)
      ..writeByte(3)
      ..write(obj.alloteddate)
      ..writeByte(4)
      ..write(obj.roomtype);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetHostelHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
