class StudentHomePageFeeDueModel {
  String? status;
  String? message;
  List<FeesDueHomePageData>? data;

  StudentHomePageFeeDueModel({this.status, this.message, this.data});

  StudentHomePageFeeDueModel.fromJson(Map<String, dynamic> json) {
    status = json['Status']as String?;
    message = json['Message']as String?;
    if (json['Data'] != null) {
      data = <FeesDueHomePageData>[];
      json['Data'].forEach((v) {
        data!.add(new FeesDueHomePageData.fromJson(v as Map<String, dynamic>));
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

class FeesDueHomePageData {
  String? currentdue;

  FeesDueHomePageData({this.currentdue});

  FeesDueHomePageData.fromJson(Map<String, dynamic> json) {
    currentdue = json['currentdue']as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentdue'] = this.currentdue;
    return data;
  }
}