class CGPAModel {
  String? status;
  String? message;
  List<CGPAData>? data;

  CGPAModel({this.status, this.message, this.data});

  CGPAModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <CGPAData>[];
      json['Data'].forEach((v) {
        data!.add(new CGPAData.fromJson(v as Map<String, dynamic>));
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

class CGPAData {
  String? cgpa;

  CGPAData({this.cgpa});

  CGPAData.fromJson(Map<String, dynamic> json) {
    cgpa = json['cgpa'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cgpa'] = this.cgpa;
    return data;
  }
}
