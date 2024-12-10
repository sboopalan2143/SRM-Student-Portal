import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/change_password/riverpod/change_password_state.dart';
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
import 'package:sample/login/riverpod/login_state.dart';
import 'package:sample/network/riverpod/network_state.dart';
import 'package:sample/notification.dart';
import 'package:sample/theme_3/attendance/attendance_home_theme3.dart';
import 'package:sample/theme_3/calendar/calender_home_theme3.dart';
import 'package:sample/theme_3/cummulative/cummulative_home_theme3.dart';
import 'package:sample/theme_3/exam/exam_home_theme3.dart';
import 'package:sample/theme_3/fees/fees_home_theme3.dart';
import 'package:sample/theme_3/grievances/grievances_home_theme3.dart';
import 'package:sample/theme_3/hostel/hostel_home_theme3.dart';
import 'package:sample/theme_3/hourwise_attendance/hourwise_home_theme3.dart';
import 'package:sample/theme_3/internal_marks/internal_home_theme3.dart';
import 'package:sample/theme_3/library/library_page_home_theme3.dart';
import 'package:sample/theme_3/lms/lms_home_theme3.dart';
import 'package:sample/theme_3/subjects/subjects_home_theme3.dart';
import 'package:sample/theme_3/transport/transport_home_theme3.dart';

class HomePageTheme3 extends ConsumerStatefulWidget {
  const HomePageTheme3({super.key});

  @override
  ConsumerState createState() => _HomePageTheme3State();
}

class _HomePageTheme3State extends ConsumerState<HomePageTheme3>
    with WidgetsBindingObserver {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      SystemChrome.setSystemUIOverlayStyle(
        StatusBarNavigationBarDesigns.statusBarNavigationBarDesign,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _initialProcess();
    Alerts.checkForAppUpdate(context: context, forcefully: false);
  }

  Future<void> _initialProcess() async {
    await TokensManagement.getStudentId();
    await ref.read(loginProvider.notifier).getAppVersion();

    /// Remove the command line after firebase setup
    await TokensManagement.getPhoneToken();
    await TokensManagement.getAppDeviceInfo();

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

    Container(
      width: 200,
      height: 200,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.green], // Gradient colors
          begin: Alignment.topLeft, // Start point
          end: Alignment.bottomRight, // End point
        ),
      ),
    );
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
    ref
      ..listen(networkProvider, (previous, next) {
        if (previous!.connectivityResult == ConnectivityResult.none &&
            next.connectivityResult != ConnectivityResult.none) {}
      })
      ..listen(changePasswordProvider, (previous, next) {
        if (next is ChangePasswordStateSuccessful) {
          if (next.message == 'Password Changed Successfuly') {
            _showToast(context, next.message, AppColors.greenColorTheme3);
          } else {
            _showToast(context, next.message, AppColors.redColor);
          }
        } else if (next is ChangePasswordStateError) {
          _showToast(context, next.message, AppColors.redColor);
        }
      });
    return Scaffold(
        backgroundColor: AppColors.primaryColorTheme3, body: menuScreen());
  }

  Widget menuScreen() {
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    RouteDesign(
                      route: const LibraryPageHomeTheme3(),
                    ),
                  );
                },
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  color: AppColors.whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/images/librarytheme3.svg',
                        color: AppColors.primaryColorTheme3,
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      Text(
                        'Library',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor.withOpacity(0.5),
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
                      route: const ExamHomeTheme3(),
                    ),
                  );
                },
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  color: AppColors.whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/images/examdetailstheme3.svg',
                        color: AppColors.primaryColorTheme3,
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      Text(
                        'Exam Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor.withOpacity(0.5),
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
                      route: const AttendanceHomeTheme3(),
                    ),
                  );
                },
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  color: AppColors.whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/images/attendancetheme3.svg',
                        color: AppColors.primaryColorTheme3,
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      Text(
                        'Attendance',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor.withOpacity(0.5),
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
                      route: const HourwiseHomeTheme3(),
                    ),
                  );
                },
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  color: AppColors.whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/images/hourattendancetheme3.svg',
                        color: AppColors.primaryColorTheme3,
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      Text(
                        'Hour Attendance',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor.withOpacity(0.5),
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
                      route: const CummulativeHomeTheme3(),
                    ),
                  );
                },
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  color: AppColors.whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/images/cumulativeattendancetheme3.svg',
                        color: AppColors.primaryColorTheme3,
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      Text(
                        'Cumulative Attendance',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor.withOpacity(0.5),
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
                      route: const SubjectsHomeTheme3(),
                    ),
                  );
                },
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  color: AppColors.whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/images/subjectstheme3.svg',
                        color: AppColors.primaryColorTheme3,
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      Text(
                        'Subjects',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor.withOpacity(0.5),
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
                      route: const LMSHomeTheme3(),
                    ),
                  );
                },
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  color: AppColors.whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/images/lmstheme3.svg',
                        color: AppColors.primaryColorTheme3,
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      Text(
                        'LMS',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor.withOpacity(0.5),
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
                      route: const HostelHomeTheme3(),
                    ),
                  );
                },
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  color: AppColors.whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/images/hosteltheme3.svg',
                        color: AppColors.primaryColorTheme3,
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      Text(
                        'Hostel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor.withOpacity(0.5),
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
                      route: const FeesHomeTheme3(),
                    ),
                  );
                },
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  color: AppColors.whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/images/feestheme3.svg',
                        color: AppColors.primaryColorTheme3,
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      Text(
                        'Fees',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor.withOpacity(0.5),
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
                      route: const GrievancesHomeTheme3(),
                    ),
                  );
                },
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  color: AppColors.whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/images/grievancestheme3.svg',
                        color: AppColors.primaryColorTheme3,
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      Text(
                        'Grievances',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor.withOpacity(0.5),
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
                      route: const CalendarHomeTheme3(),
                    ),
                  );
                },
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  color: AppColors.whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        size: MediaQuery.of(context).size.height / 12,
                        color: AppColors.primaryColorTheme3,
                      ),
                      Text(
                        'Calendar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor.withOpacity(0.5),
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
                      route: const InternalMarksHomeTheme3(),
                    ),
                  );
                },
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  color: AppColors.whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.numbers_outlined,
                        size: MediaQuery.of(context).size.height / 12,
                        color: AppColors.primaryColorTheme3,
                      ),
                      Text(
                        'Internal Marks',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor.withOpacity(0.5),
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
                      route: const TransportHomeTheme3(),
                    ),
                  );
                },
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  color: AppColors.whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/images/transporttheme3.svg',
                        color: AppColors.primaryColorTheme3,
                        height: MediaQuery.of(context).size.height / 12,
                      ),
                      Text(
                        'Transport',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //dummy block
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 160,
                  width: MediaQuery.of(context).size.width / 2.5,
                  padding: const EdgeInsets.all(
                    15,
                  ),
                  color: AppColors.primaryColorTheme3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.numbers_outlined,
                        size: MediaQuery.of(context).size.height / 12,
                        color: AppColors.primaryColorTheme3,
                      ),
                      Text(
                        'Transport',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColorTheme3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showToast(BuildContext context, String message, Color color) {
    showToast(
      message,
      context: context,
      backgroundColor: color,
      axis: Axis.horizontal,
      alignment: Alignment.centerLeft,
      position: StyledToastPosition.center,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      ),
      toastHorizontalMargin: MediaQuery.of(context).size.width / 3,
    );
  }
}
