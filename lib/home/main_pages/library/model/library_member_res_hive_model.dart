import 'package:hive/hive.dart';

part 'library_member_res_hive_model.g.dart';

@HiveType(typeId: 19)
class LibraryMemberHiveData {
  LibraryMemberHiveData({
    this.membercode,
    this.membertype,
    this.policyname,
    this.membername,
    this.status,
  });

  LibraryMemberHiveData.fromJson(Map<String, dynamic> json) {
    membercode = json['membercode'] as String?;
    membertype = json['membertype'] as String?;
    policyname = json['policyname'] as String?;
    membername = json['membername'] as String?;
    status = json['status'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['membercode'] = membercode;
    data['membertype'] = membertype;
    data['policyname'] = policyname;
    data['membername'] = membername;
    data['status'] = status;
    return data;
  }

  static final empty = LibraryMemberHiveData(
    membercode: '',
    membertype: '',
    policyname: '',
    membername: '',
    status: '',
  );

  @HiveField(0)
  String? membercode;

  @HiveField(1)
  String? membertype;

  @HiveField(2)
  String? policyname;

  @HiveField(3)
  String? membername;

  @HiveField(4)
  String? status;
}
