class BorderPointModel {
  BorderPointModel({this.status, this.message, this.data});

  BorderPointModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <BorderPointData>[];
      json['Data'].forEach((v) {
        data!.add(new BorderPointData.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  String? status;
  String? message;
  List<BorderPointData>? data;

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

class BorderPointData {
  BorderPointData.fromJson(Map<String, dynamic> json) {
    transportstatus = json['transportstatus'] as String?;
    fare = json['fare'] as String?;
    boardingpointname = json['boardingpointname'] as String?;
    busboardingpointid = json['busboardingpointid'] as String?;
  }

  BorderPointData(
      {this.transportstatus,
      this.fare,
      this.boardingpointname,
      this.busboardingpointid});
  String? transportstatus;
  String? fare;
  String? boardingpointname;
  String? busboardingpointid;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['transportstatus'] = transportstatus;
    data['fare'] = fare;
    data['boardingpointname'] = boardingpointname;
    data['busboardingpointid'] = busboardingpointid;
    return data;
  }

  static final empty = BorderPointData(
    boardingpointname: 'Boarding point',
    busboardingpointid: '',
    fare: '',
    transportstatus: '',
  );
}
