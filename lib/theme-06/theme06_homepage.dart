import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/designs/alerts_design.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/designs/navigation_style.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/profile/model/profile_hive_model.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/model/attendance_hive.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/riverpod/attendance_state.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/model/cummulative_attendance_hive.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/riverpod/cumulative_attendance_state.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/model/exam_details_hive_model.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/hourwise_model.dart/hourwise_hive_model.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/riverpod/hourwise_attendence_state.dart';
import 'package:sample/home/main_pages/academics/internal_marks_pages/model/internal_mark_hive_model.dart';
import 'package:sample/home/main_pages/academics/internal_marks_pages/riverpod/internal_marks_state.dart';
import 'package:sample/home/main_pages/academics/subject_pages/model/subject_responce_hive_model.dart';
import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_state.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_category_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_subtype_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_type_hive_model.dart';
import 'package:sample/home/main_pages/grievances/riverpod/grievance_state.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:sample/notification.dart';
import 'package:sample/theme-02/drawer_page/change_password_theme02.dart';
import 'package:sample/theme-02/drawer_page/theme02_profile_screen.dart';
import 'package:sample/theme-02/login/theme02_login_screen.dart';
import 'package:sample/theme-02/mainscreens/academics/attendance.dart';
import 'package:sample/theme-02/mainscreens/academics/cumulative_attendance.dart';
import 'package:sample/theme-02/mainscreens/academics/exam_details.dart';
import 'package:sample/theme-02/mainscreens/academics/hour_attendance.dart';
import 'package:sample/theme-02/mainscreens/academics/internal_marks.dart';
import 'package:sample/theme-02/mainscreens/academics/subject.dart';
import 'package:sample/theme-02/mainscreens/calendar_screen.dart';
import 'package:sample/theme-02/mainscreens/fees_screen_theme01.dart';
import 'package:sample/theme-02/mainscreens/grievances/grievances_screen.dart';
import 'package:sample/theme-02/mainscreens/hostel/theme_02_hostel_register.dart';
import 'package:sample/theme-02/mainscreens/library/library_screen.dart';
import 'package:sample/theme-02/mainscreens/lms/lms_subject_screen.dart';
import 'package:sample/theme-02/mainscreens/transport/transport_register.dart';
import 'package:sample/theme-06/drawer_page/change_password_theme06.dart';
import 'package:sample/theme-06/drawer_page/theme06_profile_screen.dart';
import 'package:sample/theme-06/mainscreens/academics/attendance.dart';
import 'package:sample/theme-06/mainscreens/academics/cumulative_attendance.dart';
import 'package:sample/theme-06/mainscreens/academics/exam_details.dart';
import 'package:sample/theme-06/mainscreens/academics/hour_attendance.dart';
import 'package:sample/theme-06/mainscreens/academics/internal_marks.dart';
import 'package:sample/theme-06/mainscreens/academics/subject.dart';
import 'package:sample/theme-06/mainscreens/calendar_screen.dart';
import 'package:sample/theme-06/mainscreens/fees_screen_theme01.dart';
import 'package:sample/theme-06/mainscreens/grievances/grievances_screen.dart';
import 'package:sample/theme-06/mainscreens/hostel/theme_06_hostel_register.dart';
import 'package:sample/theme-06/mainscreens/library/library_screen.dart';
import 'package:sample/theme-06/mainscreens/lms/lms_subject_screen.dart';
import 'package:sample/theme-06/mainscreens/transport/transport_register.dart';

class Theme06Homepage extends ConsumerStatefulWidget {
  const Theme06Homepage({super.key});

  @override
  ConsumerState createState() => _Theme06HomepageState();
}

