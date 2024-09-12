class RoomTypeModel {
  RoomTypeModel({this.status, this.message, this.data});

  RoomTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <RoomTypeData>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(RoomTypeData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<RoomTypeData>? data;

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

class RoomTypeData {
  RoomTypeData({
    this.applicationfee,
    this.messfees,
    this.roomtypeid,
    this.cautiondepositfee,
    this.hostelstatus,
    this.roomtypename,
  });

  RoomTypeData.fromJson(Map<String, dynamic> json) {
    applicationfee = json['applicationfee'] as String?;
    messfees = json['messfees'] as String?;
    roomtypeid = json['roomtypeid'] as String?;
    cautiondepositfee = json['cautiondepositfee'] as String?;
    hostelstatus = json['hostelstatus'] as String?;
    roomtypename = json['roomtypename'] as String?;
  }
  String? applicationfee;
  String? messfees;
  String? roomtypeid;
  String? cautiondepositfee;
  String? hostelstatus;
  String? roomtypename;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['applicationfee'] = applicationfee;
    data['messfees'] = messfees;
    data['roomtypeid'] = roomtypeid;
    data['cautiondepositfee'] = cautiondepositfee;
    data['hostelstatus'] = hostelstatus;
    data['roomtypename'] = roomtypename;
    return data;
  }

  static final empty = RoomTypeData(
    applicationfee: '',
    messfees: '',
    roomtypeid: '',
    cautiondepositfee: '',
    hostelstatus: '',
    roomtypename: '',
  );
}
