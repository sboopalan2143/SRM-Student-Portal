// class GetCumulativeAttedence {
//   GetCumulativeAttedence({this.status, this.message, this.data});

//   GetCumulativeAttedence.fromJson(Map<String, dynamic> json) {
//     status = json['Status'] as String?;
//     message = json['Message'] as String?;
//     if (json['Data'] != null) {
//       data = <CumulativeAttendanceData>[];
//       for (final v in json['Data'] as List<dynamic>) {
//         data!.add(CumulativeAttendanceData.fromJson(v as Map<String, dynamic>));
//       }
//     }
//   }
//   String? status;
//   String? message;
//   List<CumulativeAttendanceData>? data;

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['Status'] = status;
//     data['Message'] = message;
//     if (this.data != null) {
//       data['Data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class CumulativeAttendanceData {
//   CumulativeAttendanceData({
//     this.attendancemonthyear,
//     this.medical,
//     this.absent,
//     this.present,
//     this.odabsent,
//     this.odpresent,
//   });

//   CumulativeAttendanceData.fromJson(Map<String, dynamic> json) {
//     attendancemonthyear = json['attendancemonthyear'] as String?;
//     medical = json['medical'] as String?;
//     absent = json['absent'] as String?;
//     present = json['present'] as String?;
//     odabsent = json['odabsent'] as String?;
//     odpresent = json['odpresent'] as String?;
//   }
//   String? attendancemonthyear;
//   String? medical;
//   String? absent;
//   String? present;
//   String? odabsent;
//   String? odpresent;

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['attendancemonthyear'] = attendancemonthyear;
//     data['medical'] = medical;
//     data['absent'] = absent;
//     data['present'] = present;
//     data['odabsent'] = odabsent;
//     data['odpresent'] = odpresent;
//     return data;
//   }
// }
