// class McqSubmitedDataModel {
//   String? status;
//   String? message;
//   List<McqSubmitedData>? data;

//   McqSubmitedDataModel({this.status, this.message, this.data});

//   McqSubmitedDataModel.fromJson(Map<String, dynamic> json) {
//     status = json['Status'] as String?;
//     message = json['Message'] as String?;
//     if (json['Data'] != null) {
//       data = <McqSubmitedData>[];
//       json['Data'].forEach((v) {
//         data!.add(new McqSubmitedData.fromJson(v as Map<String, dynamic>));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Status'] = status;
//     data['Message'] = message;
//     if (this.data != null) {
//       data['Data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class McqSubmitedData {
//   String? examid;
//   String? scheduleid;

//   McqSubmitedData({this.examid, this.scheduleid});

//   McqSubmitedData.fromJson(Map<String, dynamic> json) {
//     examid = json['examid'] as String?;
//     scheduleid = json['scheduleid'] as String?;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['examid'] = examid;
//     data['scheduleid'] = scheduleid;
//     return data;
//   }

//   static final empty = McqSubmitedData(
//     examid: '',
//     scheduleid: '',
//   );
// }

class McqSubmitedDataModel {
  McqSubmitedDataModel({this.status, this.message, this.data});

  McqSubmitedDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String?;
    message = json['message'] as String?;
    if (json['data'] != null) {
      data = <McqSubmitedData>[];
      for (final v in json['data'] as List<dynamic>) {
        data!.add(McqSubmitedData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<McqSubmitedData>? data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class McqSubmitedData {
  McqSubmitedData({this.examid, this.scheduleid});

  McqSubmitedData.fromJson(Map<String, dynamic> json) {
    examid = json['examid'] as int?;
    scheduleid = json['scheduleid'] as int?;
  }
  int? examid;
  int? scheduleid;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['examid'] = examid;
    data['scheduleid'] = scheduleid;
    return data;
  }

  static final empty = McqSubmitedData(
    examid: 0,
    scheduleid: 0,
  );
}
