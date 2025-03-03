


import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:d_chart/d_chart.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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
import 'package:sample/notification.dart';
import 'package:sample/theme-02/mainscreens/fees/fees_due_page.dart';
import 'package:sample/theme-02/mainscreens/hostel/theme_02_hostel_register.dart';
import 'package:sample/theme-02/mainscreens/transport/transport_register.dart';
import 'package:sample/theme-02/notification_page.dart';
import 'package:sample/theme-02/time_table_page.dart';
import 'package:sample/theme-07/notification_homepage.dart';
import 'package:sample/theme-07/widget/drawer.dart';

class Theme07dhasboardPage extends ConsumerStatefulWidget {
  const Theme07dhasboardPage({super.key});

  @override
  ConsumerState createState() => _Theme07dhasboardPageState();
}

class _Theme07dhasboardPageState extends ConsumerState<Theme07dhasboardPage>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      SystemChrome.setSystemUIOverlayStyle(
        StatusBarNavigationBarDesigns.statusBarNavigationBarDesign,
      );
    }
  }

  // bool _isVisible = true;

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
      ref
          .read(overallattendanceProvider.notifier)
          .getSubjectWiseOverallAttendanceDetails(
            ref.read(encryptionProvider.notifier),
          );
    });

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref
            .read(feesProvider.notifier)
            .getFinanceDetailsApi(ref.read(encryptionProvider.notifier));
        await ref
            .read(feesProvider.notifier)
            .getFeedDueDetails(ref.read(encryptionProvider.notifier));
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref
            .read(calendarProvider.notifier)
            .getCalendarDetails(ref.read(encryptionProvider.notifier));
        await ref.read(calendarProvider.notifier).getHiveCalendar('');
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref
            .read(DhasboardoverallattendanceProvider.notifier)
            .getDhasboardOverallAttendanceDetails(
                ref.read(encryptionProvider.notifier),);
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(transportProvider.notifier).getTransportStatusDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref
            .read(transportProvider.notifier)
            .getTransportStatusHiveDetails('');
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
        await ref
            .read(transportProvider.notifier)
            .getTransportHiveRegisterDetails('');
        await ref
            .read(transportProvider.notifier)
            .getTransportHiveAfterRegisterDetails('');
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
        await ref
            .read(attendanceProvider.notifier)
            .getHiveAttendanceDetails('');
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

  final ScrollController _listController = ScrollController();

  String? selectedDomain;
  double? selectedMeasure;
  Offset? tooltipPosition;
  bool showTooltip = false;


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ref
      ..watch(attendanceProvider)
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

    final providerProfile = ref.watch(profileProvider);
    final base64Image = '${providerProfile.profileDataHive.studentphoto}';
    final imageBytes = base64Decode(base64Image);
    final provider = ref.watch(cgpaProvider);
    final sgpaprovider = ref.watch(sgpaProvider);
    final notificatioCountprovider = ref.watch(notificationCountProvider);
    final Feesdhasboardprovider = ref.watch(feesDhasboardProvider);
    ref.watch(hostelProvider);
    final calenderprovider = ref.watch(calendarProvider);
    log('student semester id >>> ${TokensManagement.semesterId}');

    return Scaffold(
       key: _scaffoldKey,
      backgroundColor: AppColors.theme07secondaryColor,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.theme07secondaryColor,
                AppColors.theme07secondaryColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                      color: AppColors.theme07primaryColor,
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
                                    if (notificatioCountprovider
                                        .notificationCountData.isEmpty)
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
                                          child:
                            
                                              SizedBox(
                                            width: 5,
                                            child: Column(
                                              children: [
                                               
                                                if (notificatioCountprovider
                                                    .notificationCountData
                                                    .isNotEmpty)
                                                  ListView.builder(
                                                    itemCount:
                                                        notificatioCountprovider
                                                            .notificationCountData
                                                            .length,
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
                              ],
                            ),
                             Row(
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                   IconButton(
                                          onPressed: () { 
                                             _scaffoldKey.currentState?. openEndDrawer();
                                          },
                                          icon:  Icon(
                                            Icons.menu,
                                            size: 35,
                                            color: AppColors.theme07primaryColor,
                                          ),
                                        ),
                                   
                                  ],
                                ),
                              ],
                            ),
                            
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
                       Text(
                        'Hello, ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.theme07primaryColor,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          TokensManagement.studentName == ''
                              ? '-'
                              : TokensManagement.studentName,
                          style:  TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme07primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                   Row(
                    children: [
                      Text(
                        'Welcome...!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.theme07primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity( 0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                             Icon(
                              Icons.campaign_rounded,
                              size: 40,
                              color: AppColors.theme07primaryColor,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "Today's Status",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: calenderprovider
                                    .calendarCurrentDateData.length,
                                controller: _listController,
                                shrinkWrap: true,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  final formattedDate =
                                      DateFormat('dd-MM-yyyy')
                                          .format(DateTime.now());
                                  log('date >>> ${calenderprovider.calendarHiveData[index].date}');
                                  log('date to string >>> $formattedDate');
                                  return calenderStatuscardDesign(index); 
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  SizedBox(
                    height: 340,
                    width: double.infinity,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: cardDesign(1),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity( 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        cardDesignAttendanceHrs(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        RouteDesign(
                          route: const Theme02FeesDuePage(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity( 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Container(
                        // width: 180,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.white, Colors.white],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon Section
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Icon(
                                Icons.account_balance_wallet_rounded,
                                color: AppColors.theme02secondaryColor1,
                                size: 40,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Title Section
                            const Text(
                              'Current Due',
                              style: TextStyle(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),

                            SizedBox(
                              width: 200,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.redColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    if (provider is FeesDhasboardLoading)
                                      Center(
                                        child: CircularProgressIndicators
                                            .primaryColorProgressIndication,
                                      )
                                    else if (Feesdhasboardprovider
                                            .feesDueDhasboardData.isEmpty &&
                                        provider is! FeesDhasboardLoading)
                                      const Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              'No Data!',
                                              style: TextStyles.fontStyle1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (Feesdhasboardprovider
                                        .feesDueDhasboardData.isNotEmpty)
                                      ListView.builder(
                                        itemCount: Feesdhasboardprovider
                                            .feesDueDhasboardData.length,
                                        controller: _listController,
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
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity( 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // SGPA Card
                          Container(
                            width: 130,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade300,
                                  Colors.blueAccent.shade700,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.shade200
                                      .withOpacity( 0.6),
                                  blurRadius: 12,
                                  offset: const Offset(4, 4),
                                ),
                                BoxShadow(
                                  color:Colors.white.withOpacity(0.8),
                                  blurRadius: 12,
                                  offset: const Offset(-4, -4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Icon Section
                                const Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: Icon(
                                    Icons.school_rounded,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Title Section
                                const Text(
                                  'S.G.P.A',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: 100,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        if (sgpaprovider is SgpaLoading)
                                          Center(
                                            child: CircularProgressIndicators
                                                .primaryColorProgressIndication,
                                          )
                                        else if (sgpaprovider
                                                .sgpaData.isEmpty &&
                                            sgpaprovider is! CgpaLoading)
                                          const Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  'No Data!',
                                                  style: TextStyles.fontStyle1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        if (sgpaprovider.sgpaData.isNotEmpty)
                                          ListView.builder(
                                            itemCount:
                                                sgpaprovider.sgpaData.length,
                                            controller: _listController,
                                            shrinkWrap: true,
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
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          // CGPA Card
                          Container(
                            width: 130,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.purple.shade300,
                                  Colors.purpleAccent.shade700,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.shade200
                                      .withOpacity( 0.6),
                                  blurRadius: 12,
                                  offset: const Offset(4, 4),
                                ),
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.8),
                                  blurRadius: 12,
                                  offset: const Offset(-4, -4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Icon Section
                                const Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: Icon(
                                    Icons.bar_chart_rounded,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Title Section
                                const Text(
                                  'C.G.P.A',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: 100,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        if (provider is CgpaLoading)
                                          Center(
                                            child: CircularProgressIndicators
                                                .primaryColorProgressIndication,
                                          )
                                        else if (provider.cgpaData.isEmpty &&
                                            provider is! CgpaLoading)
                                          const Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  'No Data!',
                                                  style: TextStyles.fontStyle1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        if (provider.cgpaData.isNotEmpty)
                                          ListView.builder(
                                            itemCount: provider.cgpaData.length,
                                            controller: _listController,
                                            shrinkWrap: true,
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
                                // Value Section

                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity( 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Current Activities',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF4A56E2),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // SGPA Card
                                    // if (hostelprovider
                                    //         .hostelRegisterDetails.regconfig ==
                                    //     '1')
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          RouteDesign(
                                            route:
                                                const Theme02RegistrationPage(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 130,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.green
                                                  .shade400, // Fresh green
                                              Colors.blue.shade300, // Sky blue
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blue.shade200
                                                  .withOpacity(0.6),
                                              blurRadius: 12,
                                              offset: const Offset(4, 4),
                                            ),
                                            BoxShadow(
                                              color: Colors.white
                                                  .withOpacity( 0.8),
                                              blurRadius: 12,
                                              offset: const Offset(-4, -4),
                                            ),
                                          ],
                                        ),
                                        child: const Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Icon Section

                                             Padding(
                                              padding: EdgeInsets.only(top: 12),
                                              child: Icon(
                                                Icons.hotel_sharp,
                                                color: Colors.white,
                                                size: 36,
                                              ),
                                            ),
                                             SizedBox(height: 8),

                                             Text(
                                              'Hostel',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                             SizedBox(height: 5),
                                             Text(
                                              'Registration',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                             SizedBox(height: 16),
                                          ],
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 20),
                                    // if (hostelprovider
                                    //         .hostelRegisterDetails.regconfig ==
                                    //     '1')
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          RouteDesign(
                                            route:
                                                const Theme02TransportRegisterPage(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 130,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.lightBlue
                                                  .shade300, // Light aqua
                                              Colors.teal.shade500, // Deep teal
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.purple.shade200
                                                  .withOpacity( 0.6),
                                              blurRadius: 12,
                                              offset: const Offset(4, 4),
                                            ),
                                            BoxShadow(
                                              color: Colors.white
                                                  .withOpacity( 0.8),
                                              blurRadius: 12,
                                              offset: const Offset(-4, -4),
                                            ),
                                          ],
                                        ),
                                        child: const Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Icon Section
                                            Padding(
                                              padding: EdgeInsets.only(top: 12),
                                              child: Icon(
                                                Icons.emoji_transportation,
                                                color: Colors.white,
                                                size: 36,
                                              ),
                                            ),
                                            SizedBox(height: 8),

                                            Text(
                                              'Transport',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              'Registration',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // SGPA Card

                                    Container(
                                      width: 130,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.cyan.shade400, // Cool cyan
                                            Colors
                                                .indigo.shade500, // Rich indigo
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blue.shade200
                                                .withOpacity( 0.6),
                                            blurRadius: 12,
                                            offset: const Offset(4, 4),
                                          ),
                                          BoxShadow(
                                            color: Colors.white
                                                .withOpacity( 0.8),
                                            blurRadius: 12,
                                            offset: const Offset(-4, -4),
                                          ),
                                        ],
                                      ),
                                      child: const Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Icon Section
                                          Padding(
                                            padding: EdgeInsets.only(top: 12),
                                            child: Icon(
                                              Icons.app_registration_rounded,
                                              color: Colors.white,
                                              size: 36,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          // Title Section
                                          Text(
                                            'Exam',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Registration',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 20),

                                    // CGPA Card
                                    Container(
                                      width: 130,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.cyan.shade400, // Cool cyan
                                            Colors
                                                .indigo.shade500, // Rich indigo
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.purple.shade200
                                                .withOpacity( 0.6),
                                            blurRadius: 12,
                                            offset: const Offset(4, 4),
                                          ),
                                          BoxShadow(
                                            color: Colors.white
                                                .withOpacity( 0.8),
                                            blurRadius: 12,
                                            offset: const Offset(-4, -4),
                                          ),
                                        ],
                                      ),
                                      child: const Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Icon Section
                                          Padding(
                                            padding: EdgeInsets.only(top: 12),
                                            child: Icon(
                                              Icons.assessment,
                                              color: Colors.white,
                                              size: 36,
                                            ),
                                          ),
                                          SizedBox(height: 8),

                                          Text(
                                            'Staff',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Assessment',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      endDrawer: const Theme07DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final provider = ref.watch(attendanceProvider);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Course wise attendance (%)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 13 / 9,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (details) {
                    setState(() {
                      tooltipPosition = details.localPosition;
                      showTooltip = true;
                    });
                  },
                  child: DChartBarO(
                    groupList: [
                      OrdinalGroup(
                        id: '1',
                        color: AppColors.theme07primaryColor,
                        data: List.generate(
                          provider.attendancehiveData.length,
                          (index) {
                            final percentage = provider
                                        .attendancehiveData[index]
                                        .presentpercentage ==
                                    ''
                                ? 0.0
                                : double.parse(
                                    '${provider.attendancehiveData[index].presentpercentage}',
                                  );

                            return OrdinalData(
                              domain:
                                  '${provider.attendancehiveData[index].subjectcode}',
                              measure: percentage * (7 / 7),
                              color: percentage < 75
                                  ? AppColors.redColor // Color for <75%
                                  : AppColors.primaryColor2, // Default color
                            );
                          },
                        ),
                      ),
                    ],
                    domainAxis: const DomainAxis(
                      lineStyle: LineStyle(
                        color: AppColors.primaryColor2,
                        thickness: 2,
                      ),
                      labelRotation: 55,
                      minimumPaddingBetweenLabels: 50,
                    ),
                    onChangedListener: (OrdinalData data) {
                      setState(() {
                        selectedDomain = data.domain;
                        selectedMeasure = data.measure as double?;
                      });
                    },
                  ),
                ),
              ),
              if (showTooltip &&
                  selectedDomain != null &&
                  tooltipPosition != null)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  left: tooltipPosition!.dx - 30,
                  // Centering adjustment
                  top: tooltipPosition!.dy - 60,
                  // Adjust height above the bar
                  child: Material(
                    color: Colors.transparent,
                    child: AnimatedOpacity(
                      opacity: 1,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${selectedMeasure!.toStringAsFixed(2)}%',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
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
            provider.DhasboardOverallattendanceData.first.totalpresenthours ??
                '0',) ??
        0;
    final absent = int.tryParse(
            provider.DhasboardOverallattendanceData.first.absentcnt ?? '0',) ??
        0;
    final absentper = double.tryParse(
            provider.DhasboardOverallattendanceData.first.absentper ?? '0',) ??
        0.0;

    final totalSessions = present + absent;
    final overallPercentage =
        totalSessions > 0 ? (present / totalSessions * 100) : 0.0;
    final presentPercentage =
        totalSessions > 0 ? (present / totalSessions) : 0.0;
    final absentPercentage = totalSessions > 0 ? (absent / totalSessions) : 0.0;

    log('Present % >>> $presentPercentage');
    log('Overall % >>> $overallPercentage');
    log('Absent % >>> $absentper');

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Attendance Hours',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 20),
          CircularPercentIndicator(
            radius: 60,
            lineWidth: 10,
            percent: 1,
            center: Stack(
              children: [
                CircularPercentIndicator(
                  radius: 60,
                  lineWidth: 10,
                  percent: presentPercentage,
                  progressColor: Colors.green,
                  backgroundColor: Colors.transparent,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                CircularPercentIndicator(
                  radius: 60,
                  lineWidth: 10,
                  percent: absentPercentage,
                  progressColor: Colors.red,
                  backgroundColor: Colors.transparent,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ],
            ),
            backgroundColor: Colors.black26,
            circularStrokeCap: CircularStrokeCap.round,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.group, color: AppColors.theme02buttonColor2, size: 20),
              const SizedBox(width: 10),
              Text(
                'Total: $totalSessions',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.how_to_reg,
                  color: AppColors.theme02buttonColor2, size: 20,),
              const SizedBox(width: 10),
              Text(
                'Present: $present',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.person_off,
                  color: AppColors.theme02buttonColor2, size: 20,),
              const SizedBox(width: 10),
              Text(
                'Absent: $absent',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.percent,
                  color: AppColors.theme02buttonColor2, size: 20,),
              const SizedBox(width: 10),
              Text(
                'Overall % : ${overallPercentage.toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget cardDesignOverallAttendanceHrs(int index) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(overallattendanceProvider);
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Total',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.OverallattendanceData[index].total}' ==
                                'null'
                            ? '-'
                            : '''${provider.OverallattendanceData[index].total}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'ml',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.OverallattendanceData[index].ml}' == 'null'
                            ? '-'
                            : '''${provider.OverallattendanceData[index].ml}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'subjectdesc',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.OverallattendanceData[index].subjectdesc}' ==
                                'null'
                            ? '-'
                            : '''${provider.OverallattendanceData[index].subjectdesc}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'subjectcode',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.OverallattendanceData[index].subjectcode}' ==
                                'null'
                            ? '-'
                            : '''${provider.OverallattendanceData[index].subjectcode}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'mLODper',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.OverallattendanceData[index].mLODper}' ==
                                'null'
                            ? '-'
                            : '''${provider.OverallattendanceData[index].mLODper}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'absent',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.OverallattendanceData[index].absent}' ==
                                'null'
                            ? '-'
                            : '''${provider.OverallattendanceData[index].absent}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'present',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.OverallattendanceData[index].present}' ==
                                'null'
                            ? '-'
                            : '''${provider.OverallattendanceData[index].present}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'overallpercent',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.OverallattendanceData[index].overallpercent}' ==
                                'null'
                            ? '-'
                            : '''${provider.OverallattendanceData[index].overallpercent}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'presentper',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.OverallattendanceData[index].presentper}' ==
                                'null'
                            ? '-'
                            : '''${provider.OverallattendanceData[index].presentper}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cgpacardDesign(int index) {
    final provider = ref.watch(cgpaProvider);
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Text(
            '${provider.cgpaData[index].cgpa}' == 'null'
                ? '-'
                : '''${provider.cgpaData[index].cgpa}''',
            style: TextStyle(
              color: Colors.purpleAccent.shade700,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget sgpacardDesign(int index) {
    final sgpaprovider = ref.watch(sgpaProvider);
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Text(
            '${sgpaprovider.sgpaData[index].attrvalue}' == 'null'
                ? '-'
                : '''${sgpaprovider.sgpaData[index].attrvalue}''',
            style: TextStyle(
              color: Colors.blueAccent.shade700,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
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
            '${notificatioCountprovider.notificationCountData[index].unreadnotificationcount}' ==
                    'null'
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

  Widget feesdhasboardcardDesign(int index) {
    final feescurrendDataProvider = ref.watch(feesDhasboardProvider);
    log('${feescurrendDataProvider.feesDueDhasboardData[index].currentdue}');
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Text(
            '${feescurrendDataProvider.feesDueDhasboardData[index].currentdue}' ==
                    'null'
                ? '-'
                : '''Rs. ${feescurrendDataProvider.feesDueDhasboardData[index].currentdue}''',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
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
        // ref.read(lmsProvider.notifier).getLmsTitleDetails(
        //       ref.read(encryptionProvider.notifier),
        //       '${provider.lmsSubjectData[index].subjectid}',
        //     );
        Navigator.push(
          context,
          RouteDesign(route: const Theme02NotificationPage()),
        );
      },
      child: Container(
        // decoration: BoxDecoration(
        //
        //   borderRadius: BorderRadius.circular(12),
        //   color: const Color(0xFFF3F4F6),
        // ),
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
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.blue,
                  //     blurRadius: 4,
                  //     offset: const Offset(0, 4),
                  //   ),
                  // ],
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
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(height: 5),
              Row(
                children: [
                   Icon(
                    Icons.calendar_today,
                    color: AppColors.theme07primaryColor,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${provider.calendarCurrentDateData[index].date}' == ''
                        ? 'No Data'
                        : '${provider.calendarCurrentDateData[index].date}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
             
              Row(
                children: [
                   Icon(
                    Icons.info_outline,
                color: AppColors.theme07primaryColor,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${provider.calendarCurrentDateData[index].daystatus}' ==
                            ''
                        ? 'No Data'
                        : '${provider.calendarCurrentDateData[index].daystatus}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ],
          ),
          if (provider.calendarCurrentDateData[index].daystatus != 'Holiday')
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  gradient:  LinearGradient(
                    colors: [  AppColors.theme07primaryColor,  AppColors.theme07primaryColor,],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme02TimetablePageScreen(),
                        // route: const StudentLoginPage(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'View Timetable',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
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
