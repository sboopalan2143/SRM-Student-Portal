class LmsContentDetailsModel {
  String? status;
  String? message;
  List<LmsContentDetailsData>? data;

  LmsContentDetailsModel({this.status, this.message, this.data});

  LmsContentDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <LmsContentDetailsData>[];
      json['Data'].forEach((v) {
        data!
            .add(new LmsContentDetailsData.fromJson(v as Map<String, dynamic>));
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

class LmsContentDetailsData {
  String? employeefirstandmidname;
  String? newcontent;
  String? description;
  String? title;
  String? url;
  String? contentsharingid;
  String? uploadeddate;

  LmsContentDetailsData(
      {this.employeefirstandmidname,
      this.newcontent,
      this.description,
      this.title,
      this.url,
      this.contentsharingid,
      this.uploadeddate});

  LmsContentDetailsData.fromJson(Map<String, dynamic> json) {
    employeefirstandmidname = json['employeefirstandmidname'] as String?;
    newcontent = json['newcontent'] as String?;
    description = json['description'] as String?;
    title = json['title'] as String?;
    url = json['url'] as String?;
    contentsharingid = json['contentsharingid'] as String?;
    uploadeddate = json['uploadeddate'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeefirstandmidname'] = this.employeefirstandmidname;
    data['newcontent'] = this.newcontent;
    data['description'] = this.description;
    data['title'] = this.title;
    data['url'] = this.url;
    data['contentsharingid'] = this.contentsharingid;
    data['uploadeddate'] = this.uploadeddate;
    return data;
  }
}
