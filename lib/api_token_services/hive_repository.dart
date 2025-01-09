import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample/home/drawer_pages/profile/model/profile_hive_model.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/model/attendance_hive.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/model/cummulative_attendance_hive.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/model/exam_details_hive_model.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/hourwise_model.dart/hourwise_hive_model.dart';
import 'package:sample/home/main_pages/academics/internal_marks_pages/model/internal_mark_hive_model.dart';
import 'package:sample/home/main_pages/academics/subject_pages/model/subject_responce_hive_model.dart';
import 'package:sample/home/main_pages/calendar/model/calendar_hive_model.dart';
import 'package:sample/home/main_pages/fees/model.dart/finance_response_hive_model.dart';
import 'package:sample/home/main_pages/fees/model.dart/get_fees_details_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_category_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_subtype_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_type_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/studentwise_grievance_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_after_register_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_before_register_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_details_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_leave_application_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/room_type_hive_model.dart';
import 'package:sample/home/main_pages/library/model/library_member_res_hive_model.dart';
import 'package:sample/home/main_pages/library/model/library_search_hive_model.dart';
import 'package:sample/home/main_pages/library/model/library_transaction_res_hive_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_classworkdetails_hive_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_getAttachmentDetails_hive_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_getSubject_hive_model.dart';
import 'package:sample/home/main_pages/lms/model/lms_gettitle_hive_model.dart';
import 'package:sample/home/main_pages/transport/model/boarding_point_hive_model.dart';
import 'package:sample/home/main_pages/transport/model/route_hive_model.dart';
import 'package:sample/home/main_pages/transport/model/transport_after_reg_hive_model.dart';
import 'package:sample/home/main_pages/transport/model/transport_register_hive_model.dart';
import 'package:sample/home/main_pages/transport/model/transport_status_hive_model.dart';

class HiveRepository {
  static bool initialized = false;

  static void initializeHiveFlag() => initialized = !initialized;

  static Future<void> initializeHive() async {
    if (!initialized) {
      final storePath = await getApplicationDocumentsDirectory();
      final directory = Directory(storePath.path);
      Hive
        ..init(directory.path)
        ..registerAdapter(ProfileHiveDataAdapter())
        ..registerAdapter(ExamDetailsHiveDataAdapter())
        ..registerAdapter(AttendanceHiveDataAdapter())
        ..registerAdapter(CumulativeAttendanceHiveDataAdapter())
        ..registerAdapter(SubjectHiveDataAdapter())
        ..registerAdapter(HourwiseHiveDataAdapter())
        ..registerAdapter(InternalMarkHiveDataAdapter())
        ..registerAdapter(FinanceHiveDataAdapter())
        // ..registerAdapter(GetFeesHiveDataAdapter())
        ..registerAdapter(GrievanceCategoryHiveDataAdapter())
        ..registerAdapter(GrievanceSubTypeHiveDataAdapter())
        ..registerAdapter(GrievanceTypeHiveDataAdapter())
        ..registerAdapter(StudentWiseHiveDataAdapter())
        ..registerAdapter(HostelAfterRegisterHiveDataAdapter())
        // ..registerAdapter(HostelBeforeRegisterHiveDataAdapter())
        ..registerAdapter(GetHostelHiveDataAdapter())
        ..registerAdapter(HostelHiveDataAdapter())
        ..registerAdapter(HostelLeaveHiveDataAdapter())
        ..registerAdapter(RoomTypeHiveDataAdapter())
        ..registerAdapter(LibraryMemberHiveDataAdapter())
        ..registerAdapter(BookSearchHiveDataAdapter())
        ..registerAdapter(LibraryTransactionHiveDataAdapter())
        ..registerAdapter(ClassWorkDetailsHiveDataAdapter())
        ..registerAdapter(GetAttachmentDetailsHiveDataAdapter())
        ..registerAdapter(LmsSubjectHiveDataAdapter())
        ..registerAdapter(LmsGetTitleHiveDataAdapter())
        ..registerAdapter(BoardingPointHiveDataAdapter())
        ..registerAdapter(RouteDetailsHiveDataAdapter())
        ..registerAdapter(TransportAfterRegisterHiveDataAdapter())
        ..registerAdapter(TransportRegisterHiveDataAdapter())
        ..registerAdapter(TransportStatusHiveDataAdapter())
        ..registerAdapter(CalendarHiveModelDataAdapter());

      initializeHiveFlag();
    }
  }
}
