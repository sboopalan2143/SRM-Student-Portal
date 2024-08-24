class HourwisePaidDetails {
  HourwisePaidDetails({this.status, this.message, this.data});

  HourwisePaidDetails.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <HourwiseData>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(HourwiseData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<HourwiseData>? data;

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

class HourwiseData {
  HourwiseData(
      {this.h1,
      this.h3,
      this.h5,
      this.attendancedate,
      this.h6,
      this.h7,
      this.h2});

  HourwiseData.fromJson(Map<String, dynamic> json) {
    h1 = json['h1'] as String?;
    h3 = json['h3'] as String?;
    h5 = json['h5'] as String?;
    attendancedate = json['attendancedate'] as String?;
    h6 = json['h6'] as String?;
    h7 = json['h7'] as String?;
    h2 = json['h2'] as String?;
  }
  String? h1;
  String? h3;
  String? h5;
  String? attendancedate;
  String? h6;
  String? h7;
  String? h2;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h1'] = h1;
    data['h3'] = h3;
    data['h5'] = h5;
    data['attendancedate'] = attendancedate;
    data['h6'] = h6;
    data['h7'] = h7;
    data['h2'] = h2;
    return data;
  }

  static final empty = HourwiseData(
    attendancedate: '',
    h1: '',
    h2: '',
    h3: '',
    h5: '',
    h6: '',
    h7: '',
  );
}
