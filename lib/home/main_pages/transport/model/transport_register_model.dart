class GetTransportRegistrationStateModel {
  GetTransportRegistrationStateModel({this.status, this.message, this.data});

  GetTransportRegistrationStateModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <TransportRegisterData>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(TransportRegisterData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<TransportRegisterData>? data;

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

class TransportRegisterData {
  TransportRegisterData(
      {this.transportstatus,
      this.applicationfee,
      this.controllerid,
      this.officeid,
      this.regconfig,
      this.academicyearid,
      this.status});

  TransportRegisterData.fromJson(Map<String, dynamic> json) {
    transportstatus = json['transportstatus'] as String?;
    applicationfee = json['applicationfee'] as String?;
    controllerid = json['controllerid'] as String?;
    officeid = json['officeid'] as String?;
    regconfig = json['regconfig'] as String?;
    academicyearid = json['academicyearid'] as String?;
    status = json['status'] as String?;
  }
  String? transportstatus;
  String? applicationfee;
  String? controllerid;
  String? officeid;
  String? regconfig;
  String? academicyearid;
  String? status;

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

  static final empty = TransportRegisterData(
    controllerid: '',
    regconfig: '',
    academicyearid: '',
    applicationfee: '',
    officeid: '',
    transportstatus: '',
    status: '',
  );
}
