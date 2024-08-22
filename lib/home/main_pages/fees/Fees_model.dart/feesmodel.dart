class FeesPaidDetails {
  String? status;
  String? message;
  List<FeesPaidData>? data;

  FeesPaidDetails({this.status, this.message, this.data});

  FeesPaidDetails.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <FeesPaidData>[];
      json['Data'].forEach((v) {
        data!.add(new FeesPaidData.fromJson(v as Map<String, dynamic>));
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

class FeesPaidData {
  String? membercode;
  String? membertype;
  String? policyname;
  String? membername;
  String? status;

  FeesPaidData(
      {this.membercode,
      this.membertype,
      this.policyname,
      this.membername,
      this.status});

  FeesPaidData.fromJson(Map<String, dynamic> json) {
    membercode = json['membercode'] as String?;
    membertype = json['membertype'] as String?;
    policyname = json['policyname'] as String?;
    membername = json['membername'] as String?;
    status = json['status'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['membercode'] = this.membercode;
    data['membertype'] = this.membertype;
    data['policyname'] = this.policyname;
    data['membername'] = this.membername;
    data['status'] = this.status;
    return data;
  }
}
