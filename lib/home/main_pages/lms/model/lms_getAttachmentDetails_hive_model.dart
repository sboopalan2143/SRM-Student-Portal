import 'package:hive/hive.dart';

part 'lms_getAttachmentDetails_hive_model.g.dart';

@HiveType(typeId: 23)
class GetAttachmentDetailsHiveData {
  GetAttachmentDetailsHiveData({this.filename, this.actualname});

  GetAttachmentDetailsHiveData.fromJson(Map<String, dynamic> json) {
    filename = json['filename'] as String?;
    actualname = json['actualname'] as String?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['filename'] = filename;
    data['actualname'] = actualname;
    return data;
  }

  @HiveField(0)
  String? filename;

  @HiveField(1)
  String? actualname;
  
}
