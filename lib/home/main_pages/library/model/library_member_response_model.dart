class LibraryMemberResponseModel {
  LibraryMemberResponseModel({this.status, this.message, this.data});

  LibraryMemberResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <LibraryMemberData>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(LibraryMemberData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<LibraryMemberData>? data;

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

class LibraryMemberData {
  LibraryMemberData({
    this.membercode,
    this.membertype,
    this.policyname,
    this.membername,
    this.status,
  });

  LibraryMemberData.fromJson(Map<String, dynamic> json) {
    membercode = json['membercode'] as String?;
    membertype = json['membertype'] as String?;
    policyname = json['policyname'] as String?;
    membername = json['membername'] as String?;
    status = json['status'] as String?;
  }
  String? membercode;
  String? membertype;
  String? policyname;
  String? membername;
  String? status;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['membercode'] = membercode;
    data['membertype'] = membertype;
    data['policyname'] = policyname;
    data['membername'] = membername;
    data['status'] = status;
    return data;
  }

  static final empty = LibraryMemberData(
    membercode: '',
    membertype: '',
    policyname: '',
    membername: '',
    status: '',
  );
}
