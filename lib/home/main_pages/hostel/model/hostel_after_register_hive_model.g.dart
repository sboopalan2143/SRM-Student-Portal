// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hostel_after_register_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HostelAfterRegisterHiveDataAdapter
    extends TypeAdapter<HostelAfterRegisterHiveData> {
  @override
  final int typeId = 13;

  @override
  HostelAfterRegisterHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HostelAfterRegisterHiveData(
      messfeeamount: fields[0] as String?,
      applnfeeamount: fields[1] as String?,
      controllerid: fields[2] as String?,
      hostel: fields[3] as String?,
      hostelfeeamount: fields[4] as String?,
      regconfig: fields[5] as String?,
      registrationdate: fields[6] as String?,
      academicyearid: fields[7] as String?,
      cautiondepositamt: fields[8] as String?,
      status: fields[9] as String?,
      activestatus: fields[10] as String?,
      roomtype: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HostelAfterRegisterHiveData obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.messfeeamount)
      ..writeByte(1)
      ..write(obj.applnfeeamount)
      ..writeByte(2)
      ..write(obj.controllerid)
      ..writeByte(3)
      ..write(obj.hostel)
      ..writeByte(4)
      ..write(obj.hostelfeeamount)
      ..writeByte(5)
      ..write(obj.regconfig)
      ..writeByte(6)
      ..write(obj.registrationdate)
      ..writeByte(7)
      ..write(obj.academicyearid)
      ..writeByte(8)
      ..write(obj.cautiondepositamt)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.activestatus)
      ..writeByte(11)
      ..write(obj.roomtype);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HostelAfterRegisterHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
