import 'dart:convert';
import 'dart:developer';

import 'package:async/async.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart' as pro;
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
import 'package:sample/home/main_pages/academics/overall_attendance_page/riverpod/dhasboard_overall_attendance_state.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/riverpod/overall_attendance_state.dart';
import 'package:sample/home/main_pages/academics/subject_pages/model/subject_responce_hive_model.dart';
import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_state.dart';
import 'package:sample/home/main_pages/calendar/riverpod/calendar_state.dart';
import 'package:sample/home/main_pages/calendar/riverpod/time_table_state.dart';
import 'package:sample/home/main_pages/cgpa/riverpod/cgpa_state.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';
import 'package:sample/home/main_pages/fees_due_home_page.dart/riverpod/fees_dhasboard_Page_state.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_category_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_subtype_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_type_hive_model.dart';
import 'package:sample/home/main_pages/grievances/riverpod/grievance_state.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/home/main_pages/lms/lms%20content%20details/content%20details%20riverpod/lms_content_details_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_count_state.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_state.dart';
import 'package:sample/home/main_pages/sgpa/riverpod/sgpa_state.dart';
import 'package:sample/home/main_pages/transport/riverpod/transport_state.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:sample/main.dart';
import 'package:sample/network/riverpod/network_state.dart';
import 'package:sample/theme-07/bottom_navbar.dart';
import 'package:sample/theme-07/login/login_page_theme07.dart';
import 'package:sample/theme-07/mainscreens/academy/academy_home_page.dart';
import 'package:sample/theme-07/mainscreens/academy/lms_content_details.dart';
import 'package:sample/theme-07/mainscreens/academy/lms_homePage.dart';
import 'package:sample/theme-07/mainscreens/academy/lms_title_page.dart';
import 'package:sample/theme-07/mainscreens/academy/time_table_screen.dart';
import 'package:sample/theme-07/mainscreens/fees/fees_home_page.dart';
import 'package:sample/theme-07/mainscreens/grievance/grievance_homepage.dart';
import 'package:sample/theme-07/notification_homepage.dart';
import 'package:sample/theme-07/notification_page.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07dhasboardPage extends ConsumerStatefulWidget {
  const Theme07dhasboardPage({super.key});

  @override
  ConsumerState createState() => _Theme07dhasboardPageState();
}

class _Theme07dhasboardPageState extends ConsumerState<Theme07dhasboardPage> with WidgetsBindingObserver {
  final _cancelableOperations = <CancelableOperation<void>>[];
  bool isHoliday = false;

