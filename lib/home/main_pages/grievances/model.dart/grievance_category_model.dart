class GrievanceCategory {
  GrievanceCategory({this.status, this.message, this.data});

  GrievanceCategory.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <GrievanceCategoryData>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(GrievanceCategoryData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<GrievanceCategoryData>? data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static final empty = GrievanceCategory(
    data: <GrievanceCategoryData>[],
    message: '',
    status: '',
  );
}

class GrievanceCategoryData {
  GrievanceCategoryData({this.grievancekcategory, this.grievancekcategoryid});

  GrievanceCategoryData.fromJson(Map<String, dynamic> json) {
    grievancekcategory = json['grievancekcategory'] as String?;
    grievancekcategoryid = json['grievancekcategoryid'] as String?;
  }
  String? grievancekcategory;
  String? grievancekcategoryid;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['grievancekcategory'] = grievancekcategory;
    data['grievancekcategoryid'] = grievancekcategoryid;
    return data;
  }

  static final empty = GrievanceCategoryData(
    grievancekcategory: 'Grievances Category',
    grievancekcategoryid: '',
  );
}
