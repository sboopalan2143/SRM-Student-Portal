import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
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
import 'package:sample/home/main_pages/cgpa/riverpod/cgpa_state.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';
import 'package:sample/home/main_pages/fees_due_home_page.dart/riverpod/fees_dhasboard_Page_state.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_category_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_subtype_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_type_hive_model.dart';
import 'package:sample/home/main_pages/grievances/riverpod/grievance_state.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_count_state.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_state.dart';
import 'package:sample/home/main_pages/sgpa/riverpod/sgpa_state.dart';
import 'package:sample/home/main_pages/transport/riverpod/transport_state.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:sample/network/riverpod/network_state.dart';
import 'package:sample/theme-07/bottom_navbar.dart';
import 'package:sample/theme-07/mainscreens/academy/academy_home_page.dart';
import 'package:sample/theme-07/mainscreens/fees/fees_home_page.dart';
import 'package:sample/theme-07/mainscreens/grievance/grievance_homepage.dart';
import 'package:sample/theme-07/mainscreens/hostel/hostel_home_screen.dart';
import 'package:sample/theme-07/mainscreens/library/library_home_page.dart';
import 'package:sample/theme-07/mainscreens/transport/transport_register.dart';
import 'package:sample/theme-07/notification_homepage.dart';
import 'package:sample/theme-07/theme07_change_password.dart';
import 'package:sample/theme-07/theme07_profile_screen.dart';
import 'package:sample/theme-07/widget/drawer.dart';

class Theme07HomePage extends ConsumerStatefulWidget {
  const Theme07HomePage({super.key});

  @override
  ConsumerState createState() => _Theme07HomePageState();
}

class _Theme07HomePageState extends ConsumerState<Theme07HomePage> with WidgetsBindingObserver {
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
    await TokensManagement.getPhoneToken();
    await TokensManagement.getAppDeviceInfo();
    await TokensManagement.getTheme();

//ACADEMICS

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(profileProvider.notifier).getProfileApi(
              ref.read(
                encryptionProvider.notifier,
              ),
            );
        await ref.read(profileProvider.notifier).getProfileHive('');
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cgpaProvider.notifier).getCgpaDetails(
            ref.read(encryptionProvider.notifier),
          );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sgpaProvider.notifier).getSgpaDetails(
            ref.read(encryptionProvider.notifier),
          );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(feesDhasboardProvider.notifier).getFeesDhasboardDetails(
            ref.read(encryptionProvider.notifier),
          );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationCountProvider.notifier).getNotificationCountDetails(
            ref.read(encryptionProvider.notifier),
          );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(overallattendanceProvider.notifier).getSubjectWiseOverallAttendanceDetails(
            ref.read(encryptionProvider.notifier),
          );
    });

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(feesProvider.notifier).getFinanceDetailsApi(ref.read(encryptionProvider.notifier));
        await ref.read(feesProvider.notifier).getFeedDueDetails(ref.read(encryptionProvider.notifier));
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(calendarProvider.notifier).getCalendarDetails(ref.read(encryptionProvider.notifier));
        await ref.read(calendarProvider.notifier).getHiveCalendar('');
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(DhasboardoverallattendanceProvider.notifier).getDhasboardOverallAttendanceDetails(
              ref.read(encryptionProvider.notifier),
            );
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(transportProvider.notifier).getTransportStatusDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref.read(transportProvider.notifier).getTransportStatusHiveDetails('');
        await ref.read(transportProvider.notifier).getRouteIdDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref.read(transportProvider.notifier).getRouteIdHiveDetails(
              '',
            );
        await ref.read(transportProvider.notifier).getBoardingIdDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref.read(transportProvider.notifier).getBoardingPointHiveDetails(
              '',
            );
        await ref.read(transportProvider.notifier).gettransportRegisterDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref.read(transportProvider.notifier).getTransportHiveRegisterDetails('');
        await ref.read(transportProvider.notifier).getTransportHiveAfterRegisterDetails('');
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(hostelProvider.notifier).getHostelHiveDetails(
            '',
          );
    });

