import 'package:hive/hive.dart';

part 'library_transaction_res_hive_model.g.dart';

@HiveType(typeId: 21)
class LibraryTransactionHiveData {
  LibraryTransactionHiveData({
    this.membercode,
    this.membertype,
    this.policyname,
    this.membername,
    this.status,
    this.accessionno,
    this.returndate,
    this.duedate,
    this.fineamount,
    this.title,
    this.issuedate,
  });
  LibraryTransactionHiveData.fromJson(Map<String, dynamic> json) {
    membercode = json['membercode'] as String?;
    membertype = json['membertype'] as String?;
    policyname = json['policyname'] as String?;
    membername = json['membername'] as String?;
    status = json['status'] as String?;
    accessionno = json['accessionno'] as String?;
    returndate = json['returndate'] as String?;
    duedate = json['duedate'] as String?;
    fineamount = json['fineamount'] as String?;
    title = json['title'] as String?;
    issuedate = json['issuedate'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['membercode'] = membercode;
    data['membertype'] = membertype;
    data['policyname'] = policyname;
    data['membername'] = membername;
    data['status'] = status;
    data['accessionno'] = accessionno;
    data['returndate'] = returndate;
    data['duedate'] = duedate;
    data['fineamount'] = fineamount;
    data['title'] = title;
    data['issuedate'] = issuedate;
    return data;
  }

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

  @HiveField(5)
  String? accessionno;

  @HiveField(6)
  String? returndate;

  @HiveField(7)
  String? duedate;

  @HiveField(8)
  String? fineamount;

  @HiveField(9)
  String? title;

  @HiveField(10)
  String? issuedate;
}
