import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:d_chart/d_chart.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hive/hive.dart';
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
import 'package:sample/home/main_pages/academics/subject_pages/model/subject_responce_hive_model.dart';
import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_state.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_category_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_subtype_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_type_hive_model.dart';
import 'package:sample/home/main_pages/grievances/riverpod/grievance_state.dart';
import 'package:sample/home/main_pages/transport/riverpod/transport_state.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:sample/network/riverpod/network_state.dart';
import 'package:sample/notification.dart';
import 'package:sample/theme-02/mainscreens/hostel/theme_02_hostel_register.dart';
import 'package:sample/theme-02/mainscreens/transport/transport_register.dart';

class Theme05dhasboardPage extends ConsumerStatefulWidget {
  const Theme05dhasboardPage({super.key});

  @override
  ConsumerState createState() => _Theme05dhasboardPageState();
}

class _Theme05dhasboardPageState extends ConsumerState<Theme05dhasboardPage>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      SystemChrome.setSystemUIOverlayStyle(
        StatusBarNavigationBarDesigns.statusBarNavigationBarDesign,
      );
    }
  }

  bool _isVisible = true;

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
    ref.watch(attendanceProvider);
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
      backgroundColor: AppColors.primaryColor2,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor,
                AppColors.primaryColor,
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
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Navigator.pop(
                              context,
                            );
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_sharp,
                            color: AppColors.whiteColor,
                            size: 30,
                          ),
                        ),

                        const Spacer(), // Pushes the next widgets to the right
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            IconButton(
                              iconSize: 25,
                              color: Colors.white,
                              icon: const Icon(Icons.notifications),
                              onPressed: () {},
                            ),
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
                                child: const Center(
                                  child: Text(
                                    '2',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Center(
                  //   child: Row(
                  //     children: [
                  //       GestureDetector(
                  //         onTap: () async {
                  //           Navigator.pop(
                  //             context,
                  //           );
                  //         },
                  //         child: const Icon(
                  //           Icons.arrow_back_ios_sharp,
                  //           color: AppColors.whiteColor,
                  //           size: 30,
                  //         ),
                  //       ),
                  //       if (imageBytes == '' && imageBytes.isEmpty)
                  //         const CircleAvatar(
                  //           radius: 25,
                  //           backgroundColor: AppColors.whiteColor,
                  //           child: CircleAvatar(
                  //             backgroundImage: AssetImage(
                  //               'assets/images/profile.png',
                  //             ),
                  //             radius: 48,
                  //           ),
                  //         ),
                  //       if (imageBytes != '' && imageBytes.isNotEmpty)
                  //         SizedBox(
                  //           height: 45,
                  //           width: 45,
                  //           child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(50),
                  //             child: Image.memory(
                  //               imageBytes,
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //       Stack(
                  //         clipBehavior: Clip.none,
                  //         children: [
                  //           IconButton(
                  //             iconSize: 35,
                  //             color: Colors.white,
                  //             icon: const Icon(Icons.notifications),
                  //             onPressed: () {},
                  //           ),
                  //           Positioned(
                  //             right: 2,
                  //             top: 2,
                  //             child: Container(
                  //               padding: const EdgeInsets.all(5),
                  //               decoration: const BoxDecoration(
                  //                 color: Colors.red,
                  //                 shape: BoxShape.circle,
                  //               ),
                  //               constraints: const BoxConstraints(
                  //                 minWidth: 20,
                  //                 minHeight: 20,
                  //               ),
                  //               child: const Center(
                  //                 child: Text(
                  //                   '2',
                  //                   style: TextStyle(
                  //                     color: Colors.white,
                  //                     fontSize: 12,
                  //                   ),
                  //                   textAlign: TextAlign.center,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
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
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Notice Board',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.paste_rounded,
                              size: 32,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'Regarding fee payment for academic year 2024-25',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent.withOpacity(0.8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.redAccent.withOpacity(0.5),
                                    blurRadius: 12,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'New',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Divider(
                          height: 1,
                          color: AppColors.redColor.withOpacity(0.5),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.paste_rounded,
                              size: 32,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'Regarding fee payment for academic year 2024-25',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent.withOpacity(0.8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.redAccent.withOpacity(0.5),
                                    blurRadius: 12,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'New',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E7FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  const Color.fromARGB(255, 228, 92, 151),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'More info',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 320,
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
                          color: Colors.grey.withOpacity(0.2),
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Registrations',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E7FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF4A56E2),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Exam Registration',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E7FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                RouteDesign(
                                  // route: const TransportRegisterPage(),
                                  route: const Theme02TransportRegisterPage(),
                                ),
                              );
                              await ref
                                  .read(transportProvider.notifier)
                                  .gettransportRegisterDetails(
                                    ref.read(encryptionProvider.notifier),
                                  );
                              await ref
                                  .read(transportProvider.notifier)
                                  .getRouteIdDetails(
                                    ref.read(encryptionProvider.notifier),
                                  );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF4A56E2),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Transport Registration',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E7FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                RouteDesign(
                                  route: const Theme02RegistrationPage(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF4A56E2),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Hostel Registration',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E7FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF4A56E2),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Staff Assessment',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
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
    );
  }

  Widget cardDesign(int index) {
    final provider = ref.watch(attendanceProvider);
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
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
        AspectRatio(
          aspectRatio: 13 / 9,
          child: DChartBarO(
            groupList: [
              OrdinalGroup(
                id: '1',
                color: AppColors.primaryColor,
                data: List.generate(
                  provider.attendancehiveData.length,
                  (index) => OrdinalData(
                    domain: '${provider.attendancehiveData[index].subjectcode}',
                    measure:
                        provider.attendancehiveData[index].presentpercentage ==
                                ''
                            ? 0.0
                            : double.parse(
                                  '${provider.attendancehiveData[index].presentpercentage}',
                                ) *
                                (7 / 7),
                  ),
                ),
              ),
            ],
            domainAxis: DomainAxis(
              lineStyle: LineStyle(
                color: AppColors.primaryColor,
                thickness: 2,
              ),
              labelRotation: 45,
              minimumPaddingBetweenLabels: 50,
            ),
          ),
        ),
      ],
    );
  }

  Widget cardDesignAttendanceHrs() {
    final provider = ref.watch(attendanceProvider);

    final totalPresent = provider.attendancehiveData.fold<int>(
      0,
      (sum, item) => sum + (int.tryParse(item.present ?? '0') ?? 0),
    );

    final totalAbsent = provider.attendancehiveData.fold<int>(
      0,
      (sum, item) => sum + (int.tryParse(item.absent ?? '0') ?? 0),
    );

    final totalall = provider.attendancehiveData.fold<int>(
      0,
      (sum, item) => sum + (int.tryParse(item.total ?? '0') ?? 0),
    );

    final totalSessions = totalPresent + totalAbsent;
    final attendancePercentage =
        totalSessions > 0 ? (totalPresent / totalSessions) : 0.0;

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
            percent: attendancePercentage,
            center: Text(
              '${(attendancePercentage * 100).toStringAsFixed(1)}%',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),
            progressColor: attendancePercentage < 0.5
                ? Colors.red
                : (attendancePercentage < 0.75 ? Colors.yellow : Colors.blue),
            backgroundColor: AppColors.blackColor.withOpacity(0.2),
            circularStrokeCap: CircularStrokeCap.round,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(
                Icons.group,
                color: AppColors.primaryColor,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                'Total: $totalall',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor2,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.how_to_reg,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Present: $totalPresent',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon(
                Icons.person_off,
                color: AppColors.primaryColor,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                'Absent: $totalAbsent',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
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
