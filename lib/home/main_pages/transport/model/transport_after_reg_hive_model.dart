import 'package:hive/hive.dart';

part 'transport_after_reg_hive_model.g.dart';

@HiveType(typeId: 28)
class TransportAfterRegisterHiveData {
  TransportAfterRegisterHiveData({
    this.transportstatus,
    this.applicationfee,
    this.amount,
    this.controllerid,
    this.officeid,
    this.regconfig,
    this.boardingpointname,
    this.busroutename,
    this.registrationdate,
    this.academicyearid,
    this.status,
    this.activestatus,
  });

  TransportAfterRegisterHiveData.fromJson(Map<String, dynamic> json) {
    transportstatus = json['transportstatus'] as String?;
    applicationfee = json['applicationfee'] as String?;
    amount = json['amount'] as String?;
    controllerid = json['controllerid'] as String?;
    officeid = json['officeid'] as String?;
    regconfig = json['regconfig'] as String?;
    boardingpointname = json['boardingpointname'] as String?;
    busroutename = json['busroutename'] as String?;
    registrationdate = json['registrationdate'] as String?;
    academicyearid = json['academicyearid'] as String?;
    status = json['status'] as String?;
    activestatus = json['activestatus'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['transportstatus'] = transportstatus;
    data['applicationfee'] = applicationfee;
    data['amount'] = amount;
    data['controllerid'] = controllerid;
    data['officeid'] = officeid;
    data['regconfig'] = regconfig;
    data['boardingpointname'] = boardingpointname;
    data['busroutename'] = busroutename;
    data['registrationdate'] = registrationdate;
    data['academicyearid'] = academicyearid;
    data['status'] = status;
    data['activestatus'] = activestatus;
    return data;
  }

  static final empty = TransportAfterRegisterHiveData(
    controllerid: '',
    regconfig: '',
    registrationdate: '',
    academicyearid: '',
    status: '',
    activestatus: '',
    amount: '',
    applicationfee: '',
    boardingpointname: '',
    busroutename: '',
    officeid: '',
    transportstatus: '',
  );

  @HiveField(0)
  String? transportstatus;

  @HiveField(1)
  String? applicationfee;

  @HiveField(2)
  String? amount;

  @HiveField(3)
  String? controllerid;

  @HiveField(4)
  String? officeid;

  @HiveField(5)
  String? regconfig;

  @HiveField(6)
  String? boardingpointname;

  @HiveField(7)
  String? busroutename;

  @HiveField(8)
  String? registrationdate;

  @HiveField(9)
  String? academicyearid;

  @HiveField(10)
  String? status;

  @HiveField(11)
  String? activestatus;
}
