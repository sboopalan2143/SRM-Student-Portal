import 'package:hive/hive.dart';

part 'transport_status_hive_model.g.dart';

@HiveType(typeId: 30)
class TransportStatusHiveData {
  TransportStatusHiveData({
    this.transportstatus,
    this.applicationfee,
    this.officeid,
    this.regconfig,
    this.academicyearid,
    this.status,
  });

  TransportStatusHiveData.fromJson(Map<String, dynamic> json) {
    transportstatus = json['transportstatus'] as String?;
    applicationfee = json['applicationfee'] as String?;
    officeid = json['officeid'] as String?;
    regconfig = json['regconfig'] as String?;
    academicyearid = json['academicyearid'] as String?;
    status = json['status'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['transportstatus'] = transportstatus;
    data['applicationfee'] = applicationfee;
    data['officeid'] = officeid;
    data['regconfig'] = regconfig;
    data['academicyearid'] = academicyearid;
    data['status'] = status;
    return data;
  }

  @HiveField(0)
  String? transportstatus;

  @HiveField(1)
  String? applicationfee;

  @HiveField(2)
  String? officeid;

  @HiveField(3)
  String? regconfig;

  @HiveField(4)
  String? academicyearid;

  @HiveField(5)
  String? status;
}
