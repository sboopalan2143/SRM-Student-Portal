// class GetStudentWiseGrievancesMmodel {
//   GetStudentWiseGrievancesMmodel({this.status, this.message, this.data});

//   GetStudentWiseGrievancesMmodel.fromJson(Map<String, dynamic> json) {
//     status = json['Status'] as String?;
//     message = json['Message'] as String?;
//     if (json['Data'] != null) {
//       data = <StudentWiseData>[];
//      for (final v in json['Data'] as List<dynamic>) {
//         data!.add(StudentWiseData.fromJson(v as Map<String, dynamic>));
//       }
//     }
//   }
//   String? status;
//   String? message;
//   List<StudentWiseData>? data;

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

// class StudentWiseData {
//   StudentWiseData({
//     this.grievancetime,
//     this.grievancecategory,
//     this.grievancetype,
//     this.grievancesubcategorydesc,
//     this.replytext,
//     this.subject,
//     this.grievanceid,
//     this.grievancedesc,
//     this.status,
//     this.activestatus,
//   });

//   StudentWiseData.fromJson(Map<String, dynamic> json) {
//     grievancetime = json['grievancetime'] as String?;
//     grievancecategory = json['grievancecategory'] as String?;
//     grievancetype = json['grievancetype'] as String?;
//     grievancesubcategorydesc = json['grievancesubcategorydesc'] as String?;
//     replytext = json['replytext'] as String?;
//     subject = json['subject'] as String?;
//     grievanceid = json['grievanceid'] as String?;
//     grievancedesc = json['grievancedesc'] as String?;
//     status = json['status'] as String?;
//     activestatus = json['activestatus'] as String?;
//   }
//   String? grievancetime;
//   String? grievancecategory;
//   String? grievancetype;
//   String? grievancesubcategorydesc;
//   String? replytext;
//   String? subject;
//   String? grievanceid;
//   String? grievancedesc;
//   String? status;
//   String? activestatus;

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['grievancetime'] = grievancetime;
//     data['grievancecategory'] = grievancecategory;
//     data['grievancetype'] = grievancetype;
//     data['grievancesubcategorydesc'] = grievancesubcategorydesc;
//     data['replytext'] = replytext;
//     data['subject'] = subject;
//     data['grievanceid'] = grievanceid;
//     data['grievancedesc'] = grievancedesc;
//     data['status'] = status;
//     data['activestatus'] = activestatus;
//     return data;
//   }
// }
