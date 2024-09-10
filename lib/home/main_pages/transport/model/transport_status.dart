class getTransportRegistrationStatusModel {
  getTransportRegistrationStatusModel({this.status, this.message, this.data});

  getTransportRegistrationStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <TransportStatusData>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(TransportStatusData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<TransportStatusData>? data;

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

class TransportStatusData {
  TransportStatusData({
    this.transportstatus,
    this.applicationfee,
    this.officeid,
    this.regconfig,
    this.academicyearid,
    this.status,
  });

  TransportStatusData.fromJson(Map<String, dynamic> json) {
    transportstatus = json['transportstatus'] as String?;
    applicationfee = json['applicationfee'] as String?;
    officeid = json['officeid'] as String?;
    regconfig = json['regconfig'] as String?;
    academicyearid = json['academicyearid'] as String?;
    status = json['status'] as String?;
  }
  String? transportstatus;
  String? applicationfee;
  String? officeid;
  String? regconfig;
  String? academicyearid;
  String? status;

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
}
