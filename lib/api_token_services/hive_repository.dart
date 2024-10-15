import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample/home/drawer_pages/profile/model/profile_hive_model.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/model/attendance_hive.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/model/cummulative_attendance_hive.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/model/exam_details_hive_model.dart';
import 'package:sample/home/main_pages/academics/subject_pages/model/subject_responce_hive_model.dart';

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
        ..registerAdapter(SubjectAttendanceHiveDataAdapter())
        ..registerAdapter(CumulativeAttendanceDataAdapter())
        ..registerAdapter(SubjectHiveDataAdapter());
      // ..registerAdapter(ExpensesCategoriesDataAdapter())
      // ..registerAdapter(UOMAdapter())
      // ..registerAdapter(CurrencyMasterDataAdapter())
      // ..registerAdapter(TimeZoneDataAdapter())
      // ..registerAdapter(RoleResourceDataAdapter())
      // ..registerAdapter(UserResourceDataAdapter())
      // ..registerAdapter(CustomerAdapter())
      // ..registerAdapter(SaleAdapter())
      // ..registerAdapter(PosSettingDataAdapter());
      initializeHiveFlag();
    }
  }
}
