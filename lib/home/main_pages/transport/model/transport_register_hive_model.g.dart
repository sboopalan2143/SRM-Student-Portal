// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_register_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransportRegisterHiveDataAdapter
    extends TypeAdapter<TransportRegisterHiveData> {
  @override
  final int typeId = 29;

  @override
  TransportRegisterHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransportRegisterHiveData(
      transportstatus: fields[0] as String?,
      applicationfee: fields[1] as String?,
      controllerid: fields[2] as String?,
      officeid: fields[3] as String?,
      regconfig: fields[4] as String?,
      academicyearid: fields[5] as String?,
      status: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TransportRegisterHiveData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.transportstatus)
      ..writeByte(1)
      ..write(obj.applicationfee)
      ..writeByte(2)
      ..write(obj.controllerid)
      ..writeByte(3)
      ..write(obj.officeid)
      ..writeByte(4)
      ..write(obj.regconfig)
      ..writeByte(5)
      ..write(obj.academicyearid)
      ..writeByte(6)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransportRegisterHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
