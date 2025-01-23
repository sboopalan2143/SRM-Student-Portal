// class TimeTableSubjectListModel {
//   String? status;
//   String? message;
//   List<TimeTableData>? data;
//
//   TimeTableSubjectListModel({this.status, this.message, this.data});
//
//   TimeTableSubjectListModel.fromJson(Map<String, dynamic> json) {
//     status = json['Status'] as String?;
//     message = json['Message'] as String?;
//     if (json['Data'] != null) {
//       data = <TimeTableData>[];
//       json['Data'].forEach((v) {
//         data!.add(new TimeTableData.fromJson(v as Map<String, dynamic>));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Status'] = this.status;
//     data['Message'] = this.message;
//     if (this.data != null) {
//       data['Data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class TimeTableData {
//   String? dayorderdesc;
//   String? dayorderid;
//   String? hourid;
//   String? subjects;
//
//   TimeTableData(
//       {this.dayorderdesc, this.dayorderid, this.hourid, this.subjects});
//
//   TimeTableData.fromJson(Map<String, dynamic> json) {
//     dayorderdesc = json['dayorderdesc'] as String?;
//     dayorderid = json['dayorderid'] as String?;
//     hourid = json['hourid'] as String?;
//     subjects = json['subjects'] as String?;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['dayorderdesc'] = this.dayorderdesc;
//     data['dayorderid'] = this.dayorderid;
//     data['hourid'] = this.hourid;
//     data['subjects'] = this.subjects;
//     return data;
//   }
// }
//
//
//

class TimeTableSubjectListModel {
  String? status;
  String? message;
  List<TimeTableData>? data;

  TimeTableSubjectListModel({this.status, this.message, this.data});

  TimeTableSubjectListModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <TimeTableData>[];
      json['Data'].forEach((v) {
        data!.add(new TimeTableData.fromJson(v as Map<String, dynamic>));
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

class TimeTableData {
  String? dayorderdesc;
  String? dayorderid;
  String? hourid;
  String? subjectcode;
  String? subjectdesc;
  String? faculty;

  TimeTableData(
      {this.dayorderdesc,
      this.dayorderid,
      this.hourid,
      this.subjectcode,
      this.subjectdesc,
      this.faculty});

  TimeTableData.fromJson(Map<String, dynamic> json) {
    dayorderdesc = json['dayorderdesc'] as String?;
    dayorderid = json['dayorderid'] as String?;
    hourid = json['hourid'] as String?;
    subjectcode = json['subjectcode'] as String?;
    subjectdesc = json['subjectdesc'] as String?;
    faculty = json['faculty'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dayorderdesc'] = this.dayorderdesc;
    data['dayorderid'] = this.dayorderid;
    data['hourid'] = this.hourid;
    data['subjectcode'] = this.subjectcode;
    data['subjectdesc'] = this.subjectdesc;
    data['faculty'] = this.faculty;
    return data;
  }
}
