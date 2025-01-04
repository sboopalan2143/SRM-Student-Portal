class SGPAModel {
  String? status;
  String? message;
  List<SGPAData>? data;

  SGPAModel({this.status, this.message, this.data});

  SGPAModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <SGPAData>[];
      json['Data'].forEach((v) {
        data!.add(new SGPAData.fromJson(v as Map<String, dynamic>));
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

class SGPAData {
  String? attachsemesterid;
  String? attrname;
  String? attrvalue;

  SGPAData({this.attachsemesterid, this.attrname, this.attrvalue});

  SGPAData.fromJson(Map<String, dynamic> json) {
    attachsemesterid = json['attachsemesterid'] as String?;
    attrname = json['attrname'] as String?;
    attrvalue = json['attrvalue'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attachsemesterid'] = this.attachsemesterid;
    data['attrname'] = this.attrname;
    data['attrvalue'] = this.attrvalue;
    return data;
  }
}
