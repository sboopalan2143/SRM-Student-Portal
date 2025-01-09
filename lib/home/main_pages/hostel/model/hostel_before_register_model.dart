// class HostelRegisterModel {
//   HostelRegisterModel({this.status, this.message, this.data});

//   HostelRegisterModel.fromJson(Map<String, dynamic> json) {
//     status = json['Status'] as String?;
//     message = json['Message'] as String?;
//     if (json['Data'] != null) {
//       data = <HostelRegisterData>[];
//       for (final v in json['Data'] as List<dynamic>) {
//         data!.add(HostelRegisterData.fromJson(v as Map<String, dynamic>));
//       }
//     }
//   }
//   String? status;
//   String? message;
//   List<HostelRegisterData>? data;

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['Status'] = status;
//     data['Message'] = message;
//     if (this.data != null) {
//       data['Data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class HostelRegisterData {
//   HostelRegisterData({
//     this.applnfeeamount,
//     this.controllerid,
//     this.regconfig,
//     this.academicyearid,
//     this.cautiondepositamt,
//     this.status,
//   });

//   HostelRegisterData.fromJson(Map<String, dynamic> json) {
//     applnfeeamount = json['applnfeeamount'] as String?;
//     controllerid = json['controllerid'] as String?;
//     regconfig = json['regconfig'] as String?;
//     academicyearid = json['academicyearid'] as String?;
//     cautiondepositamt = json['cautiondepositamt'] as String?;
//     status = json['status'] as String?;
//   }
//   String? applnfeeamount;
//   String? controllerid;
//   String? regconfig;
//   String? academicyearid;
//   String? cautiondepositamt;
//   String? status;

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

//   static final empty = HostelRegisterData(
//     applnfeeamount: '',
//     controllerid: '',
//     regconfig: '',
//     academicyearid: '',
//     cautiondepositamt: '',
//     status: '',
//   );
// }

// class HostelRegisterModel {
//   String? status;
//   String? message;
//   List<HostelRegisterData>? data;

//   HostelRegisterModel({this.status, this.message, this.data});

//   HostelRegisterModel.fromJson(Map<String, dynamic> json) {
//     status = json['Status'] as String?;
//     message = json['Message'] as String?;
//     if (json['Data'] != null) {
//       data = <HostelRegisterData>[];
//       json['Data'].forEach((v) {
//         data!.add(new HostelRegisterData.fromJson(v as Map<String, dynamic>));
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

// class HostelRegisterData {
//   String? messfeeamount;
//   String? applnfeeamount;
//   String? hostel;
//   String? hostelfeeamount;
//   String? regconfig;
//   String? registrationdate;
//   String? academicyearid;
//   String? cautiondepositamt;
//   String? status;
//   String? activestatus;
//   String? roomtype;

//   HostelRegisterData(
//       {this.messfeeamount,
//       this.applnfeeamount,
//       this.hostel,
//       this.hostelfeeamount,
//       this.regconfig,
//       this.registrationdate,
//       this.academicyearid,
//       this.cautiondepositamt,
//       this.status,
//       this.activestatus,
//       this.roomtype,});

//   HostelRegisterData.fromJson(Map<String, dynamic> json) {
//     messfeeamount = json['messfeeamount'] as String?;
//     applnfeeamount = json['applnfeeamount'] as String?;
//     hostel = json['hostel'] as String?;
//     hostelfeeamount = json['hostelfeeamount'] as String?;
//     regconfig = json['regconfig'] as String?;
//     registrationdate = json['registrationdate'] as String?;
//     academicyearid = json['academicyearid'] as String?;
//     cautiondepositamt = json['cautiondepositamt'] as String?;
//     status = json['status'] as String?;
//     activestatus = json['activestatus'] as String?;
//     roomtype = json['roomtype'] as String?;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['messfeeamount'] = messfeeamount;
//     data['applnfeeamount'] = applnfeeamount;
//     data['hostel'] = hostel;
//     data['hostelfeeamount'] = hostelfeeamount;
//     data['regconfig'] = regconfig;
//     data['registrationdate'] = registrationdate;
//     data['academicyearid'] = academicyearid;
//     data['cautiondepositamt'] = cautiondepositamt;
//     data['status'] = status;
//     data['activestatus'] = activestatus;
//     data['roomtype'] = roomtype;
//     return data;
//   }

//   static final empty = HostelRegisterData(
//     messfeeamount: '',
//     applnfeeamount: '',
//     hostel: '',
//     hostelfeeamount: '',
//     regconfig: '',
//     registrationdate: '',
//     academicyearid: '',
//     cautiondepositamt: '',
//     status: '',
//     activestatus: '',
//     roomtype: '',
//   );
// }

class HostelRegisterModel {
  String? status;
  String? message;
  List<HostelRegisterData>? data;

  HostelRegisterModel({this.status, this.message, this.data});

  HostelRegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <HostelRegisterData>[];
      json['Data'].forEach((v) {
        data!.add(new HostelRegisterData.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = status;
    data['Message'] = message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HostelRegisterData {
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

  HostelRegisterData(
      {this.messfeeamount,
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
      this.roomtype});

  HostelRegisterData.fromJson(Map<String, dynamic> json) {
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

  static final empty = HostelRegisterData(
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
