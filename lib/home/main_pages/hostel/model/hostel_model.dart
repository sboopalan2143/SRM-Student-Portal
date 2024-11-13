// class HostelModel {
//   HostelModel({this.status, this.message, this.data});

//   HostelModel.fromJson(Map<String, dynamic> json) {
//     status = json['Status'] as String?;
//     message = json['Message'] as String?;
//     if (json['Data'] != null) {
//       data = <HostelData>[];
//       for (final v in json['Data'] as List<dynamic>) {
//         data!.add(HostelData.fromJson(v as Map<String, dynamic>));
//       }
//     }
//   }
//   String? status;
//   String? message;
//   List<HostelData>? data;

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

// class HostelData {
//   HostelData({this.hostelname, this.hostelid});

//   HostelData.fromJson(Map<String, dynamic> json) {
//     hostelname = json['hostelname'] as String?;
//     hostelid = json['hostelid'] as String?;
//   }
//   String? hostelname;
//   String? hostelid;

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['hostelname'] = hostelname;
//     data['hostelid'] = hostelid;
//     return data;
//   }

//   static final empty = HostelData(hostelname: 'Select Hostel', hostelid: '');
// }
