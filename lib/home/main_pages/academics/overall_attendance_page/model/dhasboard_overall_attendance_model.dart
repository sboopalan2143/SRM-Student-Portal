// class DhasboardOverAllAttendancePercentageModel {
//   String? status;
//   String? message;
//   List<DhasboardOverallAttendanceData>? data;
//
//   DhasboardOverAllAttendancePercentageModel(
//       {this.status, this.message, this.data});
//
//   DhasboardOverAllAttendancePercentageModel.fromJson(
//       Map<String, dynamic> json) {
//     status = json['Status'] as String?;
//     message = json['Message'] as String?;
//     if (json['Data'] != null) {
//       data = <DhasboardOverallAttendanceData>[];
//       json['Data'].forEach((v) {
//         data!.add(new DhasboardOverallAttendanceData.fromJson(
//             v as Map<String, dynamic>));
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
// class DhasboardOverallAttendanceData {
//   String? studentid;
//   String? totalpresenthours;
//   String? totalhours;
//   String? totalper;
//
//   DhasboardOverallAttendanceData(
//       {this.studentid, this.totalpresenthours, this.totalhours, this.totalper});
//
//   DhasboardOverallAttendanceData.fromJson(Map<String, dynamic> json) {
//     studentid = json['studentid'] as String?;
//     totalpresenthours = json['totalpresenthours'] as String?;
//     totalhours = json['totalhours'] as String?;
//     totalper = json['totalper'] as String?;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['studentid'] = this.studentid;
//     data['totalpresenthours'] = this.totalpresenthours;
//     data['totalhours'] = this.totalhours;
//     data['totalper'] = this.totalper;
//     return data;
//   }
// }

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
  String? odmlper;
  String? odper;
  String? totalpresenthours;
  String? mlcnt;
  String? totalhours;
  String? absentcnt;
  String? mlper;
  String? totalper;
  String? odcnt;
  String? absentper;

  DhasboardOverallAttendanceData(
      {this.studentid,
      this.odmlper,
      this.odper,
      this.totalpresenthours,
      this.mlcnt,
      this.totalhours,
      this.absentcnt,
      this.mlper,
      this.totalper,
      this.odcnt,
      this.absentper});

  DhasboardOverallAttendanceData.fromJson(Map<String, dynamic> json) {
    studentid = json['studentid'] as String?;
    odmlper = json['odmlper'] as String?;
    odper = json['odper'] as String?;
    totalpresenthours = json['totalpresenthours'] as String?;
    mlcnt = json['mlcnt'] as String?;
    totalhours = json['totalhours'] as String?;
    absentcnt = json['absentcnt'] as String?;
    mlper = json['mlper'] as String?;
    totalper = json['totalper'] as String?;
    odcnt = json['odcnt'] as String?;
    absentper = json['absentper'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentid'] = this.studentid;
    data['odmlper'] = this.odmlper;
    data['odper'] = this.odper;
    data['totalpresenthours'] = this.totalpresenthours;
    data['mlcnt'] = this.mlcnt;
    data['totalhours'] = this.totalhours;
    data['absentcnt'] = this.absentcnt;
    data['mlper'] = this.mlper;
    data['totalper'] = this.totalper;
    data['odcnt'] = this.odcnt;
    data['absentper'] = this.absentper;
    return data;
  }
}
