import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/change_password/riverpod/change_password_state.dart';
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
import 'package:sample/home/main_pages/academics/screens/academics.dart';
import 'package:sample/home/main_pages/academics/subject_pages/model/subject_responce_hive_model.dart';
import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_state.dart';
import 'package:sample/home/main_pages/calendar/screens/calendar_screen.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';
import 'package:sample/home/main_pages/fees/screens/fees.dart';
import 'package:sample/home/main_pages/grievances/screens/grievances.dart';
import 'package:sample/home/main_pages/hostel/screens/hostel.dart';
import 'package:sample/home/main_pages/library/screens/library.dart';
import 'package:sample/home/main_pages/lms/screens/lms_home_screen.dart';
import 'package:sample/home/main_pages/transport/screens/transport.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:sample/network/riverpod/network_state.dart';
import 'package:sample/notification.dart';

class HomePage2 extends ConsumerStatefulWidget {
  const HomePage2({super.key});

  @override
  ConsumerState createState() => _HomePage2State();
}

class _HomePage2State extends ConsumerState<HomePage2>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
    final width = MediaQuery.of(context).size.width;
    final providerProfile = ref.watch(profileProvider);
    final base64Image = '${providerProfile.profileDataHive.studentphoto}';
    final imageBytes = base64Decode(base64Image);
    ref
      ..listen(networkProvider, (previous, next) {
        if (previous!.connectivityResult == ConnectivityResult.none &&
            next.connectivityResult != ConnectivityResult.none) {}
      })
      ..listen(changePasswordProvider, (previous, next) {
        if (next is ChangePasswordStateSuccessful) {
          if (next.message == 'Password Changed Successfuly') {
            _showToast(context, next.message, AppColors.greenColor);
          } else {
            _showToast(context, next.message, AppColors.redColor);
          }
        } else if (next is ChangePasswordStateError) {
          _showToast(context, next.message, AppColors.redColor);
        }
      });
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/wavehome.svg',
            fit: BoxFit.fill,
            color: AppColors.primaryColor,
            width: double.infinity,
            colorBlendMode: BlendMode.srcOut,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 30),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              iconSize: 35,
                              color: AppColors.whiteColor,
                              icon: const Icon(Icons.menu),
                              onPressed: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                            ),
                            if (imageBytes == '' && imageBytes.isEmpty)
                              const CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.whiteColor,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'assets/images/profile.png',
                                  ),
                                  radius: 48,
                                ),
                              ),
                            if (imageBytes != '' && imageBytes.isNotEmpty)
                              SizedBox(
                                height: 45,
                                width: 45,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.memory(
                                    imageBytes,
                                    fit: BoxFit.cover, // Adjust fit as needed
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'Hello, ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          // Text(
                          //   'Student',
                          //   style: TextStyle(
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.bold,
                          //     color: AppColors.whiteColor,
                          //   ),
                          // ),
                          Text(
                            TokensManagement.studentName == ''
                                ? '-'
                                : TokensManagement.studentName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 30,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Welcome to ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          Text(
                            'SRM Portal',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 25,
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  RouteDesign(
                                    route: const AcademicsPage(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 110,
                                width: width < 480
                                    ? 400 // For very small screens
                                    : width < 1024
                                        ? 650 // For medium screens
                                        : 400, // For large screens

                                padding: const EdgeInsets.all(
                                  15,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue[50],
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/GraduationCap.png',
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10,
                                      ),
                                      // Image.asset(
                                      //   'assets/images/Academic2.png',
                                      //   height:
                                      //       MediaQuery.of(context).size.height /
                                      //           10,
                                      //   width:
                                      //       MediaQuery.of(context).size.width /
                                      //           4,
                                      // ),
                                      // Image.asset(
                                      //   'assets/images/Academic3.png',
                                      //   height:
                                      //       MediaQuery.of(context).size.height /
                                      //           10,
                                      //   width:
                                      //       MediaQuery.of(context).size.width /
                                      //           4,
                                      // ),
                                      // Image.asset(
                                      //   'assets/images/Academic4.png',
                                      //   height:
                                      //       MediaQuery.of(context).size.height /
                                      //           10,
                                      //   width:
                                      //       MediaQuery.of(context).size.width /
                                      //           4,
                                      // ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Academics',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      RouteDesign(
                                        route: const LibraryPage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    // height: 120,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: const EdgeInsets.all(
                                      15,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.homepagecolor1,
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/books.png',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              12,
                                        ),
                                        // Image.asset(
                                        //   'assets/images/Library1.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       13,
                                        // ),
                                        // Image.asset(
                                        //   'assets/images/Library3.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        // Image.asset(
                                        //   'assets/images/Library2.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Library',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[800],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(feesProvider.notifier)
                                        .setFeesNavString('Online Trans');
                                    Navigator.push(
                                      context,
                                      RouteDesign(
                                        route: const FeesPage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    // height: 120,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: const EdgeInsets.all(
                                      15,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.homepagecolor2,
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/coin.png',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              12,
                                        ),
                                        // Image.asset(
                                        //   'assets/images/fees2.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        // Image.asset(
                                        //   'assets/images/fees1.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        // Image.asset(
                                        //   'assets/images/fees4.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Fees',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[800],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      RouteDesign(
                                        route: const HostelPage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    // height: 120,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: const EdgeInsets.all(
                                      15,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.homepagecolor3,
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/hostelimage.png',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              12,
                                        ),
                                        // Image.asset(
                                        //   'assets/images/hostel2.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        // Image.asset(
                                        //   'assets/images/hostel4.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        // Image.asset(
                                        //   'assets/images/hostel3.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Hostel',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[800],
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
                                        route: const GrievanceReportPage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    // height: 120,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: const EdgeInsets.all(
                                      15,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.homepagecolor4,
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/pencil.png',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              12,
                                        ),
                                        // Image.asset(
                                        //   'assets/images/grievance1.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        // Image.asset(
                                        //   'assets/images/grievance3.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        // Image.asset(
                                        //   'assets/images/grievance2.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Grievances',
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[800],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      RouteDesign(
                                        route: const TransportTransactionPage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    // height: 120,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: const EdgeInsets.all(
                                      15,
                                    ),
                                    decoration: BoxDecoration(
                                      // color: Colors.lightGreenAccent,
                                      color: AppColors.homepagecolor2,
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/Bus.png',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              12,
                                        ),
                                        // Image.asset(
                                        //   'assets/images/bus2.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        // Image.asset(
                                        //   'assets/images/bus3.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        // Image.asset(
                                        //   'assets/images/bus1.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Transport',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[800],
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
                                        route: const LmsHomePage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    // height: 120,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: const EdgeInsets.all(
                                      15,
                                    ),
                                    decoration: BoxDecoration(
                                      // color: Colors.lightGreenAccent,
                                      color: AppColors.homepagecolor3,
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/LMS.png',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              12,
                                        ),
                                        // Image.asset(
                                        //   'assets/images/bus2.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        // Image.asset(
                                        //   'assets/images/bus3.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        // Image.asset(
                                        //   'assets/images/bus1.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'LMS',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[800],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(feesProvider.notifier)
                                        .setFeesNavString('Online Trans');
                                    Navigator.push(
                                      context,
                                      RouteDesign(
                                        route: const CalendarPage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    // height: 120,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: const EdgeInsets.all(
                                      15,
                                    ),
                                    decoration: BoxDecoration(
                                      // color: Colors.lightGreenAccent,
                                      color: AppColors.homepagecolor1,
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/calendar.png',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              12,
                                        ),
                                        // Image.asset(
                                        //   'assets/images/bus2.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        // Image.asset(
                                        //   'assets/images/bus3.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        // Image.asset(
                                        //   'assets/images/bus1.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Calender',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[800],
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
                                        route: const LmsHomePage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    // height: 120,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    padding: const EdgeInsets.all(
                                      15,
                                    ),
                                    // decoration: BoxDecoration(
                                    //   // color: Colors.lightGreenAccent,
                                    //   color: AppColors.homepagecolor3,
                                    //   borderRadius: BorderRadius.circular(
                                    //     20,
                                    //   ),
                                    // ),
                                    child: const Column(
                                      children: [
                                        // Image.asset(
                                        //   'assets/images/LMS.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        // Image.asset(
                                        //   'assets/images/bus2.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        // Image.asset(
                                        //   'assets/images/bus3.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        // Image.asset(
                                        //   'assets/images/bus1.png',
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .height /
                                        //       12,
                                        // ),
                                        const SizedBox(width: 10),
                                        // Text(
                                        //   'LMS',
                                        //   style: TextStyle(
                                        //     fontSize: 20,
                                        //     fontWeight: FontWeight.bold,
                                        //     color: Colors.blue[800],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height < 820
                                  ? 35
                                  : height < 1081
                                      ? 250
                                      : height < 1440
                                          ? 100
                                          : 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: const DrawerDesign(),
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
