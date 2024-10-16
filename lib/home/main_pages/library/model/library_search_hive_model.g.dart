// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_search_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookSearchHiveDataAdapter extends TypeAdapter<BookSearchHiveData> {
  @override
  final int typeId = 20;

  @override
  BookSearchHiveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookSearchHiveData(
      accessionnumber: fields[0] as String?,
      availability: fields[1] as String?,
      authorname: fields[2] as String?,
      publishername: fields[3] as String?,
      edition: fields[4] as String?,
      borrow: fields[5] as dynamic,
      title: fields[6] as String?,
      department: fields[7] as String?,
      booknumber: fields[8] as String?,
      classificationNumber: fields[9] as String?,
      inhand: fields[10] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, BookSearchHiveData obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.accessionnumber)
      ..writeByte(1)
      ..write(obj.availability)
      ..writeByte(2)
      ..write(obj.authorname)
      ..writeByte(3)
      ..write(obj.publishername)
      ..writeByte(4)
      ..write(obj.edition)
      ..writeByte(5)
      ..write(obj.borrow)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.department)
      ..writeByte(8)
      ..write(obj.booknumber)
      ..writeByte(9)
      ..write(obj.classificationNumber)
      ..writeByte(10)
      ..write(obj.inhand);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookSearchHiveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
