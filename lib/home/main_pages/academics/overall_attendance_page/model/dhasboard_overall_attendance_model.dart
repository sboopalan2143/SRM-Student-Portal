class DhasboardOverAllAttendancePercentageModel {
  String? status;
  String? message;
  List<DhasboardOverallAttendanceData>? data;

  DhasboardOverAllAttendancePercentageModel(
      {this.status, this.message, this.data});

  DhasboardOverAllAttendancePercentageModel.fromJson(
      Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <DhasboardOverallAttendanceData>[];
      json['Data'].forEach((v) {
        data!.add(new DhasboardOverallAttendanceData.fromJson(
            v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DhasboardOverallAttendanceData {
  String? studentid;
  String? totalpresenthours;
  String? totalhours;
  String? totalper;

  DhasboardOverallAttendanceData(
      {this.studentid, this.totalpresenthours, this.totalhours, this.totalper});

  DhasboardOverallAttendanceData.fromJson(Map<String, dynamic> json) {
    studentid = json['studentid'] as String?;
    totalpresenthours = json['totalpresenthours'] as String?;
    totalhours = json['totalhours'] as String?;
    totalper = json['totalper'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentid'] = this.studentid;
    data['totalpresenthours'] = this.totalpresenthours;
    data['totalhours'] = this.totalhours;
    data['totalper'] = this.totalper;
    return data;
  }
}
