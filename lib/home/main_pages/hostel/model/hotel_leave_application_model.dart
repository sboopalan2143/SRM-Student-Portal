class HostelLeaveApplicationModel {
  HostelLeaveApplicationModel({this.status, this.message, this.data});

  HostelLeaveApplicationModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <HostelLeaveData>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(HostelLeaveData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<HostelLeaveData>? data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HostelLeaveData {
  HostelLeaveData({
    this.leavetodate,
    this.reason,
    this.leavefromdate,
    this.status,
  });

  HostelLeaveData.fromJson(Map<String, dynamic> json) {
    leavetodate = json['leavetodate'] as String?;
    reason = json['reason'] as String?;
    leavefromdate = json['leavefromdate'] as String?;
    status = json['status'] as String?;
  }
  String? leavetodate;
  String? reason;
  String? leavefromdate;
  String? status;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['leavetodate'] = leavetodate;
    data['reason'] = reason;
    data['leavefromdate'] = leavefromdate;
    data['status'] = status;
    return data;
  }
}
