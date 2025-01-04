class NotificationModel {
  String? status;
  String? message;
  List<NotificationData>? data;

  NotificationModel({this.status, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <NotificationData>[];
      json['Data'].forEach((v) {
        data!.add(new NotificationData.fromJson(v as Map<String, dynamic>));
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

class NotificationData {
  String? viewstatus;
  String? notificationdescription;
  String? notificationid;
  String? notificationsubject;
  String? notificationcategorydesc;

  NotificationData(
      {this.viewstatus,
      this.notificationdescription,
      this.notificationid,
      this.notificationsubject,
      this.notificationcategorydesc});

  NotificationData.fromJson(Map<String, dynamic> json) {
    viewstatus = json['viewstatus'] as String?;
    notificationdescription = json['notificationdescription'] as String?;
    notificationid = json['notificationid'] as String?;
    notificationsubject = json['notificationsubject'] as String?;
    notificationcategorydesc = json['notificationcategorydesc'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['viewstatus'] = this.viewstatus;
    data['notificationdescription'] = this.notificationdescription;
    data['notificationid'] = this.notificationid;
    data['notificationsubject'] = this.notificationsubject;
    data['notificationcategorydesc'] = this.notificationcategorydesc;
    return data;
  }
}
