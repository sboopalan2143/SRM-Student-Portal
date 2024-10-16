// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_after_reg_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransportAfterRegisterHiveDataAdapter
    extends TypeAdapter<TransportAfterRegisterHiveData> {
  @override
  final int typeId = 28;

  @override
  TransportAfterRegisterHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransportAfterRegisterHiveData(
      transportstatus: fields[0] as String?,
      applicationfee: fields[1] as String?,
      amount: fields[2] as String?,
      controllerid: fields[3] as String?,
      officeid: fields[4] as String?,
      regconfig: fields[5] as String?,
      boardingpointname: fields[6] as String?,
      busroutename: fields[7] as String?,
      registrationdate: fields[8] as String?,
      academicyearid: fields[9] as String?,
      status: fields[10] as String?,
      activestatus: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TransportAfterRegisterHiveData obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.transportstatus)
      ..writeByte(1)
      ..write(obj.applicationfee)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.controllerid)
      ..writeByte(4)
      ..write(obj.officeid)
      ..writeByte(5)
      ..write(obj.regconfig)
      ..writeByte(6)
      ..write(obj.boardingpointname)
      ..writeByte(7)
      ..write(obj.busroutename)
      ..writeByte(8)
      ..write(obj.registrationdate)
      ..writeByte(9)
      ..write(obj.academicyearid)
      ..writeByte(10)
      ..write(obj.status)
      ..writeByte(11)
      ..write(obj.activestatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransportAfterRegisterHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