//>>>Attendance

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(notificationProvider.notifier).getNotificationDetails(
              ref.read(encryptionProvider.notifier),
            );
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(attendanceProvider.notifier).getAttendanceDetails(
              ref.read(
                encryptionProvider.notifier,
              ),
            );
        await ref.read(attendanceProvider.notifier).getHiveAttendanceDetails('');
      },
    );

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

    final cummulativeAttendance = await Hive.openBox<CumulativeAttendanceHiveData>(
      'cumulativeattendance',
    );
    if (cummulativeAttendance.isEmpty) {
      await ref.read(cummulativeAttendanceProvider.notifier).getCummulativeAttendanceDetails(
            ref.read(
              encryptionProvider.notifier,
            ),
          );
      await ref.read(cummulativeAttendanceProvider.notifier).getHiveCummulativeDetails('');
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
      await ref.read(subjectProvider.notifier).getSubjectDetails(ref.read(encryptionProvider.notifier));
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
      await ref.read(grievanceProvider.notifier).getHiveGrievanceCategoryDetails('');
    }
    await grievanceCategoryData.close();

    final grievanceSubTypeData = await Hive.openBox<GrievanceSubTypeHiveData>(
      'grievanceSubTypeData',
    );
    if (grievanceSubTypeData.isEmpty) {
      await ref.read(grievanceProvider.notifier).getGrievanceSubTypeDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref.read(grievanceProvider.notifier).getHiveGrievanceSubTypeDetails('');
    }
    await grievanceSubTypeData.close();

    final grievanceTypeData = await Hive.openBox<GrievanceTypeHiveData>(
      'grievanceTypeData',
    );
    if (grievanceTypeData.isEmpty) {
      await ref.read(grievanceProvider.notifier).getGrievanceTypeDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref.read(grievanceProvider.notifier).getHiveGrievanceTypeDetails('');
    }
    await grievanceTypeData.close();
  }

  // Future<void> showNotification(RemoteMessage message) async {
  //   await AppNotification.createNotification(
  //     title: message.notification?.title ?? '',
  //     body: message.notification?.body ?? '',
  //     networkImagePath: message.data['image'] as String?,
  //   );
  // }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _listController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(profileProvider);
    final notificatioCountprovider = ref.watch(notificationCountProvider);
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        elevation: 0,
        title: const Text(
          'Explore',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          overflow: TextOverflow.clip,
        ),
        centerTitle: true,
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                iconSize: 28,
                color: AppColors.whiteColor,
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
                              itemCount: notificatioCountprovider.notificationCountData.length,
                              controller: _listController,
                              shrinkWrap: true,
                              itemBuilder: (
                                BuildContext context,
                                int index,
                              ) {
                                return notificationCountCardDesign(
                                  index,
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // Stack(
          //   clipBehavior: Clip.none,
          //   children: [
          //     IconButton(
          //       onPressed: () {
          //         _scaffoldKey.currentState?.openEndDrawer();
          //       },
          //       icon: const Icon(
          //         Icons.menu,
          //         size: 35,
          //         color: AppColors.whiteColor,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 60 + MediaQuery.of(context).padding.bottom),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // const SizedBox(height: 20),
              // Column(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(10),
              //       child: Center(
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 if (imageBytes == '' && imageBytes.isEmpty)
              //                   const CircleAvatar(
              //                     radius: 25,
              //                     backgroundColor: AppColors.whiteColor,
              //                     child: CircleAvatar(
              //                       backgroundImage: AssetImage(
              //                         'assets/images/profile.png',
              //                       ),
              //                       radius: 48,
              //                     ),
              //                   ),
              //                 if (imageBytes != '' && imageBytes.isNotEmpty)
              //                   SizedBox(
              //                     height: 35,
              //                     width: 35,
              //                     child: ClipRRect(
              //                       borderRadius: BorderRadius.circular(50),
              //                       child: Image.memory(
              //                         imageBytes,
              //                         fit: BoxFit.cover,
              //                       ),
              //                     ),
              //                   ),
              //               ],
              //             ),
              //             Row(
              //               children: [
              //                 Row(
              //                   children: [
              //                     Stack(
              //                       clipBehavior: Clip.none,
              //                       children: [
              //                         IconButton(
              //                           iconSize: 28,
              //                           color: AppColors.whiteColor,
              //                           icon: const Icon(Icons.notifications),
              //                           onPressed: () {
              //                             Navigator.push(
              //                               context,
              //                               RouteDesign(
              //                                 route: const Theme07NotificationHomePage(),
              //                               ),
              //                             );
              //                           },
              //                         ),
              //                         if (notificatioCountprovider.notificationCountData.isEmpty)
              //                           Positioned(
              //                             right: 2,
              //                             top: 2,
              //                             child: Container(
              //                               padding: const EdgeInsets.all(5),
              //                               decoration: const BoxDecoration(
              //                                 color: Colors.red,
              //                                 shape: BoxShape.circle,
              //                               ),
              //                               constraints: const BoxConstraints(
              //                                 minWidth: 20,
              //                                 minHeight: 20,
              //                               ),
              //                               child: SizedBox(
              //                                 width: 5,
              //                                 child: Column(
              //                                   children: [
              //                                     if (notificatioCountprovider.notificationCountData.isNotEmpty)
              //                                       ListView.builder(
              //                                         itemCount:
              //                                             notificatioCountprovider.notificationCountData.length,
              //                                         controller: _listController,
              //                                         shrinkWrap: true,
              //                                         itemBuilder: (
              //                                           BuildContext context,
              //                                           int index,
              //                                         ) {
              //                                           return notificationCountCardDesign(
              //                                             index,
              //                                           );
              //                                         },
              //                                       ),
              //                                   ],
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                       ],
              //                     ),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: [
              //                     Stack(
              //                       clipBehavior: Clip.none,
              //                       children: [
              //                         IconButton(
              //                           onPressed: () {
              //                             _scaffoldKey.currentState?.openEndDrawer();
              //                           },
              //                           icon: const Icon(
              //                             Icons.menu,
              //                             size: 35,
              //                             color: AppColors.whiteColor,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),

              //     // T I T L E   B A R
              //     if ('${provider.profileDataHive.studentname}' != '')
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           const Text(
              //             'Hello, ',
              //             style: TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.bold,
              //               color: AppColors.whiteColor,
              //             ),
              //           ),
              //           Text(
              //             '${provider.profileDataHive.studentname}' == ''
              //                 ? ''
              //                 : '${provider.profileDataHive.studentname}',
              //             style: const TextStyle(
              //               fontSize: 19,
              //               fontWeight: FontWeight.bold,
              //               color: AppColors.whiteColor,
              //             ),
              //           ),
              //         ],
              //       )
              //     else
              //       const Text(
              //         '',
              //         style: TextStyle(
              //           fontSize: 22,
              //           fontWeight: FontWeight.bold,
              //           color: AppColors.whiteColor,
              //         ),
              //       ),
              //     const SizedBox(
              //       height: 10,
              //     ),
              //     const Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text(
              //           'Welcome to ',
              //           style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.bold,
              //             color: AppColors.whiteColor,
              //           ),
              //         ),
              //         Text(
              //           'SRM Portal',
              //           style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.bold,
              //             color: AppColors.whiteColor,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),

              // const SizedBox(
              //   height: 50,
              // ),

              // W I D G E T S
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // R O W   1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // P R O F I L E   W I D G E T
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
                          child: SizedBox(
                            height: width * 0.29,
                            width: width * 0.29,
                            child: ElevatedButton(
                              style: BorderBoxButtonDecorations.homePageButtonStyle,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  RouteDesign(
                                    route: const Theme07ProfilePage(),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    child: Image.asset(
                                      'assets/images/profile07.png',
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Text(
                                    'Profile',
                                    textAlign: TextAlign.center,
                                    style: width > 400
                                        ? TextStyles.smallBlackColorFontStyle
                                        : TextStyles.smallerBlackColorFontStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // F E E S   W I D G E T
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
                          child: SizedBox(
                            height: width * 0.29,
                            width: width * 0.29,
                            child: ElevatedButton(
                              style: BorderBoxButtonDecorations.homePageButtonStyle,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  RouteDesign(
                                    route: const Theme007FeesPage(),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    child: Image.asset(
                                      'assets/images/fees.png',
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Text(
                                    'Fee',
                                    textAlign: TextAlign.center,
                                    style: width > 400
                                        ? TextStyles.smallBlackColorFontStyle
                                        : TextStyles.smallerBlackColorFontStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // A C A D E M I C   W I D G E T
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
                          child: SizedBox(
                            height: width * 0.29,
                            width: width * 0.29,
                            child: ElevatedButton(
                              style: BorderBoxButtonDecorations.homePageButtonStyle,
                              onPressed: () {
                                ref.read(feesProvider.notifier).setFeesNavString('Online Trans');
                                Navigator.push(
                                  context,
                                  RouteDesign(
                                    route: const Theme07AcademicsHomePage(),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    child: Image.asset(
                                      'assets/images/academics.png',
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Text(
                                    'Academics',
                                    textAlign: TextAlign.center,
                                    style: width > 400
                                        ? TextStyles.smallBlackColorFontStyle
                                        : TextStyles.smallerBlackColorFontStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // R O W   2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // L I B R A R Y   W I D G E T
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
                          child: SizedBox(
                            height: width * 0.29,
                            width: width * 0.29,
                            child: ElevatedButton(
                              style: BorderBoxButtonDecorations.homePageButtonStyle,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  RouteDesign(
                                    route: const Theme07LibraryHomePage(),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    child: Image.asset(
                                      'assets/images/library.png',
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Text(
                                    'Library',
                                    textAlign: TextAlign.center,
                                    style: width > 400
                                        ? TextStyles.smallBlackColorFontStyle
                                        : TextStyles.smallerBlackColorFontStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // H O S T E L   W I D G E T
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
                          child: SizedBox(
                            height: width * 0.29,
                            width: width * 0.29,
                            child: ElevatedButton(
                              style: BorderBoxButtonDecorations.homePageButtonStyle,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  RouteDesign(
                                    route: const Theme07HostelHomePage(),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    child: Image.asset(
                                      'assets/images/hostel.png',
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Text(
                                    'Hostel',
                                    textAlign: TextAlign.center,
                                    style: width > 400
                                        ? TextStyles.smallBlackColorFontStyle
                                        : TextStyles.smallerBlackColorFontStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // T R A N S P O R T   W I D G E T
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
                          child: SizedBox(
                            height: width * 0.29,
                            width: width * 0.29,
                            child: ElevatedButton(
                              style: BorderBoxButtonDecorations.homePageButtonStyle,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  RouteDesign(
                                    route: const Theme07TransportRegisterPage(),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    child: Image.asset(
                                      'assets/images/transport.png',
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Text(
                                    'Transport',
                                    textAlign: TextAlign.center,
                                    style: width > 400
                                        ? TextStyles.smallBlackColorFontStyle
                                        : TextStyles.smallerBlackColorFontStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // R O W   3
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // G R I E V A N C E   W I D G E T
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
                          child: SizedBox(
                            height: width * 0.29,
                            width: width * 0.29,
                            child: ElevatedButton(
                              style: BorderBoxButtonDecorations.homePageButtonStyle,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  RouteDesign(
                                    route: const Theme07GrievanceHomePage(),
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    child: Image.asset(
                                      'assets/images/grievances.png',
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Text(
                                    'Grievances',
                                    textAlign: TextAlign.center,
                                    style: width > 400
                                        ? TextStyles.smallBlackColorFontStyle
                                        : TextStyles.smallerBlackColorFontStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // P A S S W O R D   W I D G E T
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
                          child: SizedBox(
                            height: width * 0.29,
                            width: width * 0.29,
                            child: ElevatedButton(
                              style: BorderBoxButtonDecorations.homePageButtonStyle,
                              onPressed: () {
                                Navigator.push(context, RouteDesign(route: const Theme07ChangePasswordPage()));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    child: Image.asset(
                                      'assets/images/changepassword07.png',
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Text(
                                    'Password',
                                    textAlign: TextAlign.center,
                                    style: width > 400
                                        ? TextStyles.smallBlackColorFontStyle
                                        : TextStyles.smallerBlackColorFontStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // SizedBox for next widget
                        SizedBox(width: width * 0.29),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // endDrawer: const Theme07DrawerDesign(),
      // bottomNavigationBar: const BottomBar(),
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
              color: Colors.white,
              fontSize: 12,
            ),
          ),
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
