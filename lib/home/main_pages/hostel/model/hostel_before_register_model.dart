class HostelRegisterModel {
  HostelRegisterModel({this.status, this.message, this.data});

  HostelRegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <HostelRegisterData>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(HostelRegisterData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<HostelRegisterData>? data;

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

class HostelRegisterData {
  HostelRegisterData({
    this.applnfeeamount,
    this.controllerid,
    this.regconfig,
    this.academicyearid,
    this.cautiondepositamt,
    this.status,
  });

  HostelRegisterData.fromJson(Map<String, dynamic> json) {
    applnfeeamount = json['applnfeeamount'] as String?;
    controllerid = json['controllerid'] as String?;
    regconfig = json['regconfig'] as String?;
    academicyearid = json['academicyearid'] as String?;
    cautiondepositamt = json['cautiondepositamt'] as String?;
    status = json['status'] as String?;
  }
  String? applnfeeamount;
  String? controllerid;
  String? regconfig;
  String? academicyearid;
  String? cautiondepositamt;
  String? status;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['applnfeeamount'] = applnfeeamount;
    data['controllerid'] = controllerid;
    data['regconfig'] = regconfig;
    data['academicyearid'] = academicyearid;
    data['cautiondepositamt'] = cautiondepositamt;
    data['status'] = status;
    return data;
  }

  static final empty = HostelRegisterData(
    applnfeeamount: '',
    controllerid: '',
    regconfig: '',
    academicyearid: '',
    cautiondepositamt: '',
    status: '',
  );
}
