// ignore: file_names
class GetAttachmentDetailsModel {

  GetAttachmentDetailsModel({this.status, this.message, this.data});

  GetAttachmentDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <GetAttachmentDetailsData>[];
      // ignore: inference_failure_on_untyped_parameter, avoid_dynamic_calls
      json['Data'].forEach((v) {
        data!.add(
             GetAttachmentDetailsData.fromJson(v as Map<String, dynamic>));
      });
    }
  }
  String? status;
  String? message;
  List<GetAttachmentDetailsData>? data;

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

class GetAttachmentDetailsData {

  GetAttachmentDetailsData({this.filename, this.actualname});

  GetAttachmentDetailsData.fromJson(Map<String, dynamic> json) {
    filename = json['filename'] as String?;
    actualname = json['actualname'] as String?;
  }
  String? filename;
  String? actualname;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['filename'] = filename;
    data['actualname'] = actualname;
    return data;
  }
}
