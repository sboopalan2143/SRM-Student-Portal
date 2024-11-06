// class GetSubjectWiseAttedence {
//   GetSubjectWiseAttedence({this.status, this.message, this.data});

//   GetSubjectWiseAttedence.fromJson(Map<String, dynamic> json) {
//     status = json['Status'] as String?;
//     message = json['Message'] as String?;
//     if (json['Data'] != null) {
//       data = <SubjectAttendanceData>[];
//       for (final v in json['Data'] as List<dynamic>) {
//         data!.add(SubjectAttendanceData.fromJson(v as Map<String, dynamic>));
//       }
//     }
//   }
//   String? status;
//   String? message;
//   List<SubjectAttendanceData>? data;

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

// class SubjectAttendanceData {
//   SubjectAttendanceData({
//     this.total,
//     this.presentpercentage,
//     this.absent,
//     this.subjectcode,
//     this.present,
//     this.subjectdesc,
//   });

//   SubjectAttendanceData.fromJson(Map<String, dynamic> json) {
//     total = json['total'] as String?;
//     presentpercentage = json['presentpercentage'] as String?;
//     absent = json['absent'] as String?;
//     subjectcode = json['subjectcode'] as String?;
//     present = json['present'] as String?;
//     subjectdesc = json['subjectdesc'] as String?;
//   }
//   String? total;
//   String? presentpercentage;
//   String? absent;
//   String? subjectcode;
//   String? present;
//   String? subjectdesc;

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['total'] = total;
//     data['presentpercentage'] = presentpercentage;
//     data['absent'] = absent;
//     data['subjectcode'] = subjectcode;
//     data['present'] = present;
//     data['subjectdesc'] = subjectdesc;
//     return data;
//   }
// }
