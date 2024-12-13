class RegconfigModel {
  RegconfigModel({this.status, this.message, this.data});

  RegconfigModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <RegconfigData>[];
      json['Data'].forEach((dynamic v) {
        data!.add(RegconfigData.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  String? status;
  String? message;
  List<RegconfigData>? data;

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

class RegconfigData {
  RegconfigData.fromJson(Map<String, dynamic> json) {
    applnfeeamount = json['applnfeeamount'] as int?;
    regconfig = json['regconfig'] as int?;
    academicyearid = json['academicyearid'] as int?;
    cautiondepositamt = json['cautiondepositamt'] as int?;
    status = json['status'] as int?;
  }

  RegconfigData({
    this.applnfeeamount,
    this.regconfig,
    this.academicyearid,
    this.cautiondepositamt,
    this.status,
  });
  int? applnfeeamount;
  int? regconfig;
  int? academicyearid;
  int? cautiondepositamt;
  int? status;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['applnfeeamount'] = applnfeeamount;
    data['regconfig'] = regconfig;
    data['academicyearid'] = academicyearid;
    data['cautiondepositamt'] = cautiondepositamt;
    data['status'] = status;
    return data;
  }
}
