// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_response_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FinanceHiveDataAdapter extends TypeAdapter<FinanceHiveData> {
  @override
  final int typeId = 7;

  @override
  FinanceHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FinanceHiveData(
      amountcollected: fields[0] as String?,
      modeoftransaction: fields[1] as String?,
      receiptnum: fields[2] as String?,
      duedate: fields[3] as String?,
      duename: fields[4] as String?,
      dueamount: fields[5] as String?,
      term: fields[6] as String?,
      receiptdate: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FinanceHiveData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.amountcollected)
      ..writeByte(1)
      ..write(obj.modeoftransaction)
      ..writeByte(2)
      ..write(obj.receiptnum)
      ..writeByte(3)
      ..write(obj.duedate)
      ..writeByte(4)
      ..write(obj.duename)
      ..writeByte(5)
      ..write(obj.dueamount)
      ..writeByte(6)
      ..write(obj.term)
      ..writeByte(7)
      ..write(obj.receiptdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FinanceHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
