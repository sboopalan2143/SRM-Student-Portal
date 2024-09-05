class GrievanceCategory {
  String? status;
  String? message;
  List<GrievanceCategoryData>? data;

  GrievanceCategory({this.status, this.message, this.data});

  GrievanceCategory.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <GrievanceCategoryData>[];
      json['Data'].forEach((v) {
        data!
            .add(new GrievanceCategoryData.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = status;
    data['Message'] = message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GrievanceCategoryData {
  String? grievancekcategory;
  String? grievancekcategoryid;

  GrievanceCategoryData({this.grievancekcategory, this.grievancekcategoryid});

  GrievanceCategoryData.fromJson(Map<String, dynamic> json) {
    grievancekcategory = json['grievancekcategory'] as String?;
    grievancekcategoryid = json['grievancekcategoryid'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grievancekcategory'] = grievancekcategory;
    data['grievancekcategoryid'] = grievancekcategoryid;
    return data;
  }
}
