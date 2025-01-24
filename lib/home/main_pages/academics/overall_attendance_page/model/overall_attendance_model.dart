class SubjectwiseOverallAttendanceModel {
  String? status;
  String? message;
  List<SubjectOverallAttendanceData>? data;

  SubjectwiseOverallAttendanceModel({this.status, this.message, this.data});

  SubjectwiseOverallAttendanceModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <SubjectOverallAttendanceData>[];
      json['Data'].forEach((v) {
        data!.add(new SubjectOverallAttendanceData.fromJson(
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

class SubjectOverallAttendanceData {
  String? mLODper;
  String? total;
  String? overallpercent;
  String? absent;
  String? subjectcode;
  String? present;
  String? presentper;
  String? subjectdesc;
  String? ml;

  SubjectOverallAttendanceData(
      {this.mLODper,
      this.total,
      this.overallpercent,
      this.absent,
      this.subjectcode,
      this.present,
      this.presentper,
      this.subjectdesc,
      this.ml});

  SubjectOverallAttendanceData.fromJson(Map<String, dynamic> json) {
    mLODper = json['MLODper'] as String?;
    total = json['total'] as String?;
    overallpercent = json['Overallpercent'] as String?;
    absent = json['absent'] as String?;
    subjectcode = json['subjectcode'] as String?;
    present = json['present'] as String?;
    presentper = json['presentper'] as String?;
    subjectdesc = json['subjectdesc'] as String?;
    ml = json['ml'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MLODper'] = this.mLODper;
    data['total'] = this.total;
    data['Overallpercent'] = this.overallpercent;
    data['absent'] = this.absent;
    data['subjectcode'] = this.subjectcode;
    data['present'] = this.present;
    data['presentper'] = this.presentper;
    data['subjectdesc'] = this.subjectdesc;
    data['ml'] = this.ml;
    return data;
  }
}
