// ignore: file_names
class GetStudentAttachmentDetailsModel {
  GetStudentAttachmentDetailsModel({this.status, this.message, this.data});

  GetStudentAttachmentDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <GetStudentAttachmentDetailsData>[];
      // ignore: inference_failure_on_untyped_parameter, avoid_dynamic_calls
      json['Data'].forEach((v) {
        data!.add(GetStudentAttachmentDetailsData.fromJson(
            v as Map<String, dynamic>,),);
      });
    }
  }
  String? status;
  String? message;
  List<GetStudentAttachmentDetailsData>? data;

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

class GetStudentAttachmentDetailsData {
  GetStudentAttachmentDetailsData(
      {this.filename, this.actualname, this.imageBytes,});

  GetStudentAttachmentDetailsData.fromJson(Map<String, dynamic> json) {
    filename = json['filename'] as String?;
    actualname = json['actualname'] as String?;
    imageBytes = json['imagedata'] as String?;
  }
  String? filename;
  String? actualname;
  String? imageBytes;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['filename'] = filename;
    data['actualname'] = actualname;
    data['imagedata'] = imageBytes;
    return data;
  }
}
