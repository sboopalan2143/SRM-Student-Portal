class NotificationCountModel {
  String? status;
  String? message;
  List<NotificationCountData>? data;

  NotificationCountModel({this.status, this.message, this.data});

  NotificationCountModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <NotificationCountData>[];
      json['Data'].forEach((v) {
        data!
            .add(new NotificationCountData.fromJson(v as Map<String, dynamic>));
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

class NotificationCountData {
  String? unreadnotificationcount;

  NotificationCountData({this.unreadnotificationcount});

  NotificationCountData.fromJson(Map<String, dynamic> json) {
    unreadnotificationcount = json['unreadnotificationcount'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unreadnotificationcount'] = this.unreadnotificationcount;
    return data;
  }
}
