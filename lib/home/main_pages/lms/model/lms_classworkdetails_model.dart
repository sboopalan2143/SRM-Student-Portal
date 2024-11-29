// class GetClassWorkDetailsModel {
//   GetClassWorkDetailsModel({this.status, this.message, this.data});

//   GetClassWorkDetailsModel.fromJson(Map<String, dynamic> json) {
//     status = json['Status'] as String?;
//     message = json['Message'] as String?;
//     if (json['Data'] != null) {
//       data = <ClassWorkDetailsData>[];

//       for (final v in json['Data'] as List<dynamic>){
//         data!.add(ClassWorkDetailsData.fromJson(v as Map<String, dynamic>));
//       }
//     }
//   }
//   String? status;
//   String? message;
//   List<ClassWorkDetailsData>? data;

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['Status'] = status;
//     data['Message'] = message;
//     if (this.data != null) {
//       data['Data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class ClassWorkDetailsData {
//   ClassWorkDetailsData({
//     this.mcqmarksperquestions,
//     this.instructions,
//     this.classworktypeid,
//     this.cnt,
//     this.classworktypedesc,
//     this.titleTam,
//     this.topicdesc,
//     this.mcqminmarktopass,
//     this.dpstartdatetime,
//     this.mcqtimelimit,
//     this.classworkid,
//     this.stuimageattachmentid,
//     this.fieldrequirement,
//     this.topicTam,
//     this.classworkreplyid,
//     this.remarks,
//     this.dpenddatetime,
//   });

//   ClassWorkDetailsData.fromJson(Map<String, dynamic> json) {
//     mcqmarksperquestions = json['mcqmarksperquestions'] as String?;
//     instructions = json['instructions'] as String?;
//     classworktypeid = json['classworktypeid'] as String?;
//     cnt = json['cnt'] as String?;
//     classworktypedesc = json['classworktypedesc'] as String?;
//     titleTam = json['TitleTam'] as String?;
//     topicdesc = json['topicdesc'] as String?;
//     mcqminmarktopass = json['mcqminmarktopass'] as String?;
//     dpstartdatetime = json['dpstartdatetime'] as String?;
//     mcqtimelimit = json['mcqtimelimit'] as String?;
//     classworkid = json['classworkid'] as String?;
//     stuimageattachmentid = json['stuimageattachmentid'] as String?;
//     fieldrequirement = json['fieldrequirement'] as String?;
//     topicTam = json['TopicTam'] as String?;
//     classworkreplyid = json['classworkreplyid'] as String?;
//     remarks = json['remarks'] as String?;
//     dpenddatetime = json['dpenddatetime'] as String?;
//   }
//   String? mcqmarksperquestions;
//   String? instructions;
//   String? classworktypeid;
//   String? cnt;
//   String? classworktypedesc;
//   String? titleTam;
//   String? topicdesc;
//   String? mcqminmarktopass;
//   String? dpstartdatetime;
//   String? mcqtimelimit;
//   String? classworkid;
//   String? stuimageattachmentid;
//   String? fieldrequirement;
//   String? topicTam;
//   String? classworkreplyid;
//   String? remarks;
//   String? dpenddatetime;

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['mcqmarksperquestions'] = mcqmarksperquestions;
//     data['instructions'] = instructions;
//     data['classworktypeid'] = classworktypeid;
//     data['cnt'] = cnt;
//     data['classworktypedesc'] = classworktypedesc;
//     data['TitleTam'] = titleTam;
//     data['topicdesc'] = topicdesc;
//     data['mcqminmarktopass'] = mcqminmarktopass;
//     data['dpstartdatetime'] = dpstartdatetime;
//     data['mcqtimelimit'] = mcqtimelimit;
//     data['classworkid'] = classworkid;
//     data['stuimageattachmentid'] = stuimageattachmentid;
//     data['fieldrequirement'] = fieldrequirement;
//     data['TopicTam'] = topicTam;
//     data['classworkreplyid'] = classworkreplyid;
//     data['remarks'] = remarks;
//     data['dpenddatetime'] = dpenddatetime;
//     return data;
//   }
// }

