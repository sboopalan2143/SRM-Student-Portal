import 'package:hive/hive.dart';

part 'room_type_hive_model.g.dart';

@HiveType(typeId: 18)
class RoomTypeHiveData {
  RoomTypeHiveData({
    this.applicationfee,
    this.messfees,
    this.roomtypeid,
    this.cautiondepositfee,
    this.hostelstatus,
    this.roomtypename,
  });

  RoomTypeHiveData.fromJson(Map<String, dynamic> json) {
    applicationfee = json['applicationfee'] as String?;
    messfees = json['messfees'] as String?;
    roomtypeid = json['roomtypeid'] as String?;
    cautiondepositfee = json['cautiondepositfee'] as String?;
    hostelstatus = json['hostelstatus'] as String?;
    roomtypename = json['roomtypename'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['applicationfee'] = applicationfee;
    data['messfees'] = messfees;
    data['roomtypeid'] = roomtypeid;
    data['cautiondepositfee'] = cautiondepositfee;
    data['hostelstatus'] = hostelstatus;
    data['roomtypename'] = roomtypename;
    return data;
  }

  static final empty = RoomTypeHiveData(
    applicationfee: '',
    messfees: '',
    roomtypeid: '',
    cautiondepositfee: '',
    hostelstatus: '',
    roomtypename: 'Select RoomType',
  );

  @HiveField(0)
  String? applicationfee;

  @HiveField(1)
  String? messfees;

  @HiveField(2)
  String? roomtypeid;

  @HiveField(3)
  String? cautiondepositfee;

  @HiveField(4)
  String? hostelstatus;

  @HiveField(5)
  String? roomtypename;
}
