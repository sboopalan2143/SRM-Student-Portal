// import 'package:hive/hive.dart';

// part 'hostel_before_register_hive_model.g.dart';

// @HiveType(typeId: 14)
// class HostelBeforeRegisterHiveData {
//   HostelBeforeRegisterHiveData({
//     this.applnfeeamount,
//     this.controllerid,
//     this.regconfig,
//     this.academicyearid,
//     this.cautiondepositamt,
//     this.status,
//   });

//   HostelBeforeRegisterHiveData.fromJson(Map<String, dynamic> json) {
//     applnfeeamount = json['applnfeeamount'] as String?;
//     controllerid = json['controllerid'] as String?;
//     regconfig = json['regconfig'] as String?;
//     academicyearid = json['academicyearid'] as String?;
//     cautiondepositamt = json['cautiondepositamt'] as String?;
//     status = json['status'] as String?;
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['applnfeeamount'] = applnfeeamount;
//     data['controllerid'] = controllerid;
//     data['regconfig'] = regconfig;
//     data['academicyearid'] = academicyearid;
//     data['cautiondepositamt'] = cautiondepositamt;
//     data['status'] = status;
//     return data;
//   }

//   static final empty = HostelBeforeRegisterHiveData(
//     applnfeeamount: '',
//     controllerid: '',
//     regconfig: '',
//     academicyearid: '',
//     cautiondepositamt: '',
//     status: '',
//   );

//   @HiveField(0)
//   String? applnfeeamount;

//   @HiveField(1)
//   String? controllerid;

//   @HiveField(2)
//   String? regconfig;

//   @HiveField(3)
//   String? academicyearid;

//   @HiveField(4)
//   String? cautiondepositamt;

//   @HiveField(5)
//   String? status;
// }