class GetClassWorkDetailsModel {
  GetClassWorkDetailsModel({this.status, this.message, this.data});

  GetClassWorkDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'] as String?;
    message = json['Message'] as String?;
    if (json['Data'] != null) {
      data = <ClassWorkDetailsData>[];
      for (final v in json['Data'] as List<dynamic>) {
        data!.add(ClassWorkDetailsData.fromJson(v as Map<String, dynamic>));
      }
    }
  }
  String? status;
  String? message;
  List<ClassWorkDetailsData>? data;

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

class ClassWorkDetailsData {
  ClassWorkDetailsData({
    this.mcqmarksperquestions,
    this.instructions,
    this.classworktypeid,
    this.cnt,
    this.classworktypedesc,
    this.titleTam,
    this.topicdesc,
    this.mcqminmarktopass,
    this.dpstartdatetime,
    this.mcqtimelimit,
    this.classworkid,
    this.mcqscheduleid,
    this.conductingmarks,
    this.stuimageattachmentid,
    this.fieldrequirement,
    this.mcqnoofquestions,
    this.topicTam,
    this.classworkreplyid,
    this.remarks,
    this.dpenddatetime,
  });

  ClassWorkDetailsData.fromJson(Map<String, dynamic> json) {
    mcqmarksperquestions = json['mcqmarksperquestions'] as String?;
    instructions = json['instructions'] as String?;
    classworktypeid = json['classworktypeid'] as String?;
    cnt = json['cnt'] as String?;
    classworktypedesc = json['classworktypedesc'] as String?;
    titleTam = json['TitleTam'] as String?;
    topicdesc = json['topicdesc'] as String?;
    mcqminmarktopass = json['mcqminmarktopass'] as String?;
    dpstartdatetime = json['dpstartdatetime'] as String?;
    mcqtimelimit = json['mcqtimelimit'] as String?;
    classworkid = json['classworkid'] as String?;
    mcqscheduleid = json['mcqscheduleid'] as String?;
    conductingmarks = json['conductingmarks'] as String?;
    stuimageattachmentid = json['stuimageattachmentid'] as String?;
    fieldrequirement = json['fieldrequirement'] as String?;
    mcqnoofquestions = json['mcqnoofquestions'] as String?;
    topicTam = json['TopicTam'] as String?;
    classworkreplyid = json['classworkreplyid'] as String?;
    remarks = json['remarks'] as String?;
    dpenddatetime = json['dpenddatetime'] as String?;
  }
  String? mcqmarksperquestions;
  String? instructions;
  String? classworktypeid;
  String? cnt;
  String? classworktypedesc;
  String? titleTam;
  String? topicdesc;
  String? mcqminmarktopass;
  String? dpstartdatetime;
  String? mcqtimelimit;
  String? classworkid;
  String? mcqscheduleid;
  String? conductingmarks;
  String? stuimageattachmentid;
  String? fieldrequirement;
  String? mcqnoofquestions;
  String? topicTam;
  String? classworkreplyid;
  String? remarks;
  String? dpenddatetime;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mcqmarksperquestions'] = mcqmarksperquestions;
    data['instructions'] = instructions;
    data['classworktypeid'] = classworktypeid;
    data['cnt'] = cnt;
    data['classworktypedesc'] = classworktypedesc;
    data['TitleTam'] = titleTam;
    data['topicdesc'] = topicdesc;
    data['mcqminmarktopass'] = mcqminmarktopass;
    data['dpstartdatetime'] = dpstartdatetime;
    data['mcqtimelimit'] = mcqtimelimit;
    data['classworkid'] = classworkid;
    data['mcqscheduleid'] = mcqscheduleid;
    data['conductingmarks'] = conductingmarks;
    data['stuimageattachmentid'] = stuimageattachmentid;
    data['fieldrequirement'] = fieldrequirement;
    data['mcqnoofquestions'] = mcqnoofquestions;
    data['TopicTam'] = topicTam;
    data['classworkreplyid'] = classworkreplyid;
    data['remarks'] = remarks;
    data['dpenddatetime'] = dpenddatetime;
    return data;
  }
}
