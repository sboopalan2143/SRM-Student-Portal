// class ExamDetails {
//   ExamDetails({this.status, this.message, this.data});

//   ExamDetails.fromJson(Map<String, dynamic> json) {
//     status = json['Status'] as String?;
//     message = json['Message'] as String?;
//     if (json['Data'] != null) {
//       data = <ExamDetailsData>[];
//       for (final v in json['Data'] as List<dynamic>) {
//         data!.add(ExamDetailsData.fromJson(v as Map<String, dynamic>));
//       }
//     }
//   }
//   String? status;
//   String? message;
//   List<ExamDetailsData>? data;

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

// class ExamDetailsData {
//   ExamDetailsData({
//     this.result,
//     this.internal,
//     this.external,
//     this.grade,
//     this.semester,
//     this.monthyear,
//     this.marksobtained,
//     this.subjectcode,
//     this.credit,
//     this.subjectdesc,
//     this.attempts,
//   });

//   ExamDetailsData.fromJson(Map<String, dynamic> json) {
//     result = json['result'] as String?;
//     internal = json['internal'] as String?;
//     external = json['external'] as String?;
//     grade = json['grade'] as String?;
//     semester = json['semester'] as String?;
//     monthyear = json['monthyear'] as String?;
//     marksobtained = json['marksobtained'] as String?;
//     subjectcode = json['subjectcode'] as String?;
//     credit = json['credit'] as String?;
//     subjectdesc = json['subjectdesc'] as String?;
//     attempts = json['attempts'] as String?;
//   }
//   String? result;
//   String? internal;
//   String? external;
//   String? grade;
//   String? semester;
//   String? monthyear;
//   String? marksobtained;
//   String? subjectcode;
//   String? credit;
//   String? subjectdesc;
//   String? attempts;

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['result'] = result;
//     data['internal'] = internal;
//     data['external'] = external;
//     data['grade'] = grade;
//     data['semester'] = semester;
//     data['monthyear'] = monthyear;
//     data['marksobtained'] = marksobtained;
//     data['subjectcode'] = subjectcode;
//     data['credit'] = credit;
//     data['subjectdesc'] = subjectdesc;
//     data['attempts'] = attempts;
//     return data;
//   }

//   static final empty = ExamDetailsData(
//     result: '',
//     internal: '',
//     external: '',
//     grade: '',
//     semester: '',
//     monthyear: '',
//     marksobtained: '',
//     subjectcode: '',
//     credit: '',
//     subjectdesc: '',
//     attempts: '',
//   );
// }
