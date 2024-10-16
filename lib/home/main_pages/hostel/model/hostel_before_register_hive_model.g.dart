// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hostel_before_register_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HostelBeforeRegisterHiveDataAdapter
    extends TypeAdapter<HostelBeforeRegisterHiveData> {
  @override
  final int typeId = 14;

  @override
  HostelBeforeRegisterHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HostelBeforeRegisterHiveData(
      applnfeeamount: fields[0] as String?,
      controllerid: fields[1] as String?,
      regconfig: fields[2] as String?,
      academicyearid: fields[3] as String?,
      cautiondepositamt: fields[4] as String?,
      status: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HostelBeforeRegisterHiveData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.applnfeeamount)
      ..writeByte(1)
      ..write(obj.controllerid)
      ..writeByte(2)
      ..write(obj.regconfig)
      ..writeByte(3)
      ..write(obj.academicyearid)
      ..writeByte(4)
      ..write(obj.cautiondepositamt)
      ..writeByte(5)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HostelBeforeRegisterHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
