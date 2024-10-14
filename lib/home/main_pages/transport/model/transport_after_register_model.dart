class GetTransportAfterRegistrationStateModel {
  GetTransportAfterRegistrationStateModel(
      {this.status, this.message, this.data,});

  GetTransportAfterRegistrationStateModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <TransportAfterRegisterData>[];
      // ignore: avoid_dynamic_calls
      json['Data'].forEach((dynamic v) {
        data!.add(
          TransportAfterRegisterData.fromJson(v as Map<String, dynamic>),
        );
      });
    }
  }
  String? status;
  String? message;
  List<TransportAfterRegisterData>? data;

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

class TransportAfterRegisterData {
  TransportAfterRegisterData({
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

  TransportAfterRegisterData.fromJson(Map<String, dynamic> json) {
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
  String? transportstatus;
  String? applicationfee;
  String? amount;
  String? controllerid;
  String? officeid;
  String? regconfig;
  String? boardingpointname;
  String? busroutename;
  String? registrationdate;
  String? academicyearid;
  String? status;
  String? activestatus;

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

  static final empty = TransportAfterRegisterData(
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
}
