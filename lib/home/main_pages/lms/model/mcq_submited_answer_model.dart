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
  String? status;
  String? message;
  List<McqSubmitedData>? data;

  McqSubmitedDataModel({this.status, this.message, this.data});

  McqSubmitedDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String?;
    message = json['message'] as String?;
    if (json['data'] != null) {
      data = <McqSubmitedData>[];
      json['data'].forEach((v) {
        data!.add(new McqSubmitedData.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class McqSubmitedData {
  int? examid;
  int? scheduleid;

  McqSubmitedData({this.examid, this.scheduleid});

  McqSubmitedData.fromJson(Map<String, dynamic> json) {
    examid = json['examid'] as int?;
    scheduleid = json['scheduleid'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['examid'] = examid;
    data['scheduleid'] = scheduleid;
    return data;
  }

  static final empty = McqSubmitedData(
    examid: 0,
    scheduleid: 0,
  );
}
