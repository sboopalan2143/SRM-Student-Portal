class GetCumulativeAttedence {

  GetCumulativeAttedence({this.status, this.message, this.data});

  GetCumulativeAttedence.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <CumulativeAttendanceData>[];
      json['Data'].forEach((v) {
        data!.add(
            new CumulativeAttendanceData.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  String? status;
  String? message;
  List<CumulativeAttendanceData>? data;

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

class CumulativeAttendanceData {

  CumulativeAttendanceData(
      {this.attendancemonthyear,
      this.medical,
      this.absent,
      this.present,
      this.odabsent,
      this.odpresent});

  CumulativeAttendanceData.fromJson(Map<String, dynamic> json) {
    attendancemonthyear = json['attendancemonthyear'] as String?;
    medical = json['medical'] as String?;
    absent = json['absent'] as String?;
    present = json['present'] as String?;
    odabsent = json['odabsent'] as String?;
    odpresent = json['odpresent'] as String?;
  }
  String? attendancemonthyear;
  String? medical;
  String? absent;
  String? present;
  String? odabsent;
  String? odpresent;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendancemonthyear'] = this.attendancemonthyear;
    data['medical'] = this.medical;
    data['absent'] = this.absent;
    data['present'] = this.present;
    data['odabsent'] = this.odabsent;
    data['odpresent'] = this.odpresent;
    return data;
  }
}
