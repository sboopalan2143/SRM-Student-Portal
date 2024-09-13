class GetFeesDetailsModel {
  String? status;
  String? message;
  List<GetFeesData>? data;

  GetFeesDetailsModel({this.status, this.message, this.data});

  GetFeesDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <GetFeesData>[];
      json['Data'].forEach((v) {
        data!.add( GetFeesData.fromJson(v as Map<String, dynamic>));
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

class GetFeesData {
  String? duedate;
  String? duename;
  String? dueamount;
  String? duedescription;
  String? amtcollected;
  String? currentdue;

  GetFeesData(
      {this.duedate,
      this.duename,
      this.dueamount,
      this.duedescription,
      this.amtcollected,
      this.currentdue});

  GetFeesData.fromJson(Map<String, dynamic> json) {
    duedate = json['duedate'] as String?;
    duename = json['duename'] as String?;
    dueamount = json['dueamount'] as String?;
    duedescription = json['duedescription'] as String?;
    amtcollected = json['amtcollected'] as String?;
    currentdue = json['currentdue'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['duedate'] = duedate;
    data['duename'] = duename;
    data['dueamount'] = dueamount;
    data['duedescription'] = duedescription;
    data['amtcollected'] = amtcollected;
    data['currentdue'] = currentdue;
    return data;
  }
}
