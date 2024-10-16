// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_status_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransportStatusHiveDataAdapter
    extends TypeAdapter<TransportStatusHiveData> {
  @override
  final int typeId = 30;

  @override
  TransportStatusHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransportStatusHiveData(
      transportstatus: fields[0] as String?,
      applicationfee: fields[1] as String?,
      officeid: fields[2] as String?,
      regconfig: fields[3] as String?,
      academicyearid: fields[4] as String?,
      status: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TransportStatusHiveData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.transportstatus)
      ..writeByte(1)
      ..write(obj.applicationfee)
      ..writeByte(2)
      ..write(obj.officeid)
      ..writeByte(3)
      ..write(obj.regconfig)
      ..writeByte(4)
      ..write(obj.academicyearid)
      ..writeByte(5)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransportStatusHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
