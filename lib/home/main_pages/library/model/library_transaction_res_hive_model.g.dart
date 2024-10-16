// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_transaction_res_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LibraryTransactionHiveDataAdapter
    extends TypeAdapter<LibraryTransactionHiveData> {
  @override
  final int typeId = 21;

  @override
  LibraryTransactionHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LibraryTransactionHiveData(
      membercode: fields[0] as String?,
      membertype: fields[1] as String?,
      policyname: fields[2] as String?,
      membername: fields[3] as String?,
      status: fields[4] as String?,
      accessionno: fields[5] as String?,
      returndate: fields[6] as String?,
      duedate: fields[7] as String?,
      fineamount: fields[8] as String?,
      title: fields[9] as String?,
      issuedate: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LibraryTransactionHiveData obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.membercode)
      ..writeByte(1)
      ..write(obj.membertype)
      ..writeByte(2)
      ..write(obj.policyname)
      ..writeByte(3)
      ..write(obj.membername)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.accessionno)
      ..writeByte(6)
      ..write(obj.returndate)
      ..writeByte(7)
      ..write(obj.duedate)
      ..writeByte(8)
      ..write(obj.fineamount)
      ..writeByte(9)
      ..write(obj.title)
      ..writeByte(10)
      ..write(obj.issuedate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LibraryTransactionHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
