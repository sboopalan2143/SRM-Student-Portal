class HostelAfterRegisterModel {
  HostelAfterRegisterModel({this.status, this.message, this.data});

  HostelAfterRegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <HostelAfterRegisterData>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(HostelAfterRegisterData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<HostelAfterRegisterData>? data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HostelAfterRegisterData {
  HostelAfterRegisterData({
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

  HostelAfterRegisterData.fromJson(Map<String, dynamic> json) {
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
  String? messfeeamount;
  String? applnfeeamount;
  String? controllerid;
  String? hostel;
  String? hostelfeeamount;
  String? regconfig;
  String? registrationdate;
  String? academicyearid;
  String? cautiondepositamt;
  String? status;
  String? activestatus;
  String? roomtype;

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

  static final empty = HostelAfterRegisterData(
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
}

// class HostelAfterRegisterModel {
//   String? status;
//   String? message;
//   List<HostelAfterRegisterData>? data;

//   HostelAfterRegisterModel({this.status, this.message, this.data});

//   HostelAfterRegisterModel.fromJson(Map<String, dynamic> json) {
//     status = json['Status'] as String?;
//     message = json['Message'] as String?;
//     if (json['Data'] != null) {
//       data = <HostelAfterRegisterData>[];
//       json['Data'].forEach((v) {
//         data!.add(
//             new HostelAfterRegisterData.fromJson(v as Map<String, dynamic>));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Status'] = status;
//     data['Message'] = message;
//     if (this.data != null) {
//       data['Data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class HostelAfterRegisterData {
//   String? applnfeeamount;
//   String? regconfig;
//   String? academicyearid;
//   String? cautiondepositamt;
//   String? status;

//   static var empty;

//   HostelAfterRegisterData(
//       {this.applnfeeamount,
//       this.regconfig,
//       this.academicyearid,
//       this.cautiondepositamt,
//       this.status});

//   HostelAfterRegisterData.fromJson(Map<String, dynamic> json) {
//     applnfeeamount = json['applnfeeamount'] as String?;
//     regconfig = json['regconfig'] as String?;
//     academicyearid = json['academicyearid'] as String?;
//     cautiondepositamt = json['cautiondepositamt'] as String?;
//     status = json['status'] as String?;
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['applnfeeamount'] = applnfeeamount;
//     data['regconfig'] = regconfig;
//     data['academicyearid'] = academicyearid;
//     data['cautiondepositamt'] = cautiondepositamt;
//     data['status'] = status;
//     return data;
//   }
// }