class _Theme06HomepageState extends ConsumerState<Theme06Homepage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    _initialProcess();
    Alerts.checkForAppUpdate(context: context, forcefully: false);
  }

  Future<void> _initialProcess() async {
    await TokensManagement.getStudentId();
    await ref.read(loginProvider.notifier).getAppVersion();
    await TokensManagement.getPhoneToken();
    await TokensManagement.getAppDeviceInfo();
    await TokensManagement.getTheme();

//>>>PROFILE

    final profile = await Hive.openBox<ProfileHiveData>('profile');
    if (profile.isEmpty) {
      await ref.read(profileProvider.notifier).getProfileApi(
            ref.read(
              encryptionProvider.notifier,
            ),
          );
      await ref.read(profileProvider.notifier).getProfileHive('');
    }
    await profile.close();

//ACADEMICS

//>>>Attendance
    final attendance = await Hive.openBox<AttendanceHiveData>(
      'Attendance',
    );
    if (attendance.isEmpty) {
      await ref.read(attendanceProvider.notifier).getAttendanceDetails(
            ref.read(
              encryptionProvider.notifier,
            ),
          );
      await ref.read(attendanceProvider.notifier).getHiveAttendanceDetails('');
    }
    await attendance.close();

//>>>Cummulative Attendance

    final cummulativeAttendance =
        await Hive.openBox<CumulativeAttendanceHiveData>(
      'cumulativeattendance',
    );
    if (cummulativeAttendance.isEmpty) {
      await ref
          .read(cummulativeAttendanceProvider.notifier)
          .getCummulativeAttendanceDetails(
            ref.read(
              encryptionProvider.notifier,
            ),
          );
      await ref
          .read(cummulativeAttendanceProvider.notifier)
          .getHiveCummulativeDetails('');
    }
    await cummulativeAttendance.close();

//>>>Exam Details

    final examDetails = await Hive.openBox<ExamDetailsHiveData>('examDetails');
    if (examDetails.isEmpty) {
      await ref.read(examDetailsProvider.notifier).getExamDetailsApi(
            ref.read(
              encryptionProvider.notifier,
            ),
          );
      await ref.read(examDetailsProvider.notifier).getHiveExamDetails('');
    }
    await examDetails.close();

//>>>Hourwise Attendance

    final hourwiseAttendance = await Hive.openBox<HourwiseHiveData>(
      'hourwisedata',
    );
    if (hourwiseAttendance.isEmpty) {
      await ref.read(hourwiseProvider.notifier).gethourwiseDetails(
            ref.read(
              encryptionProvider.notifier,
            ),
          );
      await ref.read(hourwiseProvider.notifier).getHiveHourwise('');
    }
    await hourwiseAttendance.close();

//>>>Internal Marks

    final internalMarks = await Hive.openBox<InternalMarkHiveData>(
      'internalmarkdata',
    );
    if (internalMarks.isEmpty) {
      await ref.read(internalMarksProvider.notifier).getInternalMarksDetails(
            ref.read(
              encryptionProvider.notifier,
            ),
          );
      await ref.read(internalMarksProvider.notifier).getHiveInternalMarks('');
    }
    await internalMarks.close();

//>>>Subject

    final subjects = await Hive.openBox<SubjectHiveData>('subjecthive');
    if (subjects.isEmpty) {
      await ref
          .read(subjectProvider.notifier)
          .getSubjectDetails(ref.read(encryptionProvider.notifier));
      await ref.read(subjectProvider.notifier).getHiveSubjectDetails('');
    }
    await subjects.close();

    //GRIEVANCES

    final grievanceCategoryData = await Hive.openBox<GrievanceCategoryHiveData>(
      'grievanceCategoryData',
    );
    if (grievanceCategoryData.isEmpty) {
      await ref.read(grievanceProvider.notifier).getGrievanceCategoryDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref
          .read(grievanceProvider.notifier)
          .getHiveGrievanceCategoryDetails('');
    }
    await grievanceCategoryData.close();

    final grievanceSubTypeData = await Hive.openBox<GrievanceSubTypeHiveData>(
      'grievanceSubTypeData',
    );
    if (grievanceSubTypeData.isEmpty) {
      await ref.read(grievanceProvider.notifier).getGrievanceSubTypeDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref
          .read(grievanceProvider.notifier)
          .getHiveGrievanceSubTypeDetails('');
    }
    await grievanceSubTypeData.close();

    final grievanceTypeData = await Hive.openBox<GrievanceTypeHiveData>(
      'grievanceTypeData',
    );
    if (grievanceTypeData.isEmpty) {
      await ref.read(grievanceProvider.notifier).getGrievanceTypeDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref
          .read(grievanceProvider.notifier)
          .getHiveGrievanceTypeDetails('');
    }
    await grievanceTypeData.close();
  }

  Future<void> showNotification(RemoteMessage message) async {
    await AppNotification.createNotification(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      networkImagePath: message.data['image'] as String?,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final provider = ref.watch(transportProvider);
    // log(provider.transportAfterRegisterDetails!.regconfig)
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.theme06primaryColor,
                AppColors.theme06primaryColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              'Home',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme06ExamDetailsPageTheme(),
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.lightAshColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/examtdetailstheme06png.png',
                          height: MediaQuery.of(context).size.height / 14,
                        ),
                        // SvgPicture.asset(
                        //   'assets/images/examtdetailstheme06.svg',
                        //   color: AppColors.whiteColor,
                        //   height: MediaQuery.of(context).size.height / 16,
                        // ),
                        const Text(
                          'Exam Details',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme06SubjectPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.lightAshColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Image.asset(
                        //   'assets/images/subjecttheme06.png',
                        //   height: MediaQuery.of(context).size.height / 12,
                        // ),
                        Image.asset(
                          'assets/images/subjecttheme06png.png',
                          height: MediaQuery.of(context).size.height / 14,
                        ),
                        const Text(
                          'Subjects',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme06InternalMarksPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.lightAshColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/internalmarksthemeicon06png.png',
                          height: MediaQuery.of(context).size.height / 14,
                        ),
                        const Text(
                          'Internal Marks',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme06HourAttendancePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.lightAshColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/hourattenthemeicon06png.png',
                          height: MediaQuery.of(context).size.height / 14,
                        ),
                        const Text(
                          'Hour Attendance',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme06CumulativeAttendancePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.lightAshColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/cumulativeattetheme06png.png',
                          height: MediaQuery.of(context).size.height / 14,
                        ),
                        const Text(
                          'Cumulative Attendance',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme06AttendancePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.lightAshColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/attendancetheme08png.png',
                          height: MediaQuery.of(context).size.height / 14,
                        ),
                        const Text(
                          'Attendance',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme06LmsHomePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.lightAshColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/lmsthmem07png.png',
                          height: MediaQuery.of(context).size.height / 14,
                        ),
                        const Text(
                          'LMS',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme06RegistrationPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.lightAshColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/hostelthemeicon06png.png',
                          height: MediaQuery.of(context).size.height / 14,
                        ),
                        const Text(
                          'Hostel',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme06FeesPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.lightAshColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/feesthemeicon06png.png',
                          height: MediaQuery.of(context).size.height / 14,
                        ),
                        const Text(
                          'Fees',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme06GrievanceReportPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.lightAshColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/grievancesthemeicon06png.png',
                          height: MediaQuery.of(context).size.height / 14,
                        ),
                        const Text(
                          'Grievances',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme06CalendarPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.lightAshColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/attendancetheme08png.png',
                          height: MediaQuery.of(context).size.height / 14,
                        ),
                        const Text(
                          'Calendar',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme06LibraryPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: AppColors.lightAshColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/librarythemeicon06png.png',
                          height: MediaQuery.of(context).size.height / 14,
                        ),
                        const Text(
                          'Library',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // if (provider.transportAfterRegisterDetails!.regconfig == '1')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme06TransportRegisterPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.lightAshColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/transporttheme06png.png',
                          height: MediaQuery.of(context).size.height / 14,
                        ),
                        const Text(
                          'Transport',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme06ChangePasswordPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: AppColors.lightAshColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/changepasswordthme06.png',
                          height: MediaQuery.of(context).size.height / 14,
                        ),
                        const Text(
                          'Change Password',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme06ProfilePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.lightAshColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/profiletheme06.png',
                          height: MediaQuery.of(context).size.height / 14,
                        ),
                        const Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // if (provider.transportAfterRegisterDetails!.regconfig == '1')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    ref.read(mainProvider.notifier).setNavString('Logout');
                    TokensManagement.clearSharedPreference();
                    Navigator.pushAndRemoveUntil(
                      context,
                      RouteDesign(
                        route: const Theme02LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: AppColors.lightAshColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/logouttheme06.png',
                          height: MediaQuery.of(context).size.height / 14,
                        ),
                        const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ref.read(mainProvider.notifier).setNavString('Logout');
                    TokensManagement.clearSharedPreference();
                    Navigator.pushAndRemoveUntil(
                      context,
                      RouteDesign(
                        route: const Theme02LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.all(15),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ref.read(mainProvider.notifier).setNavString('Logout');
                    TokensManagement.clearSharedPreference();
                    Navigator.pushAndRemoveUntil(
                      context,
                      RouteDesign(
                        route: const Theme02LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3.5,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class GradientCard extends StatelessWidget {
  const GradientCard({super.key, required this.data});
  final CardData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.theme02primaryColor,
                    AppColors.theme02secondaryColor1,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Center(
                child: Icon(
                  data.icon,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardData {
  CardData({
    required this.icon,
    required this.title,
    required this.progress,
    required this.progressText,
  });
  final IconData icon;
  final String title;
  final double progress;
  final String progressText;
}
