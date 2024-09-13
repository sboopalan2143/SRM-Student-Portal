class GetHostelDetailsModel {
  GetHostelDetailsModel({this.status, this.message, this.data});

  GetHostelDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <GetHostelData>[];
      json['Data'].forEach((v) {
        data!.add(new GetHostelData.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  String? status;
  String? message;
  List<GetHostelData>? data;

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

class GetHostelData {
  String? hostelname;
  String? roomname;
  String? academicyear;
  String? alloteddate;
  String? roomtype;

  GetHostelData(
      {this.hostelname,
      this.roomname,
      this.academicyear,
      this.alloteddate,
      this.roomtype});

  GetHostelData.fromJson(Map<String, dynamic> json) {
    hostelname = json['hostelname'] as String?;
    roomname = json['roomname'] as String?;
    academicyear = json['academicyear'] as String?;
    alloteddate = json['alloteddate'] as String?;
    roomtype = json['roomtype'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['hostelname'] = hostelname;
    data['roomname'] = roomname;
    data['academicyear'] = academicyear;
    data['alloteddate'] = alloteddate;
    data['roomtype'] = roomtype;
    return data;
  }

  static final empty = GetHostelData(
    hostelname: '',
    academicyear: '',
    alloteddate: '',
    roomname: '',
    roomtype: '',
  );
}