  @override
  void initState() {
    super.initState();
    _initialProcess();
    Alerts.checkForAppUpdate(context: context, forcefully: false);

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          animateBars = true;
        });
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      SystemChrome.setSystemUIOverlayStyle(
        StatusBarNavigationBarDesigns.statusBarNavigationBarDesign,
      );
    }
  }

  bool animateBars = false;

  Future<void> _initialProcess() async {
    await TokensManagement.getStudentId();
    await ref.read(loginProvider.notifier).getAppVersion();
    await TokensManagement.getPhoneToken();
    await TokensManagement.getAppDeviceInfo();
    await TokensManagement.getTheme();

    // Consolidated async API calls
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final operation = CancelableOperation.fromFuture(
        Future<void>.sync(() async {
          if (mounted) {
            // Profile
            await ref.read(profileProvider.notifier).getProfileApi(
                  ref.read(encryptionProvider.notifier),
                );
            await ref.read(profileProvider.notifier).getProfileHive('');

            // Timetable
            await ref.read(timetableProvider.notifier).getTimeTableDetails(
                  ref.read(encryptionProvider.notifier),
                );

            // LMS Courses
            await ref.read(lmsProvider.notifier).getLmsSubgetDetails(
                  ref.read(encryptionProvider.notifier),
                );

            // CGPA
            await ref.read(cgpaProvider.notifier).getCgpaDetails(
                  ref.read(encryptionProvider.notifier),
                );

            // SGPA
            await ref.read(sgpaProvider.notifier).getSgpaDetails(
                  ref.read(encryptionProvider.notifier),
                );

            // Fees Dashboard
            await ref.read(feesDhasboardProvider.notifier).getFeesDhasboardDetails(
                  ref.read(encryptionProvider.notifier),
                );

            // Notification Count
            await ref.read(notificationCountProvider.notifier).getNotificationCountDetails(
                  ref.read(encryptionProvider.notifier),
                );

            // Overall Attendance
            await ref.read(overallattendanceProvider.notifier).getSubjectWiseOverallAttendanceDetails(
                  ref.read(encryptionProvider.notifier),
                );

            // Fees
            await ref.read(feesProvider.notifier).getFinanceDetailsApi(ref.read(encryptionProvider.notifier));
            await ref.read(feesProvider.notifier).getFeedDueDetails(ref.read(encryptionProvider.notifier));

            // Calendar
            await ref.read(calendarProvider.notifier).getCalendarDetails(ref.read(encryptionProvider.notifier));
            await ref.read(calendarProvider.notifier).getHiveCalendar('');

            // Dashboard Overall Attendance
            await ref.read(DhasboardoverallattendanceProvider.notifier).getDhasboardOverallAttendanceDetails(
                  ref.read(encryptionProvider.notifier),
                );

            // Transport
            await ref.read(transportProvider.notifier).getTransportStatusDetails(
                  ref.read(encryptionProvider.notifier),
                );
            await ref.read(transportProvider.notifier).getTransportStatusHiveDetails('');
            await ref.read(transportProvider.notifier).getRouteIdDetails(
                  ref.read(encryptionProvider.notifier),
                );
            await ref.read(transportProvider.notifier).getRouteIdHiveDetails('');
            await ref.read(transportProvider.notifier).getBoardingIdDetails(
                  ref.read(encryptionProvider.notifier),
                );
            await ref.read(transportProvider.notifier).getBoardingPointHiveDetails('');
            await ref.read(transportProvider.notifier).gettransportRegisterDetails(
                  ref.read(encryptionProvider.notifier),
                );
            await ref.read(transportProvider.notifier).getTransportHiveRegisterDetails('');
            await ref.read(transportProvider.notifier).getTransportHiveAfterRegisterDetails('');

            // Hostel
            await ref.read(hostelProvider.notifier).getHostelHiveDetails('');

            // Notification
            await ref.read(notificationProvider.notifier).getNotificationDetails(
                  ref.read(encryptionProvider.notifier),
                );

            // Attendance
            await ref.read(attendanceProvider.notifier).getAttendanceDetails(
                  ref.read(encryptionProvider.notifier),
                );
            await ref.read(attendanceProvider.notifier).getHiveAttendanceDetails('');
          }
        }),
      );
      _cancelableOperations.add(operation);
    });

    // Hive operations
    final attendance = await Hive.openBox<AttendanceHiveData>('Attendance');
    if (attendance.isEmpty && mounted) {
      await ref.read(attendanceProvider.notifier).getAttendanceDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref.read(attendanceProvider.notifier).getHiveAttendanceDetails('');
    }
    await attendance.close();

    final cummulativeAttendance = await Hive.openBox<CumulativeAttendanceHiveData>('cumulativeattendance');
    if (cummulativeAttendance.isEmpty && mounted) {
      await ref.read(cummulativeAttendanceProvider.notifier).getCummulativeAttendanceDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref.read(cummulativeAttendanceProvider.notifier).getHiveCummulativeDetails('');
    }
    await cummulativeAttendance.close();

    final examDetails = await Hive.openBox<ExamDetailsHiveData>('examDetails');
    if (examDetails.isEmpty && mounted) {
      await ref.read(examDetailsProvider.notifier).getExamDetailsApi(
            ref.read(encryptionProvider.notifier),
          );
      await ref.read(examDetailsProvider.notifier).getHiveExamDetails('');
    }
    await examDetails.close();

    final hourwiseAttendance = await Hive.openBox<HourwiseHiveData>('hourwisedata');
    if (hourwiseAttendance.isEmpty && mounted) {
      await ref.read(hourwiseProvider.notifier).gethourwiseDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref.read(hourwiseProvider.notifier).getHiveHourwise('');
    }
    await hourwiseAttendance.close();

    final internalMarks = await Hive.openBox<InternalMarkHiveData>('internalmarkdata');
    if (internalMarks.isEmpty && mounted) {
      await ref.read(internalMarksProvider.notifier).getInternalMarksDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref.read(internalMarksProvider.notifier).getHiveInternalMarks('');
    }
    await internalMarks.close();

    final subjects = await Hive.openBox<SubjectHiveData>('subjecthive');
    if (subjects.isEmpty && mounted) {
      await ref.read(subjectProvider.notifier).getSubjectDetails(ref.read(encryptionProvider.notifier));
      await ref.read(subjectProvider.notifier).getHiveSubjectDetails('');
    }
    await subjects.close();

    final grievanceCategoryData = await Hive.openBox<GrievanceCategoryHiveData>('grievanceCategoryData');
    if (grievanceCategoryData.isEmpty && mounted) {
      await ref.read(grievanceProvider.notifier).getGrievanceCategoryDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref.read(grievanceProvider.notifier).getHiveGrievanceCategoryDetails('');
    }
    await grievanceCategoryData.close();

    final grievanceSubTypeData = await Hive.openBox<GrievanceSubTypeHiveData>('grievanceSubTypeData');
    if (grievanceSubTypeData.isEmpty && mounted) {
      await ref.read(grievanceProvider.notifier).getGrievanceSubTypeDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref.read(grievanceProvider.notifier).getHiveGrievanceSubTypeDetails('');
    }
    await grievanceSubTypeData.close();

    final grievanceTypeData = await Hive.openBox<GrievanceTypeHiveData>('grievanceTypeData');
    if (grievanceTypeData.isEmpty && mounted) {
      await ref.read(grievanceProvider.notifier).getGrievanceTypeDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref.read(grievanceProvider.notifier).getHiveGrievanceTypeDetails('');
    }
    await grievanceTypeData.close();
  }

  final ScrollController _listController = ScrollController();

  String? selectedDomain;
  double? selectedMeasure;
  Offset? tooltipPosition;
  bool showTooltip = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    for (final operation in _cancelableOperations) {
      operation.cancel();
    }
    _listController.dispose();
    super.dispose();
  }

  // Logout function
  void logout(BuildContext context) {
    showDialog(
      barrierColor: const Color.fromARGB(175, 0, 0, 0),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            'Logout Confirmation',
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.red.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                ref.read(mainProvider.notifier).setNavString('Logout');

                await TokensManagement.clearSharedPreference();

                await Navigator.pushAndRemoveUntil(
                  context,
                  RouteDesign(
                    route: const Theme07LoginPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref
      ..watch(attendanceProvider)
      ..listenManual(networkProvider, (previous, next) {
        if (mounted &&
            previous!.connectivityResult == ConnectivityResult.none &&
            next.connectivityResult != ConnectivityResult.none) {}
      })
      ..listenManual(changePasswordProvider, (previous, next) {
        if (mounted) {
          if (next is ChangePasswordStateSuccessful) {
            if (next.message == 'Password Changed Successfuly') {
              _showToast(context, next.message, AppColors.greenColor);
            } else {
              _showToast(context, next.message, AppColors.redColor);
            }
          } else if (next is ChangePasswordStateError) {
            _showToast(context, next.message, AppColors.redColor);
          }
        }
      });

    final providerProfile = ref.watch(profileProvider);
    final courseProvider = ref.watch(lmsProvider);
    final base64Image = '${providerProfile.profileDataHive.studentphoto}';
    final imageBytes = base64Decode(base64Image);
    final provider = ref.watch(cgpaProvider);
    final sgpaprovider = ref.watch(sgpaProvider);
    final notificatioCountprovider = ref.watch(notificationCountProvider);
    final feesdhasboardprovider = ref.watch(feesDhasboardProvider);
    ref.watch(hostelProvider);
    final calenderprovider = ref.watch(calendarProvider);

    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 60 + MediaQuery.of(context).padding.bottom),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (imageBytes == '' || imageBytes.isEmpty)
                                  CircleAvatar(
                                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                                    radius: 25,
                                    child: CircleAvatar(
                                      backgroundColor: Theme.of(context).colorScheme.surface,
                                      radius: 48,
                                      child: Icon(
                                        FontAwesomeIcons.userGraduate,
                                        color: Theme.of(context).colorScheme.inverseSurface.withAlpha(180),
                                      ),
                                    ),
                                  )
                                else
                                  SizedBox(
                                    height: 45,
                                    width: 45,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.memory(
                                        imageBytes,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        IconButton(
                                          iconSize: 28,
                                          color: Colors.white,
                                          icon: const Icon(Icons.notifications),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              RouteDesign(
                                                route: const Theme07NotificationHomePage(),
                                              ),
                                            );
                                          },
                                        ),
                                        if (notificatioCountprovider.notificationCountData.isEmpty)
                                          Positioned(
                                            right: 2,
                                            top: 2,
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              constraints: const BoxConstraints(
                                                minWidth: 20,
                                                minHeight: 20,
                                              ),
                                              child: SizedBox(
                                                width: 5,
                                                child: Column(
                                                  children: [
                                                    if (notificatioCountprovider.notificationCountData.isNotEmpty)
                                                      ListView.builder(
                                                        itemCount:
                                                            notificatioCountprovider.notificationCountData.length,
                                                        // controller: _listController,
                                                        shrinkWrap: true,
                                                        itemBuilder: (
                                                          BuildContext context,
                                                          int index,
                                                        ) {
                                                          return notificationCountCardDesign(index);
                                                        },
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        logout(context);
                                      },
                                      icon: const Icon(
                                        Icons.logout,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     Stack(
                                //       clipBehavior: Clip.none,
                                //       children: [
                                //         IconButton(
                                //           onPressed: () {
                                //             _scaffoldKey.currentState?.openEndDrawer();
                                //           },
                                //           icon: Icon(
                                //             Icons.menu,
                                //             size: 35,
                                //             color: Colors.white,
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Hello, ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              TokensManagement.studentName == '' ? '-' : TokensManagement.studentName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: [
                          Text(
                            'Welcome...!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  elevation: 0,
                  shadowColor: Theme.of(context).colorScheme.inverseSurface,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(
                      maxHeight: 410,
                    ),
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Today's Schedule
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.campaign_rounded,
                                  size: 40,
                                  color: Theme.of(context).colorScheme.inversePrimary,
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  "Today's Schedule",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).colorScheme.inverseSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: calenderprovider.calendarCurrentDateData.length,
                          itemBuilder: (context, index) => calenderStatuscardDesign(index),
                        ),
                        const SizedBox(height: 15),

                        // Today's timetable card
                        if (!isHoliday) _buildDayTimetable(DateFormat('EEEE').format(DateTime.now()).toLowerCase()),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),

              // Quick Links
              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  elevation: 0,
                  shadowColor: Theme.of(context).colorScheme.inverseSurface,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Links',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 100, // Fixed height to accommodate icons and labels
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            padding: const EdgeInsets.symmetric(horizontal: 8), // Adds equal margin on left and right
                            // separatorBuilder: (context, index) =>
                            //     SizedBox(width: (MediaQuery.of(context).size.width - 30 * 3) * .175),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: (MediaQuery.of(context).size.width - 30 * 4) * .0875),
                            itemBuilder: (context, index) {
                              final links = [
                                {'icon': Icons.calendar_today, 'label': 'Fee', 'route': '/fee'},
                                {'icon': Icons.receipt, 'label': 'Academics', 'route': '/academics'},
                                {'icon': Icons.edit_calendar, 'label': 'Grievances', 'route': '/grievances'},
                                {'icon': Icons.more_horiz, 'label': 'More', 'route': '/more'},
                              ];
                              return Column(
                                spacing: 8,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Theme.of(context).colorScheme.surface,
                                    child: IconButton(
                                      icon: Icon(
                                        links[index]['icon']! as IconData,
                                        size: 28,
                                        color: Theme.of(context).colorScheme.inversePrimary,
                                      ),
                                      onPressed: () {
                                        // Navigate to respective pages (implement routes as needed)
                                        switch (links[index]['route']) {
                                          case '/fee':
                                            Navigator.push(
                                              context,
                                              RouteDesign(
                                                route: const Theme007FeesPage(),
                                              ),
                                            );
                                          case '/academics':
                                            ref.read(feesProvider.notifier).setFeesNavString('Online Trans');
                                            Navigator.push(
                                              context,
                                              RouteDesign(
                                                route: const Theme07AcademicsHomePage(),
                                              ),
                                            );
                                          case '/grievances':
                                            Navigator.push(
                                              context,
                                              RouteDesign(
                                                route: const Theme07GrievanceHomePage(),
                                              ),
                                            );
                                          case '/more':
                                            pro.Provider.of<NavigationProvider>(context, listen: false)
                                                .setSelectedIndex(1);
                                        }
                                      },
                                    ),
                                  ),
                                  Text(
                                    links[index]['label'].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).colorScheme.inverseSurface,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // My Courses
              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  elevation: 0,
                  shadowColor: Theme.of(context).colorScheme.inverseSurface,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.menu_book,
                                  size: 30,
                                  color: Theme.of(context).colorScheme.inversePrimary,
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  'My Courses',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.inverseSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        if (provider is LmsStateLoading)
                          const SizedBox(
                            height: 200, // Fixed height for loading state
                            child: Center(
                              child: CircularProgressIndicator(), // Use standard indicator or custom
                            ),
                          )
                        else if (courseProvider.lmsSubjectData.isEmpty && provider is! LmsStateLoading)
                          SizedBox(
                            height: 200, // Fixed height for empty state
                            child: Center(
                              child: Text(
                                'No List Added',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.inverseSurface,
                                ),
                              ),
                            ),
                          )
                        else
                          SizedBox(
                            height: 210, // Fixed height for the horizontal ListView
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              scrollDirection: Axis.horizontal,
                              itemCount: courseProvider.lmsSubjectData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return courseCardDesign(index);
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              // My Course wise Attendance
              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  elevation: 0,
                  shadowColor: Theme.of(context).colorScheme.inverseSurface,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Container(
                    // padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: cardDesign(),
                  ),
                ),
              ),

              // Hour Attendance
              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  elevation: 0,
                  shadowColor: Theme.of(context).colorScheme.inverseSurface,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        cardDesignAttendanceHrs(),
                      ],
                    ),
                  ),
                ),
              ),

              // S G P A   &   C G P A   C A R D   1
              // Card(
              //   elevation: 0,
              //   shadowColor: Theme.of(context).colorScheme.inverseSurface,
              //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              //   color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
              //   child: Container(
              //     width: double.infinity,
              //     padding: const EdgeInsets.all(16),
              //     decoration: BoxDecoration(
              //       color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.only(top: 12),
              //               child: Icon(
              //                 Icons.school_rounded,
              //                 color: Theme.of(context).colorScheme.inversePrimary,
              //                 size: 36,
              //               ),
              //             ),
              //             Text(
              //               'S.G.P.A',
              //               style: TextStyle(
              //                 color: Theme.of(context).colorScheme.inverseSurface,
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 18,
              //               ),
              //             ),
              //             Container(
              //               width: 100,
              //               padding: const EdgeInsets.symmetric(
              //                 horizontal: 24,
              //                 vertical: 10,
              //               ),
              //               decoration: BoxDecoration(
              //                 color: Theme.of(context).colorScheme.surface,
              //                 borderRadius: BorderRadius.circular(12),
              //               ),
              //               child: Column(
              //                 children: [
              //                   if (sgpaprovider is SgpaLoading)
              //                     Center(
              //                       child: CircularProgressIndicators.primaryColorProgressIndication,
              //                     )
              //                   else if (sgpaprovider.sgpaData.isEmpty && sgpaprovider is! CgpaLoading)
              //                     Column(
              //                       children: [
              //                         Center(
              //                           child: Text(
              //                             'No Data!',
              //                             style: TextStyles.fontStyle1,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   if (sgpaprovider.sgpaData.isNotEmpty)
              //                     ListView.builder(
              //                       itemCount: sgpaprovider.sgpaData.length,
              //                       controller: _listController,
              //                       shrinkWrap: true,
              //                       itemBuilder: (
              //                         BuildContext context,
              //                         int index,
              //                       ) {
              //                         return sgpacardDesign(index);
              //                       },
              //                     ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //         const SizedBox(height: 20),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.only(top: 12),
              //               child: Icon(
              //                 Icons.bar_chart_rounded,
              //                 color: Theme.of(context).colorScheme.inversePrimary,
              //                 size: 36,
              //               ),
              //             ),
              //             Text(
              //               'C.G.P.A',
              //               style: TextStyle(
              //                 color: Theme.of(context).colorScheme.inverseSurface,
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 18,
              //               ),
              //             ),
              //             Container(
              //               width: 100,
              //               padding: const EdgeInsets.symmetric(
              //                 horizontal: 24,
              //                 vertical: 10,
              //               ),
              //               decoration: BoxDecoration(
              //                 color: Theme.of(context).colorScheme.surface,
              //                 borderRadius: BorderRadius.circular(12),
              //               ),
              //               child: Column(
              //                 children: [
              //                   if (provider is CgpaLoading)
              //                     Center(
              //                       child: CircularProgressIndicators.primaryColorProgressIndication,
              //                     )
              //                   else if (provider.cgpaData.isEmpty && provider is! CgpaLoading)
              //                     Column(
              //                       children: [
              //                         Center(
              //                           child: Text(
              //                             'No Data!',
              //                             style: TextStyles.fontStyle1,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   if (provider.cgpaData.isNotEmpty)
              //                     ListView.builder(
              //                       itemCount: provider.cgpaData.length,
              //                       controller: _listController,
              //                       shrinkWrap: true,
              //                       itemBuilder: (
              //                         BuildContext context,
              //                         int index,
              //                       ) {
              //                         return cgpacardDesign(index);
              //                       },
              //                     ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              // S G P A   &   C G P A   C A R D   2
              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  elevation: 0,
                  shadowColor: Theme.of(context).colorScheme.inverseSurface,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Theme.of(context).colorScheme.inversePrimary,
                                  size: 40,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Grades',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.inverseSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // SGPA INDICATOR
                            Expanded(
                              child: Container(
                                width: 150,
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    if (sgpaprovider is SgpaLoading)
                                      Center(
                                        child: CircularProgressIndicators.primaryColorProgressIndication,
                                      )
                                    else if (sgpaprovider.sgpaData.isEmpty && sgpaprovider is! CgpaLoading)
                                      Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              'No SGPA Data!',
                                              style: TextStyles.fontStyle1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (sgpaprovider.sgpaData.isNotEmpty)
                                      ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: sgpaprovider.sgpaData.length,
                                        // controller: _listController,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (
                                          BuildContext context,
                                          int index,
                                        ) {
                                          return sgpacardDesign(index);
                                        },
                                      ),
                                  ],
                                ),
                              ),
                            ),

                            // CGPA INDICATOR
                            Expanded(
                              child: Container(
                                width: 150,
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    if (provider is CgpaLoading)
                                      Center(
                                        child: CircularProgressIndicators.primaryColorProgressIndication,
                                      )
                                    else if (provider.cgpaData.isEmpty && provider is! CgpaLoading)
                                      Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              'No CGPA Data!',
                                              style: TextStyles.fontStyle1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (provider.cgpaData.isNotEmpty)
                                      ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: provider.cgpaData.length,
                                        // controller: _listController,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (
                                          BuildContext context,
                                          int index,
                                        ) {
                                          return cgpacardDesign(index);
                                        },
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
                ),
              ),

              // F E E S   D U E   C  A R D
              Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme007FeesPage(),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 0,
                    shadowColor: Theme.of(context).colorScheme.inverseSurface,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.account_balance_wallet_rounded,
                                color: Theme.of(context).colorScheme.inversePrimary,
                                size: 40,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Current Due',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.inverseSurface,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 200,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                if (provider is FeesDhasboardLoading)
                                  Center(
                                    child: CircularProgressIndicators.primaryColorProgressIndication,
                                  )
                                else if (feesdhasboardprovider.feesDueDhasboardData.isEmpty &&
                                    provider is! FeesDhasboardLoading)
                                  Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          'No Data!',
                                          style: TextStyles.fontStyle1,
                                        ),
                                      ),
                                    ],
                                  ),
                                if (feesdhasboardprovider.feesDueDhasboardData.isNotEmpty)
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: feesdhasboardprovider.feesDueDhasboardData.length,
                                    // controller: _listController,
                                    shrinkWrap: true,
                                    itemBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      return feesdhasboardcardDesign(index);
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardDesign() {
    final provider = ref.watch(attendanceProvider);

    final attendanceData = provider.attendancehiveData;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                size: 30,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(width: 20),
              Text(
                'My Course wise attendance (%)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AspectRatio(
              aspectRatio: 13 / 9,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (group) => Theme.of(context).colorScheme.surface,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${rod.toY.toStringAsFixed(1)}%',
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                        );
                      },
                    ),
                    touchCallback: (event, response) {
                      if (event.isInterestedForInteractions && response != null && response.spot != null) {
                        setState(() {
                          selectedDomain = attendanceData[response.spot!.touchedBarGroupIndex].subjectcode;
                          selectedMeasure = response.spot!.touchedRodData.toY;
                          tooltipPosition = Offset(event.localPosition!.dx, event.localPosition!.dy);
                          showTooltip = true;
                        });
                      }
                    },
                  ),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 20,
                        reservedSize: 32,
                        getTitlesWidget: (value, meta) => Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            '${value.toInt()}%',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.inverseSurface,
                            ),
                          ),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < attendanceData.length) {
                            return Transform.rotate(
                              origin: const Offset(-16, 28),
                              angle: 0.5,
                              child: Text(
                                attendanceData[index].subjectcode ?? '',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.inverseSurface,
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                  gridData: const FlGridData(),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        width: 2,
                      ),
                    ),
                  ),
                  barGroups: List.generate(attendanceData.length, (i) {
                    final data = attendanceData[i];
                    final percentage =
                        data.presentpercentage == '' ? 0.0 : double.tryParse(data.presentpercentage!) ?? 0.0;

                    final color = percentage < 75 ? Colors.red : Colors.green;

                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: animateBars ? percentage : 0,
                          color: color,
                          width: 18,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }),
                ),
                swapAnimationDuration: const Duration(milliseconds: 800),
                swapAnimationCurve: Curves.decelerate,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardDesignAttendanceHrs() {
    final provider = ref.watch(DhasboardoverallattendanceProvider);

    if (provider.DhasboardOverallattendanceData.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final present = int.tryParse(
          provider.DhasboardOverallattendanceData.first.totalpresenthours ?? '0',
        ) ??
        0;
    final absent = int.tryParse(
          provider.DhasboardOverallattendanceData.first.absentcnt ?? '0',
        ) ??
        0;
    final absentper = double.tryParse(
          provider.DhasboardOverallattendanceData.first.absentper ?? '0',
        ) ??
        0.0;

    final totalSessions = present + absent;
    final overallPercentage = totalSessions > 0 ? (present / totalSessions * 100) : 0.0;
    final presentPercentage = totalSessions > 0 ? (present / totalSessions * 100) : 0.0;
    final absentPercentage = totalSessions > 0 ? (absent / totalSessions * 100) : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.list_alt_outlined,
              size: 30,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(width: 20),
            Text(
              'Hour Attendance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 250,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  PieChart(
                    curve: Curves.decelerate,
                    PieChartData(
                      startDegreeOffset: 270,
                      sections: [
                        PieChartSectionData(
                          color: presentPercentage <= 80 ? Colors.yellow : Colors.green,
                          value: animateBars ? present.toDouble() : 100,
                          title: animateBars ? '${presentPercentage.toStringAsFixed(2)}%' : '100%',
                          radius: presentPercentage <= 25 ? 60 : 50,
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        PieChartSectionData(
                          color: Colors.red,
                          value: animateBars ? absent.toDouble() : 0,
                          title: animateBars ? '${absentPercentage.toStringAsFixed(2)}%' : '0%',
                          radius: absentPercentage <= 25 ? 60 : 50,
                          titleStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      borderData: FlBorderData(show: false),
                      centerSpaceRadius: 60,
                      sectionsSpace: 2,
                    ),
                    swapAnimationDuration: const Duration(milliseconds: 800),
                    swapAnimationCurve: Curves.decelerate,
                  ),
                  Positioned(
                    top: 100,
                    left: (constraints.maxWidth - 120) / 2,
                    child: SizedBox(
                      width: 120,
                      height: 50,
                      child: Center(
                        child: Text(
                          'Total: $totalSessions',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 40),
                Container(
                  width: 20,
                  height: 20,
                  color: presentPercentage <= 80 ? Colors.yellow : Colors.green,
                ),
                const SizedBox(width: 10),
                Text(
                  'Present - $present',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const SizedBox(width: 40),
                Container(
                  width: 20,
                  height: 20,
                  color: Colors.red,
                ),
                const SizedBox(width: 10),
                Text(
                  'Absent - $absent',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ],
    );
  }

  Widget courseCardDesign(int index) {
    final provider = ref.watch(lmsProvider);
    // final themeProvider = pro.Provider.of<ThemeProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width - 86, // Fixed width for each card
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Theme.of(context).colorScheme.tertiary,
            ),
            child: Center(
              child: Text(
                provider.lmsSubjectData[index].subjectdesc ?? 'Course Name',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  // color: Theme.of(context).colorScheme.inverseSurface,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis, // Prevent text overflow
              ),
            ),
          ),

          // Card Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoRow(
                  Icons.code,
                  'Course Code',
                  provider.lmsSubjectData[index].subjectcode,
                ),
                const SizedBox(height: 8),
                _infoRow(
                  Icons.person,
                  'Staff',
                  provider.lmsSubjectData[index].staffname,
                ),
              ],
            ),
          ),

          // Action Buttons
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Divider(height: 1, color: Colors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {
                      ref.read(lmsProvider.notifier).getLmsTitleDetails(
                            ref.read(encryptionProvider.notifier),
                            '${provider.lmsSubjectData[index].subjectid}',
                          );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Theme07LmsTitlePage(
                            subjectID: '${provider.lmsSubjectData[index].subjectid}',
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Classwork Details',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(width: 1, height: 50, color: Colors.grey),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {
                      ref.read(lmsContentDetailsProvider.notifier).getLmsContentDetails(
                            ref.read(encryptionProvider.notifier),
                            '${provider.lmsSubjectData[index].subjectid}',
                          );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Theme07LmsContentDetailsPage(
                            subjectid: '${provider.lmsSubjectData[index].subjectid}',
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Content Details',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$title: ${value ?? 'N/A'}',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
            overflow: TextOverflow.ellipsis, // Prevent text overflow
          ),
        ),
      ],
    );
  }

  // Widget cgpacardDesign(int index) {
  //   final provider = ref.watch(cgpaProvider);
  //   return GestureDetector(
  //     onTap: () {},
  //     child: Column(
  //       children: [
  //         Text(
  //           '${provider.cgpaData[index].cgpa}' == 'null' ? '-' : '''${provider.cgpaData[index].cgpa}''',
  //           style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold,
  //             color: Theme.of(context).colorScheme.inverseSurface,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget sgpacardDesign(int index) {
  //   final sgpaprovider = ref.watch(sgpaProvider);
  //   return GestureDetector(
  //     onTap: () {},
  //     child: Column(
  //       children: [
  //         Text(
  //           '${sgpaprovider.sgpaData[index].attrvalue}' == 'null'
  //               ? '-'
  //               : '''${sgpaprovider.sgpaData[index].attrvalue}''',
  //           style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold,
  //             color: Theme.of(context).colorScheme.inverseSurface,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget cgpacardDesign(int index) {
    final provider = ref.watch(cgpaProvider);
    final acquiredCgpa =
        provider.cgpaData[index].cgpa == null ? 0 : double.parse(provider.cgpaData[index].cgpa.toString());
    const maxCgpa = 10;
    final percent = acquiredCgpa / maxCgpa;

    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: 200,
        child: CircularPercentIndicator(
          radius: 80, // Adjusted to match approximate size of original pie chart
          lineWidth: 12, // Matches the original radius of PieChartSectionData
          animation: animateBars,
          animationDuration: 800, // Matches swapAnimationDuration
          percent: animateBars ? percent : 1.0, // Full circle when not animating
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: acquiredCgpa >= 5 ? Colors.green : Colors.red,
          backgroundColor: Theme.of(context).colorScheme.inverseSurface.withAlpha(10),
          center: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'C.G.P.A\n${acquiredCgpa.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget sgpacardDesign(int index) {
    final provider = ref.watch(sgpaProvider);
    final acquiredSgpa =
        provider.sgpaData[index].attrvalue == null ? 0 : double.parse(provider.sgpaData[index].attrvalue.toString());
    const maxSgpa = 10;
    final percent = acquiredSgpa / maxSgpa;

    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: 200,
        child: CircularPercentIndicator(
          radius: 80, // Adjusted to match approximate size of original pie chart
          lineWidth: 12, // Matches the original radius of PieChartSectionData
          animation: animateBars,
          animationDuration: 800, // Matches swapAnimationDuration
          percent: animateBars ? percent : 1.0, // Full circle when not animating
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: acquiredSgpa >= 5 ? Colors.green : Colors.red,
          backgroundColor: Theme.of(context).colorScheme.inverseSurface.withAlpha(10),
          center: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'S.G.P.A\n${acquiredSgpa.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget notificationCountCardDesign(int index) {
    final notificatioCountprovider = ref.watch(notificationCountProvider);
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Text(
            '${notificatioCountprovider.notificationCountData[index].unreadnotificationcount}' == 'null'
                ? '-'
                : '''${notificatioCountprovider.notificationCountData[index].unreadnotificationcount}''',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget feesdhasboardcardDesign(int index) {
    final feescurrendDataProvider = ref.watch(feesDhasboardProvider);
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Text(
            '${feescurrendDataProvider.feesDueDhasboardData[index].currentdue}' == 'null'
                ? '-'
                : '''Rs. ${feescurrendDataProvider.feesDueDhasboardData[index].currentdue}''',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inverseSurface,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget notificationcardDesign(int index) {
    final provider = ref.watch(notificationProvider);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          RouteDesign(route: const Theme02NotificationPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.paste_rounded,
              size: 32,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '${provider.notificationData[index].notificationsubject}',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.theme01primaryColor,
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  RouteDesign(route: const Theme02NotificationPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'View',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Divider(
              height: 1,
              color: AppColors.redColor.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget calenderStatuscardDesign(int index) {
    final provider = ref.watch(calendarProvider);

    // Move setState to a post-frame callback to avoid calling during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          isHoliday = provider.calendarCurrentDateData[index].daystatus?.toLowerCase() == 'holiday';
        });
      }
    });

    return Column(
      children: [
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${provider.calendarCurrentDateData[index].date}' == ''
                      ? 'No Data'
                      : '${provider.calendarCurrentDateData[index].date}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${provider.calendarCurrentDateData[index].daystatus}' == ''
                      ? 'No Data'
                      : '${provider.calendarCurrentDateData[index].daystatus}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 15),
        if (isHoliday)
          Container(
            width: 150,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  RouteDesign(
                    route: const Theme07TimetablePageScreen(),
                  ),
                );
              },
              child: const Text(
                'View Timetable',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDayTimetable(String day) {
    final provider = ref.watch(timetableProvider);

    final allClasses = provider.timeTableData
        .asMap()
        .entries
        .where((entry) => entry.value.dayorderdesc?.toLowerCase() == day)
        .toList();

    final pastClasses = <MapEntry<int, dynamic>>[];
    final ongoingClasses = <MapEntry<int, dynamic>>[];
    final upcomingClasses = <MapEntry<int, dynamic>>[];

    for (final entry in allClasses) {
      final status = getClassStatus(entry.value.hourtime);
      switch (status) {
        case ClassStatus.past:
          pastClasses.add(entry);
        case ClassStatus.ongoing:
          ongoingClasses.add(entry);
        case ClassStatus.upcoming:
          upcomingClasses.add(entry);
      }
    }

    final sortedClasses = [...pastClasses, ...ongoingClasses, ...upcomingClasses];
    final ongoingStartIndex = pastClasses.length;

    // Trigger scroll to ongoing class after the frame is built
    // if (ongoingClasses.isNotEmpty) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     final cardWidth = (MediaQuery.of(context).size.width * .75) + 5;
    //     final offset = ongoingStartIndex * cardWidth;
    //     _listController.animateTo(
    //       offset,
    //       duration: const Duration(milliseconds: 800),
    //       curve: Curves.decelerate,
    //     );
    //   });
    // }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (provider is TimetableLoading)
            SizedBox(
              height: 200,
              child: Center(
                child: CircularProgressIndicators.theme07primaryColorProgressIndication,
              ),
            )
          // else if (provider.timeTableData.isEmpty && provider is TimetableLoading)
          //   SizedBox(
          //     height: 200,
          //     child: Center(
          //       child: Text(
          //         'No List Added Yet!',
          //         style: TextStyles.fontStyle,
          //       ),
          //     ),
          //   )
          else if (sortedClasses.isEmpty)
            SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  'No Classes for Today!',
                  style: TextStyles.fontStyle,
                ),
              ),
            )
          else
            SizedBox(
              height: 200,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: sortedClasses.length,
                // controller: _listController,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final originalIndex = sortedClasses[index].key;
                  return timeTableCardDesign(day, originalIndex);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget timeTableCardDesign(String day, int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(timetableProvider);
    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    final dayData = provider.timeTableData;

    if (dayData.isEmpty) {
      return Container();
    }

    if (index < 0 || index >= dayData.length) {
      print("Invalid index: $index. $day's data has only ${dayData.length} entries.");
      return Container();
    }

    final data = dayData[index];
    final status = getClassStatus(data.hourtime);

    // log('>>>>>> ${data.faculty!}');

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          RouteDesign(
            route: const Theme07LmsHomePage(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Container(
          width: width * 0.75,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: status == ClassStatus.ongoing
                  ? Colors.green.withOpacity(0.5)
                  : status == ClassStatus.upcoming
                      ? Colors.blue.withOpacity(0.5)
                      : Colors.grey.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card Header with Gradient
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                child: Center(
                  child: Text(
                    data.subjectdesc ?? '-',
                    textAlign: TextAlign.center,
                    style: TextStyles.fontStyle10.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.person,
                            size: 20,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${data.faculty != '-' ? data.faculty?.split(', ')[0] : '--'}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.inverseSurface,
                              ),
                              overflow: TextOverflow.ellipsis, // Prevent text overflow
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.work_rounded,
                            size: 20,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${data.faculty != '-' ? data.faculty?.split(', ')[1] : '--'}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.inverseSurface,
                              ),
                              overflow: TextOverflow.ellipsis, // Prevent text overflow
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.hourglass_bottom_rounded,
                            size: 20,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              data.hourtime ?? '-',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.inverseSurface,
                              ),
                              overflow: TextOverflow.ellipsis, // Prevent text overflow
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 80,
                        height: 20,
                        decoration: BoxDecoration(
                          color: status == ClassStatus.ongoing
                              ? Colors.green.withOpacity(0.2)
                              : status == ClassStatus.upcoming
                                  ? Colors.blue.withOpacity(0.2)
                                  : Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            status == ClassStatus.ongoing
                                ? 'Ongoing'
                                : status == ClassStatus.upcoming
                                    ? 'Upcoming'
                                    : 'Completed',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: status == ClassStatus.ongoing
                                  ? Colors.green
                                  : status == ClassStatus.upcoming
                                      ? Colors.blue
                                      : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ClassStatus { past, ongoing, upcoming }

ClassStatus getClassStatus(String? hourtime) {
  if (hourtime == null || hourtime.isEmpty) {
    return ClassStatus.past;
  }

  final timeRange = hourtime.split('-');
  if (timeRange.length != 2) {
    return ClassStatus.past;
  }

  final startTimeStr = timeRange[0];
  final endTimeStr = timeRange[1];

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  final startParts = startTimeStr.split(':').map(int.parse).toList();
  final endParts = endTimeStr.split(':').map(int.parse).toList();

  final startTime = today.add(
    Duration(
      hours: startParts[0],
      minutes: startParts[1],
      // seconds: startParts[2],
    ),
  );
  final endTime = today.add(
    Duration(
      hours: endParts[0],
      minutes: endParts[1],
      // seconds: endParts[2],
    ),
  );

  if (now.isAfter(startTime) && now.isBefore(endTime)) {
    return ClassStatus.ongoing;
  } else if (now.isBefore(startTime)) {
    return ClassStatus.upcoming;
  } else {
    return ClassStatus.past;
  }
}

class CircularHistoryIndicator extends StatelessWidget {
  const CircularHistoryIndicator({
    required this.title,
    required this.percentage,
    super.key,
  });

  final String title;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: percentage / 100,
                strokeWidth: 8,
                backgroundColor: Colors.teal.shade100,
                valueColor: const AlwaysStoppedAnimation(Colors.teal),
              ),
              Text(
                '${percentage.toInt()}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade900,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.teal.shade700,
          ),
        ),
      ],
    );
  }
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
