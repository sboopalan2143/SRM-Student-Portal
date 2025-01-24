import 'package:hive/hive.dart';

part 'transport_register_hive_model.g.dart';

@HiveType(typeId: 29)
class TransportRegisterHiveData {
  TransportRegisterHiveData({
    this.transportstatus,
    this.applicationfee,
    this.controllerid,
    this.officeid,
    this.regconfig,
    this.academicyearid,
    this.status,
  });

  TransportRegisterHiveData.fromJson(Map<String, dynamic> json) {
    transportstatus = json['transportstatus'] as String?;
    applicationfee = json['applicationfee'] as String?;
    controllerid = json['controllerid'] as String?;
    officeid = json['officeid'] as String?;
    regconfig = json['regconfig'] as String?;
    academicyearid = json['academicyearid'] as String?;
    status = json['status'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['transportstatus'] = transportstatus;
    data['applicationfee'] = applicationfee;
    data['controllerid'] = controllerid;
    data['officeid'] = officeid;
    data['regconfig'] = regconfig;
    data['academicyearid'] = academicyearid;
    data['status'] = status;
    return data;
  }

  static final empty = TransportRegisterHiveData(
    controllerid: '',
    regconfig: '',
    academicyearid: '',
    applicationfee: '',
    officeid: '',
    transportstatus: '',
    status: '',
  );

  @HiveField(0)
  String? transportstatus;

  @HiveField(1)
  String? applicationfee;

  @HiveField(2)
  String? controllerid;

  @HiveField(3)
  String? officeid;

  @HiveField(4)
  String? regconfig;

  @HiveField(5)
  String? academicyearid;

  @HiveField(6)
  String? status;
}
