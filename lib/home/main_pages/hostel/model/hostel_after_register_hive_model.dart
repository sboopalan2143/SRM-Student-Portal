import 'package:hive/hive.dart';

part 'hostel_after_register_hive_model.g.dart';

@HiveType(typeId: 13)
class HostelAfterRegisterHiveData {
  HostelAfterRegisterHiveData({
    this.messfeeamount,
    this.applnfeeamount,
    this.controllerid,
    this.hostel,
    this.hostelfeeamount,
    this.regconfig,
    this.registrationdate,
    this.academicyearid,
    this.cautiondepositamt,
    this.status,
    this.activestatus,
    this.roomtype,
  });

  HostelAfterRegisterHiveData.fromJson(Map<String, dynamic> json) {
    messfeeamount = json['messfeeamount'] as String?;
    applnfeeamount = json['applnfeeamount'] as String?;
    controllerid = json['controllerid'] as String?;
    hostel = json['hostel'] as String?;
    hostelfeeamount = json['hostelfeeamount'] as String?;
    regconfig = json['regconfig'] as String?;
    registrationdate = json['registrationdate'] as String?;
    academicyearid = json['academicyearid'] as String?;
    cautiondepositamt = json['cautiondepositamt'] as String?;
    status = json['status'] as String?;
    activestatus = json['activestatus'] as String?;
    roomtype = json['roomtype'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['messfeeamount'] = messfeeamount;
    data['applnfeeamount'] = applnfeeamount;
    data['controllerid'] = controllerid;
    data['hostel'] = hostel;
    data['hostelfeeamount'] = hostelfeeamount;
    data['regconfig'] = regconfig;
    data['registrationdate'] = registrationdate;
    data['academicyearid'] = academicyearid;
    data['cautiondepositamt'] = cautiondepositamt;
    data['status'] = status;
    data['activestatus'] = activestatus;
    data['roomtype'] = roomtype;
    return data;
  }

  static final empty = HostelAfterRegisterHiveData(
    messfeeamount: '',
    applnfeeamount: '',
    controllerid: '',
    hostel: '',
    hostelfeeamount: '',
    regconfig: '',
    registrationdate: '',
    academicyearid: '',
    cautiondepositamt: '',
    status: '',
    activestatus: '',
    roomtype: '',
  );

  @HiveField(0)
  String? messfeeamount;

  @HiveField(1)
  String? applnfeeamount;

  @HiveField(2)
  String? controllerid;

  @HiveField(3)
  String? hostel;

  @HiveField(4)
  String? hostelfeeamount;

  @HiveField(5)
  String? regconfig;

  @HiveField(6)
  String? registrationdate;

  @HiveField(7)
  String? academicyearid;

  @HiveField(8)
  String? cautiondepositamt;

  @HiveField(9)
  String? status;

  @HiveField(10)
  String? activestatus;

  @HiveField(11)
  String? roomtype;
}
